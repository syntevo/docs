---
redirect_from:
  - /SmartGit/Latest/DevelopmentProcesses
  - /SmartGit/Latest/DevelopmentProcesses.html
---

# Support for Standard Development Processes in SmartGit
Although Git's flexibility allows for almost unlimited variations in how teams work within a repository, most developers are familiar with standard branching, merging, and rebasing strategies that promote systematic and productive workflows.

Common branching strategies in Git include:

- **[Git-Flow](Git-Flow.md):** Popularized by Vincent Driessen, Git-Flow is suitable for systems that require formal release management and production hotfix capabilities. It also supports the concurrent development of new features in isolation within the repository.
Although Git-Flow's popularity has declined in recent years, it remains relevant when multiple teams contribute to a repository, especially when there is a need to support multiple production versions of a product.
- **[Git-Flow Light](Git-Flow-Light.md):** A SmartGit specific strategy similar to [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow). Git-Flow Light is suitable for repositories where only a single release version needs to be maintained at any point in time, such as in Web or API-based applications.
- **Trunk-Based Development (TBD):** This strategy focuses on maintaining a single long-lived trunk branch (e.g., `main`, which has historically replaced `master`) in a repository.
While short-lived branches may exist, commits on these branches are usually fast-forwarded or rebased onto the trunk to maintain a linear commit history. This approach is popular with smaller teams, or in environments where pair or mob team programming is common. In TBD, progress is made through small, frequent commits to the trunk branch, which can then be continuously built and deployed. TBD can be easily achieved in SmartGit using standard Git commands like Checkout, Commit, Rebase, and Push.

In addition to all standard Git features, SmartGit provides custom support for both the **Git-Flow** and **Git-Flow Light** strategies.
