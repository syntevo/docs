#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

MAIN_REF="${MAIN_REF:-origin/main}"
MAIN_EXPORT="${MAIN_EXPORT:-/tmp/origin-main-export}"
BUILD_DIR="${BUILD_DIR:-/tmp/docs-build}"
SITE_DIR="${SITE_DIR:-/tmp/site}"
BUNDLE_PATH="${BUNDLE_PATH:-/tmp/docs-bundle}"
FETCH_ORIGIN="${FETCH_ORIGIN:-0}"
PREBUILT_GEMFILE="${PREBUILT_GEMFILE:-/opt/jekyll/Gemfile}"
PREBUILT_GEMFILE_LOCK="${PREBUILT_GEMFILE_LOCK:-/opt/jekyll/Gemfile.lock}"
PREBUILT_BUNDLE_PATH="${PREBUILT_BUNDLE_PATH:-/opt/jekyll-bundle}"

LEGACY_SMARTGIT_VERSIONS=(
  "6.5" "7.0" "7.1" "8.0" "17.0" "17.1" "18.1" "18.2"
  "19.1" "20.1" "20.2" "21.1" "21.2" "22.1"
)

LEGACY_SMARTSVN_VERSIONS=("14.0" "14.1")

log() {
  printf '[build] %s\n' "$*"
}

die() {
  printf '[build] ERROR: %s\n' "$*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

resolve_ref() {
  local ref
  for ref in "$@"; do
    if git -C "${REPO_ROOT}" rev-parse --verify --quiet "${ref}^{commit}" >/dev/null; then
      printf '%s\n' "${ref}"
      return 0
    fi
  done
  return 1
}

copy_dir_contents() {
  local src="$1"
  local dest="$2"

  [[ -d "${src}" ]] || die "Source directory does not exist: ${src}"
  mkdir -p "${dest}"
  cp -a "${src}/." "${dest}/"
}

path_component_count() {
  python3 - "$1" <<'PY'
import sys
path = sys.argv[1].strip("/")
print(0 if not path else len(path.split("/")))
PY
}

extract_git_tree() {
  local ref="$1"
  local tree_path="$2"
  local dest="$3"
  local strip_components

  if ! git -C "${REPO_ROOT}" cat-file -e "${ref}:${tree_path}" 2>/dev/null; then
    log "Skipping missing tree ${ref}:${tree_path}"
    return 0
  fi

  strip_components="$(path_component_count "${tree_path}")"
  mkdir -p "${dest}"
  git -C "${REPO_ROOT}" archive "${ref}" "${tree_path}" | tar -x -C "${dest}" --strip-components "${strip_components}"
}

refresh_origin_main_export() {
  if [[ "${FETCH_ORIGIN}" == "1" ]]; then
    log "Fetching updated refs from origin"
    git -C "${REPO_ROOT}" fetch --prune origin
  fi

  git -C "${REPO_ROOT}" rev-parse --verify --quiet "${MAIN_REF}^{commit}" >/dev/null \
    || die "Could not resolve ref: ${MAIN_REF}"

  log "Exporting ${MAIN_REF} to ${MAIN_EXPORT}"
  rm -rf "${MAIN_EXPORT}"
  mkdir -p "${MAIN_EXPORT}"
  git -C "${REPO_ROOT}" archive --format=tar "${MAIN_REF}" | tar -x -C "${MAIN_EXPORT}"
}

prepare_build_directories() {
  log "Preparing build directories"
  rm -rf "${BUILD_DIR}" "${SITE_DIR}"
  mkdir -p "${BUILD_DIR}" "${SITE_DIR}"
}

inject_latest_sources() {
  local product

  log "Injecting current workdir sources as Latest content"
  for product in DeepGit SmartGit SmartSVN SmartSynchronize; do
    if [[ -d "${REPO_ROOT}/src/${product}" ]]; then
      copy_dir_contents "${REPO_ROOT}/src/${product}" "${BUILD_DIR}/${product}/Latest"
    fi
  done
}

populate_smartgit_versions() {
  local ref
  local version

  log "Backfilling SmartGit version branches from Git refs"
  while IFS= read -r ref; do
    [[ -n "${ref}" ]] || continue
    version="${ref#origin/smartgit/}"
    extract_git_tree "${ref}" "src/SmartGit" "${BUILD_DIR}/SmartGit/${version}"
  done < <(git -C "${REPO_ROOT}" for-each-ref --format='%(refname:short)' refs/remotes/origin/smartgit/* | sort)
}

populate_legacy_versions() {
  local legacy_ref
  local version

  legacy_ref="$(resolve_ref origin/legacy legacy)" || die "Could not resolve legacy ref"

  log "Backfilling legacy SmartGit and SmartSVN versions"
  for version in "${LEGACY_SMARTGIT_VERSIONS[@]}"; do
    extract_git_tree "${legacy_ref}" "SmartGit/${version}" "${BUILD_DIR}/SmartGit/${version}"
  done

  for version in "${LEGACY_SMARTSVN_VERSIONS[@]}"; do
    extract_git_tree "${legacy_ref}" "SmartSVN/${version}" "${BUILD_DIR}/SmartSVN/${version}"
  done
}

copy_framework() {
  log "Copying Jekyll framework from ${MAIN_EXPORT}"
  copy_dir_contents "${MAIN_EXPORT}/src-jekyll" "${BUILD_DIR}"
}

overlay_local_framework() {
  if [[ ! -d "${REPO_ROOT}/src-jekyll" ]]; then
    return 0
  fi

  log "Overlaying local Jekyll framework customizations"
  copy_dir_contents "${REPO_ROOT}/src-jekyll" "${BUILD_DIR}"
}

overlay_inflated_content() {
  log "Overlaying inflated site content"
  copy_dir_contents "${MAIN_EXPORT}/src-inflated" "${BUILD_DIR}"
}

ensure_mermaid_cli() {
  if command -v mmdc >/dev/null 2>&1; then
    return 0
  fi

  die "Missing required command: mmdc. Install @mermaid-js/mermaid-cli so ${MAIN_EXPORT}/mermaid/scripts/render-mermaid.py can run unchanged."
}

render_mermaid_diagrams() {
  ensure_mermaid_cli
  local mermaid_root="${MAIN_EXPORT}/mermaid"

  if [[ -f "${REPO_ROOT}/mermaid/scripts/render-mermaid.py" \
    && -f "${REPO_ROOT}/mermaid/mermaid.config.json" \
    && -f "${REPO_ROOT}/mermaid/puppeteer-config.json" ]]; then
    mermaid_root="${REPO_ROOT}/mermaid"
  fi

  log "Rendering Mermaid diagrams"
  WORKSPACE_CONTENT="${BUILD_DIR}" \
  WORKSPACE_CONFIG="${mermaid_root}/mermaid.config.json" \
  WORKSPACE_PUPPETEER_CONFIG="${mermaid_root}/puppeteer-config.json" \
    python3 "${mermaid_root}/scripts/render-mermaid.py"
}

ensure_bundle() {
  if command -v bundle >/dev/null 2>&1; then
    return 0
  fi

  if command -v gem >/dev/null 2>&1; then
    local gem_bin
    log "Installing Bundler into the user gem path"
    gem install --user-install bundler
    gem_bin="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
    export PATH="${gem_bin}:${PATH}"
    command -v bundle >/dev/null 2>&1 && return 0
  fi

  die "Bundler is not available. Install Ruby/Bundler (or provide docker) before running this build."
}

run_prebuilt_jekyll_build() {
  [[ -f "${PREBUILT_GEMFILE}" ]] || return 1
  [[ -f "${PREBUILT_GEMFILE_LOCK}" ]] || return 1
  [[ -d "${PREBUILT_BUNDLE_PATH}" ]] || return 1

  cmp -s "${BUILD_DIR}/Gemfile" "${PREBUILT_GEMFILE}" \
    || die "Prebuilt Jekyll gemset is out of sync with ${MAIN_REF}. Rebuild the Codex image before running this build."

  cp "${PREBUILT_GEMFILE_LOCK}" "${BUILD_DIR}/Gemfile.lock"

  log "Using prebuilt Jekyll bundle from ${PREBUILT_BUNDLE_PATH}"
  (
    cd "${BUILD_DIR}"
    BUNDLE_PATH="${PREBUILT_BUNDLE_PATH}" bundle check >/dev/null
    BUNDLE_PATH="${PREBUILT_BUNDLE_PATH}" bundle exec jekyll build --destination "${SITE_DIR}"
  )
}

run_jekyll_build() {
  ensure_bundle

  if run_prebuilt_jekyll_build; then
    return 0
  fi

  log "Installing Jekyll gems into ${BUNDLE_PATH}"
  (
    cd "${BUILD_DIR}"
    bundle config set path "${BUNDLE_PATH}"
    bundle install --jobs 4 --retry 3
    bundle exec jekyll build --destination "${SITE_DIR}"
  )
}

main() {
  local product

  for product in git tar python3; do
    need_cmd "${product}"
  done

  refresh_origin_main_export
  prepare_build_directories
  copy_framework
  overlay_local_framework
  inject_latest_sources
  populate_smartgit_versions
  populate_legacy_versions
  overlay_inflated_content
  render_mermaid_diagrams
  run_jekyll_build

  log "Build complete"
  log "Framework export: ${MAIN_EXPORT}"
  log "Build workspace: ${BUILD_DIR}"
  log "Rendered site: ${SITE_DIR}"
}

main "$@"
