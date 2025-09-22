# Rebasing in SmartGit

[Rebasing](../../GitConcepts/Rebasing.md) is a powerful feature of Git which allows the commit history of branches and commits in a repository to be rearranged.

In SmartGit, there are several ways to initiate a rebase:

- **Menu and toolbar:** On the **Working Tree** window, select **Branch \| Rebase** to open the **Rebase** dialog, where you can select the branch to rebase the HEAD onto, or the branch to rebase onto the HEAD, respectively.

You can open this dialog using the **Rebase** toolbar button, depending on your toolbar settings.

- **Branches view:** In the **Branches** view, you can right-click on a branch and select **Rebase** to rebase your current HEAD onto the selected branch.
- On the **Log Graph** of the **Log** and **Standard** window, you can use either of these approaches:
    - **Option 1:** You can perform a rebase by using the **Graph** context menu -> **Rebase** on a selected commit.
    - **Option 2:** You can drag and drop commits or refs and then select to rebase in the occurring dialog after the drop.

As with merge and cherry-picking, a rebasing may fail due to merge conflicts.

When a conflict happens, SmartGit will leave the Working Tree in [*rebasing* state](../../GitConcepts/Working-Tree-States.md), allowing you to either [resolve the conflicts](Conflict-Solver.md) or to **Abort** the rebase manually.

In addition, SmartGit provides advanced UI to support *interactive rebasing*.
Please refer to [Interactive Rebasing](Rebase-Interactive.md).

## Rebase Onto

Rebasing Onto allows the parent commit of an existing commit to be changed.

Example: In the below, we've made a mistake when starting branch `quickfix2`.
Instead of creating a new branch from `main`, we've accidentally branched off branch `quickfix1`.
As a result, `quickfix2` also has all the commits that `quickfix1` in its branch, which means that `quickfix2` cannot be merged into `main` independently of `quickfix1`.

To fix this, we need the `quickfix2` branch to start on the `main` branch instead of the `quickfix1` branch.

``` text
     o q2b [quickfix2]
     |
     o q2a
    /
   o q1b [quickfix1]
   |
   o q1a
 /
 o A [main]
 |
 .
```

To fix the branching, drag the `q2a` commit onto the `A [main]` commit.
This will result in the intended branching:

``` text

 o q1b [quickfix1]
 |
 |       o q2b [quickfix2]
 |       |
 o q1b   o q2a
  \     /  
   \   /  
     o A [main]
     |
     .
```

> [!NOTE]
> By default, dragging a commit onto one of its own ancestors does not offer the **Rebase** operation.
> This is because commits themselves are not considered drop targets -- only the space between them is.
> Supporting such drag operations would require changing this behavior, which could negatively impact usability for most users due to the increased complexity.
>
> To still be able to perform such a **Rebase** for a single commit, you can enable advanced drag-and-drop operations by configuring [Low-level property](../AdvancedSettings/Low-Level-Properties.md) `log.graph.dragAndDrop.offerAdvancedOperationsForDropsOntoAncestors`.

## Resolving Conflicts

When a merge conflict occurs during Git rebasing, rebase conflicts differ from regular merge conflicts because the *left* and *right* files are swapped in the 3-way merge process.

e.g. when rebasing branch `A` onto branch `B`, Git first checks out branch `B`, then applies all commits from branch `A`.

If a conflict occurs during the rebase operation, the `HEAD` of the Working Tree will be left pointing to branch `B`, so files in the *left* pane refer to the version in branch `B`, and the *right* pane will be branch `A`.
