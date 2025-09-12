# Working Tree Window

The Working Tree Window is one of the [Main Windows](Main-Windows.md) in SmartGit.
It is aimed at users who wish to focus on changes to files in the *Working Tree*, and simplifies the staging and creation of new commits, while at the same time allowing visualization of the changes that have been made.

The **Working Tree Window** consists of the following views:

- The [Repositories View](Repositories-View.md), showing all repositories found by SmartGit, with the currently opened repository highlighted in bold.
- The [Branches View](Branches-view.md), showing available branches in the current repository, and allowing quick checkout of a different branch.
- The **Files View**, showing files in the currently selected Working Tree folder in the repository, and filtered by any of the filter widgets selected above the view.
- The [Commit View](Commit-View.md), allowing you to quickly create a new commit by adding a commit message, or optionally amending the previous commit.
- A variant of the [Changes View](Changes-View.md), showing any differences of the file selected in the **Files View**, between the Working Tree and the Index.
- The [Journal View](Journal-View.md), showing a linear history commits in the current branch (only).

![Working Tree window](../images/Working-Tree-window.png)

## Tips

> - Selecting a file in the **Files View** will show the differences made since the previous commit in the **Changes View**.
> - The **Journal View** shows the latest commits in the current branch and one optional other branch (e.g., to cherry-pick commits from).

To see the full history of the repository, you need to open the [Log window](Log-Window.md), or the [SmartGit Log tool](Log.md).
