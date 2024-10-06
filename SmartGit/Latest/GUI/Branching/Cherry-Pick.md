---
redirect_from:
  - /SmartGit/Latest/Cherry-Pick
  - /SmartGit/Latest/Cherry-Pick.html
---
# Cherry-Picking in SmartGit

Cherry Picking allows you to apply one or more (arbitrary) commits from other branches into the current branch in the Working Tree.
Please refer to the section on **[Cherry-Picking](../../GitConcepts/Cherry-Picking.md)** for an overview. 

In SmartGit, there are several ways to initiate a cherry-pick:

-   In the working tree window, select **Branch \| Cherry-Pick** to open the **Cherry-Pick** dialog, where you can select one or more commits to cherry-pick. You can open this dialog via the **Cherry-Pick** button, depending on your toolbar settings.
-   In the **Log Graph**, you can perform a cherry-pick by right-clicking on one or more commits and selecting **Cherry-Pick** from the context-menu.
-  You can cherry-pick a subset of files from the **Log's Files** view context-menu.

In case of a conflict, the Cherry-Pick may stop in ["cherry-picking" state](../../GitConcepts/Working-Tree-States.md#cherry-picking-status), for which you can either:

- Fix the conflict and **Continue** (from the banner), or
- **Abort** the Cherry-Pick (from the banner) and revert to the previous repository state.

See **[Resolving Conflicts](Merge.md#resolving-conflicts)** for further information on handling conflicts and refer to the [SmartGit Conflict Resolver](Conflict-Solver.md).
