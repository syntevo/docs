---
redirect_from:
  - /SmartGit/Latest/Git-Flow-Light
  - /SmartGit/Latest/Git-Flow-Light.html
---

# Git-Flow Light

Git-Flow Light is a SmartGit-specific subset of Git-Flow, simplifying the branching model to just one long-lived **Development** trunk branch and short-lived **Feature** branches.

### Develop Branch

The 'develop' branch contains the ongoing development line. 
It includes all finished improvements and fixes that have been merged.

### Feature Branches

For each new (non-trivial) improvement that should be added to the ongoing development line, a separate 'feature/X' branch is created (e.g., `feature/my-feature`). 

This temporary branch works independently on the specific improvement ('feature').

Once the feature is complete, the commits from the 'feature' branch are integrated (either merged or rebased) into the [develop](#develop-branch) branch, and the feature branch is usually deleted. 

This way, you can see all features currently in progress by viewing the open `feature/` branches.


``` text
o ... [> develop] merge feature A into develop
| \
|  o ...[featureA]  a commit on featureA
|  |
o  | ... subsequent commit on develop not on featureA
| /
o  ... commit on develop
```

### Configuration for Git-Flow Light in SmartGit

To start using Git-Flow Light for your repository, go to **Branch \| Git-Flow \| Configure**, select the **Light** type and adjust the branch names as necessary.

For existing repositories, you can set `main` as your development branch (historically referred to as 'master').

Since Git-Flow Light is a subset of GitFlow, refer to [the Git-Flow documentation](Git-Flow.md#git-flow-commands) for the meaning and purpose of each command.
