# Git Pull

The `git pull` command is used to [fetch](GitFetch.md) and [integrate changes](Merging.md) from a remote repository into your current branch in your local repository.

Depending on your configuration, `git pull` can be thought of as a combination of two commands:

`git fetch`

Followed by either:

`git merge` or `git rebase`

The decision whether Git will fast-forward, [merge](Merging.md), or [rebase](Rebasing.md) new commits in your current branch 
will be determined by whether your local branch is commits ahead of the remote, and which options have been set:

`git pull --ff-only` will fail if the branches have diverged.

`git pull --no-rebase` will perform a merge if the branches have diverged (this is the default).

`git pull --rebase` will perform a rebase if the branches have diverged.

Alternatively, you can set the `pull.rebase` configuration option in your Git configuration, which will make all further pulls default to using rebase.

#### Note
> - Using `git pull` with merge will create a new merge commit if there are new commits on both the remote branch and your local branch.
> - If you have uncommitted changes in your working directory, `git pull` may fail unless you stash or commit those changes first.
> - If there are conflicting changes between the remote branch and your local branch, you Working Directory will be left in a [Merging status](Working-Tree-States.md#merge-conflicts-merging-status). 
>   You will need to use a tool like [SmartGit Conflict Resolver](../GUI/Branch/Conflict-Solver.md) to resolve conflicts before completing the merge or rebase.
