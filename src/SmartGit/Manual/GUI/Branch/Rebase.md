# Rebasing in SmartGit

[Rebasing](../../GitConcepts/Rebasing.md) is a powerful feature of Git which allows the commit history of branches and commits in a repository to be rearranged.

In SmartGit, there are several ways to initiate a rebase:

- **Menu and toolbar:** On the **Working Tree** window, select **Branch \| Rebase** to open the **Rebase** dialog, where you can select the commit to which the HEAD commits should be rebased.

You can open this dialog using the **Rebase** toolbar button, depending on your toolbar settings.

- **Branches view:** In the **Branches** view, you can right-click on a branch and select **Rebase** to rebase your current HEAD onto the selected branch.
- On the **Graph** of the **Log Window** and **Standard Window**, you can use either of these approaches:
    - **Option 1:** You can perform a rebase by choosing **Rebase** from the **Graph** context menu on a selected commit.
    - **Option 2:** You can drag and drop commits or refs and then select to rebase in the occurring dialog after the drop.

When you start a rebase from a selected commit in the **Graph**, SmartGit may first show **Rebase HEAD to Selected Commit**, offering **Rebase HEAD to** and **Rebase Interactively**.

As with merge and cherry-picking, a rebasing may fail due to merge conflicts.

When a conflict happens, SmartGit will leave the Working Tree in [*rebasing* state](../../GitConcepts/Working-Tree-States.md), allowing you to either [resolve the conflicts](Conflict-Solver.md) or to **Abort** the rebase manually.

For a rebase already in progress, SmartGit provides the **Rebase in progress** dialog with **Continue rebase**, **Skip current patch**, and **Abort rebase**. **Continue rebase** remains disabled until all conflicts have been resolved.

In addition, SmartGit provides advanced UI to support *interactive rebasing*.
Please refer to [Interactive Rebasing](Rebase-Interactive.md).

## Rebase Onto

Rebasing Onto allows the parent commit of an existing commit to be changed.

Example: In the below, we've made a mistake when starting branch `quickfix2`.
Instead of creating a new branch from `main`, we've accidentally branched off branch `quickfix1`.
As a result, `quickfix2` also has all the commits that `quickfix1` in its branch, which means that `quickfix2` cannot be merged into `main` independently of `quickfix1`.

To fix this, we need the `quickfix2` branch to start on the `main` branch instead of the `quickfix1` branch.

The command sequence below performs this rebase.

{% capture rebase_ui_before_setup %}
```bash
git init -b main
echo A > a.txt
git add a.txt
git commit -m "A"
git switch -c quickfix1
echo q1a > q1a.txt
git add q1a.txt
git commit -m "q1a"
echo q1b > q1b.txt
git add q1b.txt
git commit -m "q1b"
git switch -c quickfix2
echo q2a > q2a.txt
git add q2a.txt
git commit -m "q2a"
echo q2b > q2b.txt
git add q2b.txt
git commit -m "q2b"
```
{% endcapture %}

{% capture rebase_ui_after_commands %}
```bash
git rebase --onto main quickfix1
```
{% endcapture %}

{% include git_example.html
  title="Move quickfix2 onto main"
  before="images/rebase-ui-before.png"
  before_alt="quickfix2 starts at q1b and includes the commits from quickfix1."
  before_caption="quickfix2 starts at q1b and includes the commits from quickfix1."
  before_width=224
  before_height=104
  after="images/rebase-ui-after.png"
  after_alt="quickfix2 starts at A and contains only rewritten q2a and q2b."
  after_caption="quickfix2 starts at A and contains only rewritten q2a and q2b."
  after_width=224
  after_height=104
  setup=rebase_ui_before_setup
  commands=rebase_ui_after_commands
%}

> [!NOTE]
> By default, dragging a commit onto one of its own ancestors does not offer the **Rebase** operation.
> This is intended, as such operations are relatively infrequent and offering this operation may negatively impact usability for most users.
> 
> If you want to do such operations using drag-and-drop in the graph, such as a **Rebase** for a single commit, enable advanced drag-and-drop operations by configuring [Low-Level Property](../AdvancedSettings/Low-Level-Properties.md) `log.graph.dragAndDrop.offerAdvancedOperationsForDropsOntoAncestors`.

## Resolving Conflicts

When a merge conflict occurs during Git rebasing, rebase conflicts differ from regular merge conflicts because the *left* and *right* files are swapped in the 3-way merge process.

e.g. when rebasing branch `A` onto branch `B`, Git first checks out branch `B`, then applies all commits from branch `A`.

If a conflict occurs during the rebase operation, the `HEAD` of the Working Tree will be left pointing to branch `B`, so files in the *left* pane refer to the version in branch `B`, and the *right* pane will be branch `A`.
