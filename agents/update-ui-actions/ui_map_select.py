#!/usr/bin/env python3
"""
Filter and select new UI map items.

Reads `.temp/ui-map-menu-items.txt`, filters to `controlKind` in {menu, menuItem},
then removes any items already present in `.temp/ui-map-ignored.txt`
or `.temp/ui-map-processed.txt` based on a normalized matching key:

- key = windowKey|controlKind|controlId|normText|controlDetails
- normText: controlText trimmed and with trailing "..." removed
- whitespace tolerance: trim field values and collapse internal whitespace

Prints surviving full original lines to stdout, one per line, in the
same order as the source file.
"""

import os
import re
import sys
from pathlib import Path


TEMP_DIR = Path('.temp')
SRC_FILE = TEMP_DIR / 'ui-map-menu-items.txt'
IGN_FILE = TEMP_DIR / 'ui-map-ignored.txt'
PROC_FILE = TEMP_DIR / 'ui-map-processed.txt'
IGN_FILE_ALT = TEMP_DIR / 'ui-map-ignored (2).txt'
PROC_FILE_ALT = TEMP_DIR / 'ui-map-processed (2).txt'


def parse_fields(line: str):
    parts = line.rstrip('\n').split('\t')
    # Expect keys like windowTitle=..., windowKey=..., controlKind=..., controlId=..., controlText=..., controlDetails=...
    fields = {}
    for part in parts:
        if '=' not in part:
            continue
        k, v = part.split('=', 1)
        v = v.strip()
        if v.startswith('"') and v.endswith('"') and len(v) >= 2:
            v = v[1:-1]
        fields[k.strip()] = v
    return fields


_space_re = re.compile(r"\s+")


def normalize_value(s: str) -> str:
    s = s.strip()
    s = _space_re.sub(' ', s)
    return s


def normalize_control_text(s: str) -> str:
    s = normalize_value(s)
    # Remove trailing three-dot ellipsis tolerance
    if s.endswith('...'):
        s = s[:-3].rstrip()
    # Also normalize Unicode ellipsis if present
    if s.endswith('…'):
        s = s[:-1].rstrip()
    return s


def norm_key_from_fields(fields: dict) -> str:
    window_key = normalize_value(fields.get('windowKey', ''))
    control_kind = normalize_value(fields.get('controlKind', ''))
    control_id = normalize_value(fields.get('controlId', ''))
    control_text = normalize_control_text(fields.get('controlText', ''))
    control_details = normalize_value(fields.get('controlDetails', ''))
    return '|'.join([window_key, control_kind, control_id, control_text, control_details])


def load_norm_keys(path: Path) -> set[str]:
    keys: set[str] = set()
    if not path.exists():
        return keys
    with path.open('r', encoding='utf-8') as fh:
        for line in fh:
            if not line.strip():
                continue
            fields = parse_fields(line)
            # Only consider menu/menuItem here as well to align logic
            kind = fields.get('controlKind', '')
            if kind not in ('menu', 'menuItem'):
                continue
            keys.add(norm_key_from_fields(fields))
    return keys


def main() -> int:
    if not SRC_FILE.exists():
        print(f"ERROR: Missing {SRC_FILE}", file=sys.stderr)
        return 2

    ignored = load_norm_keys(IGN_FILE) | load_norm_keys(IGN_FILE_ALT)
    processed = load_norm_keys(PROC_FILE) | load_norm_keys(PROC_FILE_ALT)
    seen = ignored | processed

    with SRC_FILE.open('r', encoding='utf-8') as src:
        for line in src:
            if not line.strip():
                continue
            fields = parse_fields(line)
            if fields.get('controlKind') not in ('menu', 'menuItem'):
                continue
            key = norm_key_from_fields(fields)
            if key in seen:
                continue
            # New item that survives filtering
            sys.stdout.write(line)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
