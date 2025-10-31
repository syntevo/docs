# Git Fetch

The [`git fetch`](https://git-scm.com/docs/git-fetch) command is used to retrieve new commits, branches, and tags from one or more remote repositories
into your local repository, without merging them into your current branch.

This allows you to review changes made to the remote before deciding whether to integrate them into your current branch.

When you run `git fetch`, Git contacts the remote repository and downloads any new commits added since your last fetch or pull, into your local repository. 

This can include
- New commits
- Newly created branches on the remote
- New tags

Any changes to remote tracking references (`refs/remotes/`) will be refreshed.

**##Common Usage##**

`git fetch -all`

- Fetches new commits from all configured remotes.

`git fetch <remote>`

- Fetches new commits from the specified remote.

`git fetch <remote> <branch>`

- Fetches new commits only from the specified remote and branch.

`git fetch --tags`

- By default, only tags reachable from branches in your local repository are fetched.

The `--tags` option allows you to fetch all tags from the remote repository.

#### Note:

> You can modify the default behavior of `git fetch` by changing the [`fetch` setting](https://git-scm.com/docs/git-fetch#_named_remote_in_configuration_file)
> for a specific remote in your Git configuration, under the `[remote "<remote>"]` section.
