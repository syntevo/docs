---
name: iterate-markdown-files
description: Use when the user asks to iterate over all Markdown files, sweep a docs tree, or apply the same transformation to every Markdown source file with no skips, for example "iterate over all markdown files and convert ASCII art to mermaid". Create a task-specific prompt in /exchange, initialize the manifest with run_markdown_sweep.sh, then use the same script to walk and mark the file list.
---

# Iterate Markdown Files

Use this skill when the user wants one change applied across every Markdown source file in a target tree and completeness matters.

## Required Workflow

1. Identify the target source tree.
2. Choose a stable `run-label`.
3. Write a task-specific prompt file to `/exchange/markdown-sweep/<run-label>/prompt.txt`.
4. Initialize the run manifest from the repository root.
5. Use the script to fetch the next `TODO` file, edit that file in the current agent, then mark it `DONE` or `ERROR`.
6. Stop immediately if any file is marked `ERROR`.
7. Treat the run as complete only when `manifest.tsv` contains no `TODO` or `ERROR` lines.
8. Review the resulting diff, run any relevant validation, and commit the requested work.

## Command

```bash
./.agents/skills/iterate-markdown-files/scripts/run_markdown_sweep.sh <target-dir> <prompt-file-or-template> [run-label]
```

Prefer an explicit prompt file in `/exchange`.
Use a bundled template only when it already matches the task exactly.

`<prompt-file-or-template>` may still be:

- An absolute path
- A path relative to the current working directory
- A file name from [`templates/`](templates/)

## Target Scope

- Prefer the smallest source directory that matches the request.
- Exclude `.agents/`, `/exchange`, build output, and repository-operational Markdown files unless the user explicitly asks to include them.
- If the request says "all markdown source files", inspect the repository layout and choose the docs source tree, not the whole repository root by default.

## Prompt Rules

- The prompt must contain the literal token `$FILE`.
- State exactly what to change.
- State exactly what not to change.
- Tell Codex what to do when a file does not need edits, usually "leave it unchanged".
- Keep the prompt per-file and idempotent.

## Script Behavior

The script:

- Freezes the initial file list into `manifest.tsv`
- Freezes the prompt into `prompt.txt`
- Returns the next `TODO` file in sorted order
- Lets the current agent mark each file `DONE` or `ERROR`
- Never launches nested `codex exec` processes

## Templates

- [`templates/adjust-article-to-styleguide.txt`](templates/adjust-article-to-styleguide.txt)
- [`templates/adjust-article-to-styleguide-only-admonitions.txt`](templates/adjust-article-to-styleguide-only-admonitions.txt)

## Example

User request:

```text
iterate over all markdown files and convert ASCII art to mermaid
```

Prompt file to write in `/exchange/markdown-sweep/<run-label>/prompt.txt`:

```text
For $FILE, convert ASCII-art diagrams to Mermaid blocks when the conversion is clear enough to preserve the intended structure.
Keep surrounding prose, headings, links, and code blocks unchanged unless a diagram must move into a Mermaid block.
If the file contains no qualifying ASCII-art diagram, leave it unchanged.
Do not make unrelated wording or style edits.
```

Then run:

```bash
./.agents/skills/iterate-markdown-files/scripts/run_markdown_sweep.sh <target-dir> /exchange/markdown-sweep/<run-label>/prompt.txt <run-label>
next_file="$(./.agents/skills/iterate-markdown-files/scripts/run_markdown_sweep.sh next <run-label>)"
```

After editing `next_file` in the current agent:

```bash
./.agents/skills/iterate-markdown-files/scripts/run_markdown_sweep.sh mark DONE <run-label> "$next_file"
```

If the file cannot be processed safely:

```bash
./.agents/skills/iterate-markdown-files/scripts/run_markdown_sweep.sh mark ERROR <run-label> "$next_file" "reason"
```

## Notes

- All manifests, logs, and other temporary reports belong in `/exchange`, never in the repository.
- Do not store line numbers in the manifest for whole-file sweeps. They become stale as soon as earlier edits shift the file.
- Use [`run_markdown_sweep.sh`](scripts/run_markdown_sweep.sh) as a manifest/state helper only. The current agent performs the actual edits.
- After a sweep changes repository files, create the normal Git commit for the requested work.
