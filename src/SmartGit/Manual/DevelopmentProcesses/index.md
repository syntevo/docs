# Support for Standard Development Processes in SmartGit

Although Git's flexibility allows for almost unlimited variations in how teams work within a repository, most developers are familiar with standard branching, merging, and rebasing strategies that promote systematic and productive workflows.

Common branching strategies in Git include:

- **[Git-Flow](Git-Flow.md)**, popularized by Vincent Driessen, Git-Flow is suitable for systems that require formal release management and production hotfix capabilities.
GitFlow supports the concurrent development of new features in isolation within the repository, while simultaneously maitaining previous releases.
GitFlow is also relevant when multiple teams contribute to a repository, especially when there is a need to support multiple production versions of a product.
- **[Git-Flow Light](Git-Flow-Light.md)** is a SmartGit specific strategy similar to [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow).
Git-Flow Light is suitable for repositories where only a single release version needs to be maintained at any point in time, such as in Web or API-based applications.
- **[Feature-Flow](Feature-Flow.md)** available only on the SmartGit **Standard Window**, is a flexible feature branching process.
The key difference with Feature Flow is that features can be started off any trunk branch, and SmartGit will automatically assist with ensuring changes made in the feature branch can be integrated with the source trunk branch, as well as managing common actions required when finishing a feature.
- **Trunk-based Development (TbD)** is a strategy focuses on maintaining a single long-lived trunk branch (e.g., `main`, which has historically replaced `master`) in a repository.
While short-lived branches may exist, commits on these branches are usually fast-forwarded or rebased onto the trunk to maintain a linear commit history.
This approach is popular with smaller teams, or in environments where pair or mob team programming is common.
In TbD, progress is made through small, frequent commits to the trunk branch, which can then be continuously built and deployed.
TbD can be easily achieved in SmartGit using standard Git commands like Checkout, Commit, Rebase, and Push.

In addition to all standard Git features, SmartGit provides custom support for both the **Git-Flow** and **Git-Flow Light** strategies.

## Related How-Tos

- [Modifying the History](../../HowTos/Workflows/Modifying-the-History.md): Learn how to rebase, squash, and reorder commits - essential techniques for maintaining clean history in feature branches and trunk-based development
- [How to resolve conflicts](../../HowTos/Workflows/How-to-resolve-conflicts.md): Step-by-step guide for resolving merge conflicts that commonly occur when integrating feature branches or syncing with trunk branches
- [How to perform a cherry-pick](../../HowTos/Workflows/How-to-perform-a-cherry-pick.md): Apply specific commits from one branch to another, useful for hotfix workflows in Git-Flow and selective feature integration
- [GitHub: keeping in sync with the upstream repository](../../HowTos/Workflows/GitHub-keeping-in-sync-with-the-upstream-repository.md): Manage upstream repositories and collaborate effectively in fork-based development workflows
