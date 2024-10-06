# Git for Subversion Users

If you are familiar with a traditionalCentralized Version Control System such as Subversion (SVN), there are some conceptual differences you'll need to understand to adapt to the basic flow in Git.

## Remote and Local Repositories and the Working Tree

Subversion (SVN) requires the use of "working copies" of a remote (server) repository, each corresponding to exactly one repository. SVN working copies will contain the entire repository or just parts of it.

In Git, the equivalent of a `working copy` is the **[Working Tree](Working-Tree-States.md)**, one of the major features of your local repository. Remember, in a Distributed Version Control System like Git, there isn't a single, central repository - by Cloning a remote repository, you get a copy of the repository.

Just like the working copy in SVN, the Git Working Tree is the directory where you can edit files, build, and test software, before commiting changes. 

## Cloning, Checkout, Commiting, and Pushing in Git

Although the outcomes are similar in both Git and SVN (i.e., adding new commits to a branch on a remote server), there are some conceptual differences in Git that you should be aware of:
- In Git, you **[Clone](/SmartGit/Latest/Clone)** a repository from a remote server. This is somewhat similar to checking out an SVN branch from a remote server onto your local system for the first time.
- In Git, you use **Checkout** to switch between branches in your local repository. This is somewhat similar to using the `switch` command in SVN, though Git changes branch on your local repository.
- In SVN, using 'commit' will publish your local changes to the remote server. In Git, this activity is broken down into smaller, distinct steps:
  - **[Staging](The-Index.md)** - this is the process where you decide which of the changes made in your Working Tree should be added to the next commit. Unless you stage the files you've changed, added, or deleted, these will be left out of the next commit. If this sounds complicated, don't fret - SmartGit provides the option to automatically handle staging.
  - **[Commit](Commits.md)** - in Git, a commit adds the staged file changes and creates a new commit on the current branch in your local repository.
  - **Push** - Push is the command that uploads new commits from your local repository to a remote repository (e.g., back to the `origin` repository). Git keeps track of the remote branch from which your local branch originated and, by default, will push changes back to this branch. However, with Push, you also have the option to override the branch in the remote repository to which you'd like to push your commits. 
 - In Git, performing a **Pull** is similar to SVN's `refresh` command. It allows new commits (since your last Clone or Pull) in the tracked remote branch to be merged into your working directory. Git Pull is equivalent to doing a **`Fetch`** (updating your local repository with the remote changes) and then a **`Merge`** (merging changes from the tracked branch into your local branch).
