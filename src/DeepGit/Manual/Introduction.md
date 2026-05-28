# Introduction

DeepGit is a Git code archaeology tool.
It helps you answer questions that normal blame and log views often leave open.

Instead of stopping at "who changed this line last", DeepGit helps you trace where a line or block actually came from across renames, refactorings, merges, and nearby edits.
You investigate one file at a time, starting from `HEAD` or from a specific branch, tag, or commit.

- [What DeepGit shows](#what-deepgit-shows)
- [When to use DeepGit](#when-to-use-deepgit)
- [Main perspectives](#main-perspectives)
- [A simple starting workflow](#a-simple-starting-workflow)
- [Related topics](#related-topics)

## What DeepGit shows

DeepGit centers the investigation around a selected file revision.
The **Navigation** view shows the file history that led to the current state.

The **Blame** view shows the selected file content.
When you select a line or block, DeepGit searches for the most likely origin.

If the result is ambiguous, DeepGit can show multiple origin candidates.
This is especially useful after merges, larger refactorings, or when similar code exists in more than one place.

## When to use DeepGit

DeepGit is most useful when standard blame is too shallow for the question you need to answer.

- Use it to find where a suspicious line or block first appeared.
- Use it to follow code across file renames or larger edits.
- Use it to inspect alternative origins when a merge produced more than one plausible source.
- Use it to understand which tagged release contains a specific file state, together with [At Refs vs. On Refs](At-Refs-vs-On-Refs.md).

## Main perspectives

DeepGit lets you switch perspectives depending on the kind of answer you need.

- **Blame** shows the selected file revision and highlights the best current origin for the selected line or block.
- **Blame+Origins** adds the **Origin Candidates** view so you can inspect alternative origins.
- **Origins** focuses on the selected origin candidate and its diff.
- **Diff** shows the changes introduced by the selected commit for the investigated file.
- **Log** shows the selected commit in context and lists the files changed by that commit.

## A simple starting workflow

1. Open a file with **File \| Open** and, if needed, choose a branch, tag, or SHA instead of `HEAD`.
2. In **Navigation**, select the commit or file revision you want to inspect.
3. In **Blame**, click the line or block you care about and wait for DeepGit to calculate the best origin.
4. Switch to **Window -> Blame+Origins** when you want to inspect alternative origins.
5. Use **Blame (go deeper)** to continue tracing from the selected origin candidate.
6. Switch to **Window -> Diff** or **Window -> Log** when you need commit-level context.

> [!TIP]
> If the result does not match your expectation, verify **View -> Follow Renames** and **View -> Ignore Whitespace Changes** before continuing the investigation.

## Related topics

- [At Refs vs. On Refs](At-Refs-vs-On-Refs.md) explains how to map file states to tags and other refs.
- [Integrations](Integrations.md) explains how to launch DeepGit from external tools and IDEs.
- [How Tos](../HowTos/index.md) contains focused troubleshooting procedures.
