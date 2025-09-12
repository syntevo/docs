#!/usr/bin/env bash
set -euo pipefail

# Two-phase processing of SmartGit UI items
# 1) Preparation: grep menu/menuItem lines from .temp/ui-map.tsv into .temp/ui-map-menu-items.txt
# 2) Processing: work ONLY with .temp/ui-map-menu-items.txt (ui-map.tsv remains untouched)
#
# Cancel-safe: operates item-by-item and updates files after each item.

ROOT_DIR=$(cd -- "$(dirname -- "$0")/../.." && pwd)
cd "$ROOT_DIR"

TEMP_DIR=.temp
PREP_SRC_FILE="$TEMP_DIR/ui-map.tsv"
SRC_FILE="$TEMP_DIR/ui-map-menu-items.txt"
IGN_FILE="$TEMP_DIR/ui-map-ignored.txt"
PROC_FILE="$TEMP_DIR/ui-map-processed.txt"

ensure_files() {
  mkdir -p "$TEMP_DIR"
  : > "$IGN_FILE"    # ensure file exists; keep content if present
  : > "$PROC_FILE"
  # The above would truncate, which we must NOT do. Correct approach:
}

# Correct implementation: create if missing, else keep content
touch_safe() {
  local f="$1"
  [[ -f "$f" ]] || : > "$f"
}

# Phase 1: prepare menu/menuItem-only source file from ui-map.tsv
prepare_source() {
  if [[ ! -f "$PREP_SRC_FILE" ]]; then
    echo "ERROR: Missing $PREP_SRC_FILE" >&2
    return 2
  fi
  mkdir -p "$TEMP_DIR"
  # If the prepared file already exists, keep it to preserve incremental progress
  if [[ -f "$SRC_FILE" ]]; then
    return 0
  fi
  # Keep ui-map.tsv untouched; write filtered lines to ui-map-menu-items.txt
  # Lines are tab-separated key=value; filter by controlKind=(menu|menuItem)
  # Use grep -E for portability
  grep -E '\bcontrolKind=(menu|menuItem)\b' "$PREP_SRC_FILE" > "$SRC_FILE" || :
}

# Inline of agents/process-ui-item.sh
# Invokes Codex non-interactively for a single raw menu-item line
process_item_with_codex() {
  local line="$1"
  [[ -n "$line" ]] || { echo "ERROR: empty line passed to process_item_with_codex" >&2; return 2; }

  local instr_file="agents/update-ui-actions/prompt.md"
  if [[ ! -f "$instr_file" ]]; then
    echo "ERROR: Missing $instr_file with Codex Processing instructions." >&2
    return 2
  fi

  local instructions_content
  instructions_content=$(cat "$instr_file")

  local task_prompt
  task_prompt=$(cat <<EOF
Process the following SmartGit UI item according to the instructions from agents/update-ui-actions/prompt.md.

--- BEGIN INSTRUCTIONS ---
$instructions_content
--- END INSTRUCTIONS ---

--- BEGIN ITEM ---
$line
--- END ITEM ---
EOF
)

  # Temporarily disable 'set -e' around the Codex call so that ANY non-zero
  # exit status coming from the binary does not terminate the whole script.
  /usr/local/bin/codex exec -s danger-full-access "$task_prompt"
  local rc=$?
  return "$rc"
}

main() {
  prepare_source || exit 2
  if [[ ! -f "$SRC_FILE" ]]; then
    echo "ERROR: Missing $SRC_FILE after preparation" >&2
    exit 2
  fi
  touch_safe "$IGN_FILE"
  touch_safe "$PROC_FILE"

  # Compute new items using Python helper (reads from ui-map-menu-items.txt)
  mapfile -t NEW_LINES < <(python3 agents/update-ui-actions/ui_map_select.py)

  if [[ ${#NEW_LINES[@]} -eq 0 ]]; then
    echo "No new items to process."
    exit 0
  fi

  echo "Found ${#NEW_LINES[@]} new item(s). Processing one-by-one..."

  UIA_FILE="src/SmartGit/Manual/ui-actions.md"
  total_items=${#NEW_LINES[@]}
  
  for idx in "${!NEW_LINES[@]}"; do
    RAW_LINE="${NEW_LINES[$idx]}"
    # Skip empty lines defensively
    [[ -n "$RAW_LINE" ]] || continue

    seq=$((idx + 1))
    echo -e "\n---"
    echo "[$seq/$total_items] Processing: $RAW_LINE"

    # Snapshot current ui-actions.md content hash to detect changes
    before_hash=$(sha1sum "$UIA_FILE" 2>/dev/null | awk '{print $1}')

    set +e
    process_item_with_codex "$RAW_LINE"
    rc=$?
    set -e
    if (( rc != 0 )); then
      echo "Codex processing failed for item; leaving it in $SRC_FILE for retry." >&2
      # Do not remove from source; continue to next
      continue
    fi

    # Determine whether ui-actions.md was changed by Codex
    after_hash=$(sha1sum "$UIA_FILE" 2>/dev/null | awk '{print $1}')

    if [[ -n "$before_hash" && -n "$after_hash" && "$before_hash" != "$after_hash" ]]; then
      echo "$RAW_LINE" >> "$PROC_FILE"
      status="processed"
      echo "Item processed and recorded in $PROC_FILE"
    else
      echo "$RAW_LINE" >> "$IGN_FILE"
      status="ignored"
      echo "Item ignored (no changes) and recorded in $IGN_FILE"
    fi

    # Remove the exact line from ui-map-menu-items.txt (ui-map.tsv remains untouched)
    tmp_file=$(mktemp)
    awk -v target="$RAW_LINE" 'BEGIN{removed=0} {if(!removed && $0==target){removed=1; next} print}' "$SRC_FILE" > "$tmp_file"
    mv "$tmp_file" "$SRC_FILE"
    echo "Updated: removed $status item from $SRC_FILE"
  done

  echo "You can re-run to continue."
}

main "$@"
