---
redirect_from:
  - /SmartGit/Latest/Merge
  - /SmartGit/Latest/Merge.html
---

# Merging in SmartGit

For an overview of general merging techniques in Git, please refer to *[Merge](../../GitConcepts/Merging.md)*.

In SmartGit, there are several ways to initiate a merge:

-   **Menu and toolbar:** In the Working Tree window, select **Branch \| Merge** to open the **Merge** dialog, where you can choose the
    branch to be merged into the current branch. Depending on your
    toolbar settings, you can also open this dialog via the **Merge**
    button on the toolbar.
-   **Branches view:** In the **Branches** view (available in both the
    Working Tree and Log windows), you can right-click on a branch and
    select **Merge** to merge the selected branch into the current branch. 
-   **Log Graph:** In the Log graph of the **Log** window, right-click on a commit (usually the one where
    the branch to be merged points to) and selecting **Merge** from
    the context menu.

Regardless of how you invoke the Merge command, you will be given a
choice between **Create Merge-Commit**, **Merge to Working Tree**,
and, if possible, **Fast-Forward**.

-  If you choose **Create Merge-Commit**, SmartGit will perform the merge
and create a merge commit, assuming no merge conflicts exist.
-  If you choose **Merge to Working Tree**, SmartGit will perform the merge but leave the working tree in a *merging*
state, allowing you to resolve conflicts and review changes manually. 
See the section on *[Resolving Conflicts](#resolving-conflicts)* for more information.

## Resolving Conflicts

When a merge, [cherry-pick](Cherry-Pick.md), [revert](Revert.md) or [rebase](Rebase.md) command fails due to
conflicting changes, SmartGit stops the operation and leaves the working tree conflicted. 
This allows you to either abort the command, resolve the conflicts, or continue the operation.
The following options are available in SmartGit:

-   **Resolve dialog:** Select a file containing conflicts and invoke **Local \| Resolve** from SmartGit's main window menu.
    You can set the file's contents to either of the two conflicting versions (i.e., \`Ours' or \`Theirs'). Optionally, you may choose not to stage the resolution, meaning the conflict marker on the file won't be removed.
-   **Conflict Solver:** Select a file containing conflicts and
    invoke **Query \| Conflict Solver**, which opens a three-way diff tool for viewing changes between the conflicting versions.
    See *[Conflict Solver](Conflict-Solver.md)* for details on resolving conflicts using this tool.
-   **Discard command:** To abort the merge, cherry-pick, revert or rebase, select the repository in the **Repositories** view and
    invoke **Branch \| Abort** or **Local \| Discard**.

After resolving all conflicts, you can continue with the merge, cherry-pick, or rebase by selecting the repository in the 
**Repositories** view and invoking **Local \| Commit**. If you rebase, the **Commit** toolbar button will change to
**Continue**.
