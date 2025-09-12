# SmartGit Investigate

SmartGit's Investigate integrates Syntevo's DeepGit to analyze the origin of lines and blocks in your code.
It goes beyond a simple blame by tracing code through moves, copies and refactors using similarity analysis.
Use Investigate when you need to answer: "Where did this code come from, and how did it evolve?".

## What Investigate Does

- Traces a selected line or block back through commits to its earliest introduction.
- Detects moved or copied code across files, even when lines are not identical.
- Presents origin candidates with similarity percentages to help choose the best match.
- Shows current and origin code side-by-side with highlighted differences.
- Focuses the history graph around relevant commits for faster navigation.

For basic per-line history of a single file, see [Blame](Blame.md).
For commit context and navigation, see [Log](Log.md).
For side-by-side diffs, see [File Compare](File-Compare.md).

## Opening Investigate

- Select a file in the **Files** or **Log** view and invoke **Query \| Investigate**.
- Or right-click a file or entry in the **Log** and choose **Investigate**.
- To focus on a specific section, open the file in [Changes View](Changes-View.md) or [Blame](Blame.md), select the line(s), then invoke **Investigate**.

## Investigate Window Overview

- The **Document** view shows the file content with blame annotations (commit, author, date per line).
- Use **Go Deeper** (for the selected line or block) to search earlier origins.
- The **Origin Candidates** list ranks likely sources with similarity metrics.
- Selecting a candidate opens a side-by-side comparison of current vs. origin code with differences highlighted.
- You can iterate this process to trace the code further back in history.

## Typical Workflow

1. Open the file and start **Query \| Investigate**.
2. Select the line or block you care about in the **Document** view.
3. Click **Go Deeper** to search for earlier origins.
4. Review **Origin Candidates** and pick the best match to inspect.
5. Repeat **Go Deeper** from the origin view until you reach the first introduction or have enough context.

## Command Line

You can launch Investigate from scripts or external tools.

```
smartgitc --investigate <repo-path>/<file>[:line]
```

This opens Investigate for the specified file and optionally scrolls to the given line.

## Tips

- Narrow the selection to a meaningful block for more precise origin candidates.
- Use the history graph in Investigate to keep orientation while jumping across commits.
- If large refactors are involved, expect multiple candidates; pick the one with the best similarity and context.
