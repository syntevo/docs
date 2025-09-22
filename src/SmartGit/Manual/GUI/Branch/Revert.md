# Reverting Commits in SmartGit

The [`git revert`](../../GitConcepts/Reverting.md) command allows you to 'undo' the effects of unwanted commits in the current branch by creating a new commit that represents the work needed to reverse the changes from previous commits.

In SmartGit, there are several ways to initiate a revert operation:

- **Menu and toolbar**: In the **Working Tree Window**, select **Branch \| Revert** to open the **Revert** dialog, where you can choose one or more commits to revert.
  You can open this dialog via the **Revert** button, depending on your toolbar settings.
- **Graph**: In the **Graph** of the **Log Window** and **Standard Window**, right-click one or more commits and select **Revert** from the **Graph** context menu.

In case of a conflict, the revert process may stop in a ["reverting"](../../GitConcepts/Working-Tree-States.md) state, from which you can either:

- Fix the conflict and **Continue** (from the banner), or
- **Abort** the Revert (from the banner) and return to the previous repository state.

See *[Resolving Conflicts](Merge.md#resolving-conflicts)* for more information on how to handle conflicts.
