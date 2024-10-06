---
redirect_from:
  - /SmartGit/Latest/Branches
  - /SmartGit/Latest/Branches.html
---
# Branches

Git uses branches to store an independent series of commits within a repository.

In Git, you can create as many Branches in a repository as needed. For example, it is common to create branches when fixing bugs in a previous release of a software project while simultaneously developing new features for the next version.

Git distinguishes between two kinds of branches: 
- **Local branches:** These are branches in your local repository. If you have not pushed the branch to a remote repository, it will only be visible on your local computer.
- **Remote branches:** These are branches stored on the remote repository. They will be visible to everyone with access to the remote repository and become available in your local repository when you Clone a remote repository.
You cannot work directly on remote branches; instead, you must clone the remote repository to work on them.

## Cloning, Tracking, and Local Branches
When you use `git clone` to [Clone](Clone.md) a remote repository, all remote branches will become known to the local repository as **'remote-tracking'** branches.

Remote-tracking branches will have the name of the remote prepended, e.g., `origin/main`.

When you checkout from a remote-tracking branch (e.g., `git checkout origin/main -b main`), Git links the local branch to the remote-tracking branch (known as the 'upstream' for the local branch). This ensures that when you `push`, Git will know to push the commits to the original remote branch (unless specified otherwise), and when you `pull`, Git will know which remote branch to monitor for new commits.

You can also choose to create a local branch that does not track a remote branch (e.g., `git checkout -b mybranch`). In this case, you must specify the source branch when merging remote changes into your local branch and provide a target remote branch when pushing.

After Cloning, Git will check out the default local branch in your Working Tree, which is usually the *main* (or *main* in older repositories).

## Working with Branches using Checkout

Once you've cloned a repository to your local system, the `checkout` command switches between branches or creates new branches in Git.

For existing local branches, checkout will switch the Working Tree to the branch selected, e.g.:

`git checkout ExistingFeature`

When creating new branches, unless you specify a starting point, Git assumes your new branch should be created from the current branch (referred to as `HEAD`):

`git checkout -b NewFeature` 

To create a new local branch from an existing remote branch, specify the remote-tracking branch as the starting point, e.g.:

`git checkout -b NewFeature origin/main`

This will create a local branch `NewFeature`, that tracks the upstream `origin/main`. *(Note: In some teams, development etiquette requires that you `reserve` the new branch name on the remote before checking it out locally)*.

In addition to checking out existing remote branches, Git allows you to create new local branches from an existing commit hash or tag, e.g.:

`git checkout -b NewFeature ce1067054f`

Where `ce1067054f` is the SHA hash of the commit that you would like the `NewFeature` local branch to be created from.

#### Tip
>
> After a creating a new release, tagging the commit that produced that release with an identifier is good practice.
This makes it easier to identify where to branch from when creating bug-fix commits for that release.
>

When you push changes from your local branch to the origin repository,
these changes will be propagated to the tracked (remote) branch.
Similarly, when you pull changes from the origin repository, they will be stored in the local repository's tracked (remote) branch. 
To get the tracked branch changes into your local branch,
the remote changes must be *merged from the tracked branch*. This can
be done directly when invoking the *Pull* command in SmartGit or
later by explicitly invoking the *Merge* command. An alternative to the
Merge command is the Rebase command.


#### Tip
>
>The method to be used by Pull (either *Merge* or *Rebase*) can be configured in **Repository \| Settings** on the **Pull** tab.
>

## Branches are just pointers to commits

Every branch is simply a pointer to a commit with a 'friendly' name that you provide (e.g., `main`, `feature-2`, etc.). A special, unique pointer in every repository is the *HEAD*, which points to the commit corresponding to the current state of the Working Tree . *HEAD* can point to a commit or a local branch.

When working on a branch, a new commit is created each time you stage and commit changes, which remembers the previous (parent) commit from which it was based.

For example, if you add a new commit `B` based on commit `A` on the `main` branch after the changes in `B` are committed:
- `A` is the parent commit of `B`
- `B` becomes the new commit pointer for branch `main`
- The `HEAD` pointer will move to `B`

```
o B
|
o A
```

Some other examples of commit and branch 'pointer' operations:

You can create a new branch from a previous commit by providing the commit hash (`A`) and the new branch name (`NewBranch`), e.g.:

`git checkout A -b NewBranch`

You can also checkout a previous commit **without** creating a new branch by providing the commit hash (`A`) that you wish to switch to:

`git checkout A`

Since no branch has been specified in this case, Git refers to the Working Tree status as a **detached HEAD**.

Although it's generally recommended to make changes on a named branch, if you accidentally make changes while in a detached HEAD status and wish to keep them, you can create a new branch from the current HEAD status:

`git checkout -b NewBranch`

Then, stage and commit the changes to the `NewBranch`.

You can later use tools such as [Merge](Merging.md), cherry-pick, or [Rebase](Rebasing.md) to integrate these changes into another branch.

## Merge Commits have multiple parent commits

A [Merge commit](Merging.md#normal-merge-commit) differs from a normal commit because it refers to two or more parent commits, representing: 
- The previous commit on the current (local) branch.
- The latest commit on each of the branches being merged.

For example, when branch `feature-a` is merged into `main` through a merge pull request, a new commit is added to `main`, which will trace a parent commit from both the last commits in `feature-a` and `main`.
