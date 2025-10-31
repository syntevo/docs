# Git Push

The `git push` command is used to upload new commits from a local repository to a branch on a remote repository (or to multiple remotes).

## Common Usages

`git push <remote> <branch>`

- Uploads new commits from the current local branch to the specified branch on the specified remote.
  If the specified branch does not exist on the remote, a new branch with that name will be created on the remote.

`git push`

- Uploads new commits from the current local branch to its tracked branch on the default remote.
  
  The behavior of git push (with no other options) depends on the [`push.default`](https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushdefault) configuration option in your Git configuration:

  - `simple` (default): Pushes the current branch to its tracked (upstream) branch only if they have the same name.
  - `current`: If the current branch does not exist on the remote, a branch with the same name will be created on the remote.
  - `upstream`: Pushes the current branch to its tracked (upstream) branch, even if they have different names.

`git push --all <remote>`

- Pushes all local branches to the specified remote.


#### Note
> - You can only push commits to a remote repository if you have permission to do so.
> - Many hosting services restrict who can push to certain branches. 
    For example, the default branch (such as `main` or `master`) is often protected to prevent direct pushes. 
>   In such cases, push your changes to a separate branch and create a pull request to allow others to review your changes
    before merging into the main branch.
> - If the target remote branch contains new commits that are not in your local branch, the push will be rejected.
>  In this case, you will need to [fetch](GitFetch.md) and [merge](Merging.md), or [rebase](Rebasing.md), or use [pull](GitPull.md) 
   to include these new commits in your local branch before pushing.
