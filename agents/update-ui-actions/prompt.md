# Codex Instructions: Update `ui-actions.md`

Process the UI item which you have received according to the following instructions.

Goal
- Maintain `src/SmartGit/Manual/ui-actions.md` as the comprehensive index of SmartGit menu items.
- The list is organized by windows, which may be main windows or other kind of windows in SmartGit.
- Every listed item should link to the most appropriate page in the Manual.
- Exclude trivial items (e.g., `Exit`) and debug-related items.

Input
- You receive exactly one raw line from `ui-map.tsv` describing a control with fields like `windowTitle`, `windowKey`, `controlKind`, `controlId`, `controlText`, `controlDetails`.

Procedure
1) Decide inclusion
- If the item is trivial or debug-related, do not make any changes.

2) If the item should be listed
- Choose the correct window section using `windowTitle` and `windowKey`.
  - If no appropriate section exists (because this may be about a new window), create a new section at the end of the document.
- Normalize `controlText`: remove trailing `...` or the Unicode ellipsis `…`.
- If `controlKind` is `menu` (not `menuItem`), add ` (menu)` after the text, e.g., `Bisect (menu)`.
- If the meaning could be unclear, add a clarifier in parentheses immediately after the text, e.g., `Push (commits)` or `Push (subtrees)`.
- Include `controlDetails` when it adds clarity.
- Link the item to the most appropriate Manual page.
  - Don't be confused by similar-named menu or menu items; if such menu items are part of different windows, they may serve entirely different purposes
- Keep items lexicographically sorted within the chosen window section.

Scope
- Modify only `src/SmartGit/Manual/ui-actions.md`.
