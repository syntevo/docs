# Log Window

The **Log Window** in SmartGit (not to be confused with the [Git Log tool](Log.md)) is one of the [Main Windows](Main-Windows.md) of SmartGit, and allows Git power-users to have complete control over a repository.

## Why use the Log Window?

The Log Window is aimed at experienced Git Users who which to gain full understanding of the commit history of a repository, and ease the ability to allow history to be tidied and re-written, and has a focus on git commands such as [Rebase](Branch/Rebase.md), and [Interactive Rebase](Branch/Rebase-Interactive.md) features such as Squashing, Modifying, Reordering and Removing commits within a repository.

![Log window](../images/Log-window.png)

## Elements of the Log Window

The Log Window contains the following views:

- The [Repositories View](Repositories-View.md), showing all repositories added to SmartGit, and allowing you to switch between open repositories.
- The [Branches View](Branches-view.md), allowing you to toggle which branches are to be included int the *Graph View*, and other [Branch](Branch/index.md) related features.
- The [Graph View](Graph-View.md), providing a graphical visualization of the commit history in the selected branches.
- The [Commit View](Commit-View.md) allowing Commits to be viewed, and new Commits to be created.
- The *Files View*, showing which files have changed in the selected commit. The standard filtering widgets can be applied to control which files are listed.
- The *Changes View*, showing the changes in the file selected in the *Files View* for the selected commit in the *Graph View*, or the difference in the file between any 2 commits, if exactly 2 commits are selected in the *Graph View*.

#### Tips
> - You can view commits eligible for [garbage collection](Repository/index.md#the-garbage-collector) in SmartGit's Log by selecting the **Recyclable Commits** option in the *Branches* view of the **Log Window**.
> - If the repository has been [Integrated](../Integrations/index.md) to a Git Hosting Provider, the Log Window will also show [Pull Requests](../Integrations/Integrated-PullRequests.md) on the host.
> These are displayed directly below the local (or if it does not exist), the remote branch in the *Branches View*.
> - In addition, when the repository is integrated to a Hosting Provider, a list of comments will be shown in the Files View of the Log Window. See [Integrated Comments](../Integrations/Integrated-PullRequest-Comments.md) for further information.
