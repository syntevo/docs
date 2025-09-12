#!/usr/bin/env bash
set -euo pipefail

# Batch process Markdown files in a SmartGit docs directory via Codex.
#
# Usage:
#   agents/batch-process-articles/run.sh <relative-dir-under-SmartGit/src/Latest> <prompt-file>
#
# - The prompt file must contain the literal token $FILE, which will be
#   replaced with the current Markdown file path before invoking Codex.
# - Codex is invoked as: /usr/local/bin/codex exec -s danger-full-access "<PROMPT>"
# - Incremental runs: a tracker file is used per prompt
#   - For a prompt file ending in .txt, the tracker is the same name
#     with extension .processed (otherwise: <prompt>.processed)
#   - After a file is processed successfully, its absolute path is
#     appended to the tracker file.
#   - On subsequent invocations, paths listed in the tracker are skipped.

BASE_ROOT="src/SmartGit"
CODEX_BIN="/usr/local/bin/codex"

err() {
  echo "Error: $*" >&2
}

usage() {
  cat >&2 <<EOF
Usage: $0 <relative-dir-under-${BASE_ROOT}> <prompt-file>

Example:
  $0 GUI docs/prompt.txt

Notes:
  - The prompt file must contain the token \$FILE.
  - Each Markdown file in the target directory (recursively) will be processed.
  - Incremental: a tracker file is created next to the prompt
    (replace .txt with .processed) and previously processed files
    listed there will be skipped.
EOF
}

if [[ ${1:-} == "-h" || ${1:-} == "--help" || $# -ne 2 ]]; then
  usage
  exit 1
fi

REL_DIR="$1"
PROMPT_FILE="$2"

TARGET_DIR="${BASE_ROOT}/${REL_DIR}"

if [[ ! -d "$TARGET_DIR" ]]; then
  err "Directory not found: $TARGET_DIR"
  exit 1
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  err "Prompt file not found: $PROMPT_FILE"
  exit 1
fi

if [[ ! -x "$CODEX_BIN" ]]; then
  err "Codex executable not found or not executable at $CODEX_BIN"
  exit 1
fi

PROMPT_TEMPLATE="$(cat "$PROMPT_FILE")"

# Ensure the template contains the placeholder (literal $FILE)
if [[ "$PROMPT_TEMPLATE" != *\$FILE* ]]; then
  err "Prompt file must contain the literal token \$FILE"
  exit 1
fi

echo "Processing Markdown files recursively in: $TARGET_DIR"

# Determine processed tracker file from prompt file
if [[ "$PROMPT_FILE" == *.txt ]]; then
  PROCESSED_FILE="${PROMPT_FILE%.txt}.processed"
else
  PROCESSED_FILE="${PROMPT_FILE}.processed"
fi

# Load already processed file paths (absolute) into a set
declare -A processed
if [[ -f "$PROCESSED_FILE" ]]; then
  while IFS= read -r line; do
    [[ -n "$line" ]] || continue
    processed["$line"]=1
  done < "$PROCESSED_FILE"
fi

echo "Using processed tracker: $PROCESSED_FILE"

# Find markdown files recursively, case-insensitively
mapfile -t files < <(find "$TARGET_DIR" -type f -iname '*.md')

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No Markdown files found in: $TARGET_DIR"
  exit 0
fi

processed_this_run=0
skipped=0

for f in "${files[@]}"; do
  # Resolve to absolute path for reliability
  if command -v realpath >/dev/null 2>&1; then
    FILE_PATH="$(realpath "$f")"
  else
    # Fallback: prefix with PWD
    FILE_PATH="$(cd "$(dirname "$f")" && pwd)/$(basename "$f")"
  fi

  # Skip files that have already been processed by this prompt
  if [[ -n "${processed["$FILE_PATH"]+x}" ]]; then
    echo "Skipping (already processed): $f"
    ((skipped++)) || true
    continue
  fi

  # Replace $FILE in the template; use parameter expansion to avoid sed pitfalls
  PROMPT_RENDERED=${PROMPT_TEMPLATE//\$FILE/$FILE_PATH}

  echo -e "\n---\nFile: $f"
  # Invoke Codex with the rendered prompt as a single argument
  "$CODEX_BIN" exec -s danger-full-access "$PROMPT_RENDERED"

   # On success, append to processed tracker
   if [[ -z "${processed["$FILE_PATH"]+x}" ]]; then
     echo "$FILE_PATH" >> "$PROCESSED_FILE"
     processed["$FILE_PATH"]=1
   fi
   ((processed_this_run++)) || true
done

echo -e "\nDone. Processed ${processed_this_run} file(s); skipped ${skipped}."
