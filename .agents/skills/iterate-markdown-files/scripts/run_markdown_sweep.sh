#!/usr/bin/env bash
set -euo pipefail

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "${SELF_DIR}/.." && pwd)"
TEMPLATES_DIR="${SKILL_DIR}/templates"
STATE_ROOT="/exchange/markdown-sweep"

GIT_BIN="$(command -v git || true)"
if [[ -z "${GIT_BIN}" && -x /opt/git/bin/git ]]; then
  GIT_BIN="/opt/git/bin/git"
fi

RUN_LABEL=""
RUN_DIR=""
MANIFEST_FILE=""
PROMPT_SNAPSHOT=""
META_FILE=""
LOG_FILE=""

err() {
  printf 'Error: %s\n' "$*" >&2
}

usage() {
  cat <<'EOF'
Usage:
  run_markdown_sweep.sh init [--dry-run] <target-dir> <prompt-file-or-template> [run-label]
  run_markdown_sweep.sh [--dry-run] <target-dir> <prompt-file-or-template> [run-label]
  run_markdown_sweep.sh status <run-label>
  run_markdown_sweep.sh next <run-label>
  run_markdown_sweep.sh list <run-label> [STATUS]
  run_markdown_sweep.sh mark <STATUS> <run-label> <file-path> [note]

Commands:
  init   Freeze the file list and prompt into /exchange.
  next   Print the next TODO file path.
  list   Print files with a matching status. Default status is TODO.
  mark   Update one manifest entry to TODO, DONE, or ERROR.
  status Show run paths and status counts.

Notes:
  - This script does not invoke codex. The current agent performs the edits.
  - The prompt must contain the literal token $FILE.
  - Run state is stored in /exchange/markdown-sweep/<run-label>/.
EOF
}

canonicalize_path() {
  local path="$1"

  if command -v realpath >/dev/null 2>&1; then
    realpath "$path"
    return 0
  fi

  printf '%s/%s\n' "$(cd "$(dirname "$path")" && pwd)" "$(basename "$path")"
}

slugify() {
  printf '%s' "$1" | tr '/ ' '--' | sed 's/[^A-Za-z0-9._-]/-/g'
}

resolve_prompt_file() {
  local input="$1"

  if [[ -f "$input" ]]; then
    canonicalize_path "$input"
    return 0
  fi

  if [[ -f "${TEMPLATES_DIR}/${input}" ]]; then
    canonicalize_path "${TEMPLATES_DIR}/${input}"
    return 0
  fi

  err "Prompt file not found: $input"
  return 1
}

detect_project_root() {
  local target_dir="$1"

  if [[ -n "${GIT_BIN}" && -x "${GIT_BIN}" ]]; then
    "${GIT_BIN}" -C "$target_dir" rev-parse --show-toplevel 2>/dev/null || true
    return 0
  fi

  return 0
}

count_status() {
  local manifest="$1"
  local status="$2"

  awk -F '\t' -v wanted="$status" '$1 == wanted { count++ } END { print count + 0 }' "$manifest"
}

read_meta_value() {
  local meta_file="$1"
  local key="$2"

  awk -F '=' -v wanted="$key" '$1 == wanted { print substr($0, length(wanted) + 2) }' "$meta_file"
}

normalize_status() {
  printf '%s' "$1" | tr '[:lower:]' '[:upper:]'
}

validate_status() {
  case "$1" in
    TODO|DONE|ERROR)
      ;;
    *)
      err "Unsupported status: $1"
      return 1
      ;;
  esac
}

resolve_run_paths() {
  RUN_LABEL="$(slugify "$1")"
  RUN_DIR="${STATE_ROOT}/${RUN_LABEL}"
  MANIFEST_FILE="${RUN_DIR}/manifest.tsv"
  PROMPT_SNAPSHOT="${RUN_DIR}/prompt.txt"
  META_FILE="${RUN_DIR}/meta.txt"
  LOG_FILE="${RUN_DIR}/run.log"
}

ensure_run_exists() {
  if [[ ! -d "$RUN_DIR" ]]; then
    err "Run directory not found: $RUN_DIR"
    return 1
  fi

  if [[ ! -f "$MANIFEST_FILE" ]]; then
    err "Manifest not found: $MANIFEST_FILE"
    return 1
  fi

  if [[ ! -f "$PROMPT_SNAPSHOT" ]]; then
    err "Prompt snapshot not found: $PROMPT_SNAPSHOT"
    return 1
  fi

  if [[ ! -f "$META_FILE" ]]; then
    err "Run metadata not found: $META_FILE"
    return 1
  fi
}

print_status_summary() {
  local todo_count done_count error_count

  todo_count="$(count_status "$MANIFEST_FILE" TODO)"
  done_count="$(count_status "$MANIFEST_FILE" DONE)"
  error_count="$(count_status "$MANIFEST_FILE" ERROR)"

  printf 'Run directory: %s\n' "$RUN_DIR"
  printf 'Manifest: %s\n' "$MANIFEST_FILE"
  printf 'Prompt snapshot: %s\n' "$PROMPT_SNAPSHOT"
  printf 'Log: %s\n' "$LOG_FILE"
  printf 'Target directory: %s\n' "$(read_meta_value "$META_FILE" target_dir)"
  printf 'Project root: %s\n' "$(read_meta_value "$META_FILE" project_root)"
  printf 'Status counts: TODO=%s DONE=%s ERROR=%s\n' "$todo_count" "$done_count" "$error_count"
}

update_manifest_status() {
  local manifest="$1"
  local file_path="$2"
  local new_status="$3"
  local tmp_manifest="${manifest}.tmp"

  set +e
  awk -F '\t' -v OFS='\t' -v target="$file_path" -v status="$new_status" '
    $2 == target {
      $1 = status
      count++
    }
    { print }
    END {
      if (count != 1) {
        exit 2
      }
    }
  ' "$manifest" > "$tmp_manifest"
  local rc=$?
  set -e

  if [[ $rc -ne 0 ]]; then
    rm -f "$tmp_manifest"
    if [[ $rc -eq 2 ]]; then
      err "Failed to update manifest entry for $file_path"
    fi
    return $rc
  fi

  mv "$tmp_manifest" "$manifest"
}

append_log() {
  local message="$1"

  printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$message" >> "$LOG_FILE"
}

count_markdown_files() {
  local target_dir="$1"

  find "$target_dir" -type f -iname '*.md' | wc -l | awk '{ print $1 }'
}

resolve_manifest_file() {
  local manifest="$1"
  local input="$2"
  local candidate=""

  if [[ -f "$input" ]]; then
    candidate="$(canonicalize_path "$input")"
    if awk -F '\t' -v target="$candidate" '$2 == target { found = 1 } END { exit found ? 0 : 1 }' "$manifest"; then
      printf '%s\n' "$candidate"
      return 0
    fi
  fi

  if awk -F '\t' -v target="$input" '$2 == target { found = 1 } END { exit found ? 0 : 1 }' "$manifest"; then
    printf '%s\n' "$input"
    return 0
  fi

  err "File is not present in the manifest: $input"
  return 1
}

command_init() {
  local dry_run=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)
        dry_run=1
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  if [[ $# -lt 2 || $# -gt 3 ]]; then
    usage
    return 1
  fi

  local target_input="$1"
  local prompt_input="$2"
  local run_label_input="${3:-}"

  if [[ ! -d "$target_input" ]]; then
    err "Target directory not found: $target_input"
    return 1
  fi

  local target_dir prompt_source project_root prompt_to_use prompt_template
  target_dir="$(canonicalize_path "$target_input")"
  prompt_source="$(resolve_prompt_file "$prompt_input")"

  if [[ -z "$run_label_input" ]]; then
    run_label_input="$(basename "${prompt_source%.*}")__$(basename "$target_dir")"
  fi

  resolve_run_paths "$run_label_input"

  if [[ -f "$PROMPT_SNAPSHOT" ]]; then
    if ! cmp -s "$prompt_source" "$PROMPT_SNAPSHOT"; then
      printf 'Using frozen prompt snapshot: %s\n' "$PROMPT_SNAPSHOT" >&2
    fi
    prompt_to_use="$PROMPT_SNAPSHOT"
  else
    prompt_to_use="$prompt_source"
  fi

  prompt_template="$(cat "$prompt_to_use")"
  if [[ "$prompt_template" != *\$FILE* ]]; then
    err "Prompt file must contain the literal token \$FILE"
    return 1
  fi

  project_root="$(detect_project_root "$target_dir")"
  if [[ -z "$project_root" ]]; then
    project_root="$(pwd)"
  fi

  if [[ "$dry_run" -eq 1 ]]; then
    printf 'Run directory: %s\n' "$RUN_DIR"
    printf 'Prompt source: %s\n' "$prompt_source"
    printf 'Target directory: %s\n' "$target_dir"
    printf 'Markdown files: %s\n' "$(count_markdown_files "$target_dir")"
    return 0
  fi

  mkdir -p "$RUN_DIR"

  if [[ ! -f "$PROMPT_SNAPSHOT" ]]; then
    cp "$prompt_source" "$PROMPT_SNAPSHOT"
  fi

  if [[ ! -f "$META_FILE" ]]; then
    {
      printf 'created_at=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf 'target_dir=%s\n' "$target_dir"
      printf 'project_root=%s\n' "$project_root"
      printf 'prompt_source=%s\n' "$prompt_source"
      printf 'prompt_snapshot=%s\n' "$PROMPT_SNAPSHOT"
    } > "$META_FILE"
  else
    local existing_target_dir
    existing_target_dir="$(read_meta_value "$META_FILE" target_dir)"
    if [[ -n "$existing_target_dir" && "$existing_target_dir" != "$target_dir" ]]; then
      err "Run label $RUN_LABEL already belongs to target directory $existing_target_dir"
      return 1
    fi
  fi

  if [[ ! -f "$MANIFEST_FILE" ]]; then
    : > "$MANIFEST_FILE"
    while IFS= read -r -d '' file_path; do
      printf 'TODO\t%s\n' "$(canonicalize_path "$file_path")" >> "$MANIFEST_FILE"
    done < <(find "$target_dir" -type f -iname '*.md' -print0 | LC_ALL=C sort -z)
  fi

  append_log "initialized target=$(read_meta_value "$META_FILE" target_dir)"
  print_status_summary
}

command_status() {
  if [[ $# -ne 1 ]]; then
    usage
    return 1
  fi

  resolve_run_paths "$1"
  ensure_run_exists
  print_status_summary
}

command_next() {
  if [[ $# -ne 1 ]]; then
    usage
    return 1
  fi

  resolve_run_paths "$1"
  ensure_run_exists

  if [[ "$(count_status "$MANIFEST_FILE" ERROR)" -gt 0 ]]; then
    err "Manifest contains ERROR entries. Resolve them before continuing."
    return 1
  fi

  awk -F '\t' '$1 == "TODO" { print $2; exit }' "$MANIFEST_FILE"
}

command_list() {
  if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
    return 1
  fi

  local run_label_input="$1"
  local status="${2:-TODO}"

  status="$(normalize_status "$status")"
  validate_status "$status"

  resolve_run_paths "$run_label_input"
  ensure_run_exists

  awk -F '\t' -v wanted="$status" '$1 == wanted { print $2 }' "$MANIFEST_FILE"
}

command_mark() {
  if [[ $# -lt 3 ]]; then
    usage
    return 1
  fi

  local status="$1"
  local run_label_input="$2"
  local file_input="$3"
  local note=""
  local resolved_file

  shift 3
  if [[ $# -gt 0 ]]; then
    note="$*"
  fi

  status="$(normalize_status "$status")"
  validate_status "$status"

  resolve_run_paths "$run_label_input"
  ensure_run_exists

  resolved_file="$(resolve_manifest_file "$MANIFEST_FILE" "$file_input")"
  update_manifest_status "$MANIFEST_FILE" "$resolved_file" "$status"

  if [[ -n "$note" ]]; then
    append_log "mark status=${status} file=${resolved_file} note=${note}"
  else
    append_log "mark status=${status} file=${resolved_file}"
  fi

  printf '%s\t%s\n' "$status" "$resolved_file"
}

main() {
  local command="init"

  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  case "$1" in
    init|status|next|list|mark)
      command="$1"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      command="init"
      ;;
  esac

  case "$command" in
    init)
      command_init "$@"
      ;;
    status)
      command_status "$@"
      ;;
    next)
      command_next "$@"
      ;;
    list)
      command_list "$@"
      ;;
    mark)
      command_mark "$@"
      ;;
  esac
}

main "$@"
