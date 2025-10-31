# Git Remote Repositories (Remotes)

Although much of Git's functionality is designed to work within a local repository, you will need to synchronize your commits with 
other repositories to collaborate with other developers.

Synchronizing with Remote Repositories (Remotes) allows others to receive the work you've committed, and likewise, allows you update your local repository with commits made by others.

Although  a remote could be any repository separate from your current local repository, commonly, you will work with remote repositories which are:
- Private, self-hosted repositories on your organization's server infrastructure or hosted privately in the cloud
- Open-source or public repositories hosted on a Git hosting service such as GitHub, GitLab, Bitbucket, or Azure DevOps.

## Common Commands for Working with Remotes

### Cloning a remote repository

`git clone <url>` 

Creates a local copy of a remote repository under the current folder.

By default, the local repository will be created in a subfolder with the same name as the repository. 

Use `git clone <url> <folder>` to specifiy a different folder name.

Git will default the name of the remote to `origin`, however, you can override the name by providing the option `--origin <name>`.

### Add a new remote

`git remote add <remote> <url> `

This will create a link between your local repository and a remote in your git configuration.
This command is useful if you have recently created a new local repository (e.g., with `git init`) or if you want to synchronize with more than one remote (e.g., see Forking, below).

By convention, the default remote name is `origin`. However, you can provide any name, which can be important if your repository is connected multiple remotes.

### Receiving recent changes from a remote (Fetch or Pull)

Either of the following approaches retrieves changes from a remote and integrates them into a branch in your local repository:

- [`git fetch`](GitFetch.md) followed by [`git merge`](Merging.md) or [`git rebase`](Rebasing.md), 

  or [`git pull`](GitPull.md)

- Use [`git push`](GitPush.md) to synchronize new commits from your local repository to a remote.

### Forking

In many private repositories, authorized developers have sufficient access to create new feature branches and push new commits directly to the remote.

Git hosting providers (like GitHub) can allow the important branches (such as `main` or `master`) to be protected from direct pushes.
In these cases, after pushing changes to a feature branch, a pull request can be created between the two branches. 
Changes can then be reviewed and merged (or fast-forwarded) once approved.

However, on many public and open-source repositories, only authorized collaborators can create branches or push commits.
Other developers will be able to clone the repository, but they must create a **fork** of the repository on the remote server to be able to contribute to it.
Any new commits are pushed to the forked repository, and a pull request (PR) can be created between the forked and original repository.
The maintainers of the original repository can then review and accept the changes.

With forking, your local repository will be linked to multiple remotes - commonly, the original repository is referred to as `upstream`, and the forked repository as `origin`.

### Other useful commands when working with remotes

`git remote -vv`

- Lists all remotes linked to your local repository along with their URLs.

`git branch -r`

- Lists all branches on the remote. Add the `-a` switch to show both remote and local branches.

`git remote set-url <remote> <url>`

- Changes the URL of a remote. This is useful if the location of a repository changes (e.g., moving from GitHub to BitBucket).
