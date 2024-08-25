# Rebase

The Rebase command allows you to apply commits from one branch to another.
Rebase can be viewed as more powerful version of [Cherry-Pick](Cherry-Pick.md), which is optimized to apply multiple commits from one branch to another.

**Rebase** "moves" (actually "rewrites") the commits below the HEAD to the selected commit. The HEAD will be moved to the new fork.

``` text
o  [> master] A               o  [> master] A'
|                             |
o   B                         o  B'
|                             |
o   C                         o  C'
|                             |
|   o  [a-branch] D           |   o  [a-branch] D
|   |                         |  /
|   |                         | /
|   o  E (selected)   ===>    o   E
|  /                          |
| /                           |
o   F                         o   F
```
To **Rebase Onto** you may use the **Log** window.
Consider following example where the `quickfix2` branch should not start at the `quickfix1` branch, but rather on the `master` branch:

``` text
q2b (quickfix2)
 |
q2a
 |
q1b (quickfix1)
 |
q1a
 |
 x (master)
 |
...
```
To achieve this, just drag the `q2a` commit onto the `x (master)` commit and you will get the desired result:
``` text
q2b (quickfix2)
 |
q2a
 |
 |  q1b (quickfix1)
 |   |
 |  q1b
 | /
 x (master)
 |
...
```
In SmartGit, there are several places from which you can initiate a rebase:

-   **Menu and toolbar** On the Working tree window, select **Branch\|Rebase** to open the **Rebase** dialog, where you can select the branch to rebase the HEAD onto, or the branch to rebase onto the HEAD, respectively.
    Depending on your toolbar settings, you can also open this dialog using the **Rebase* toolbar button.
-   **Branches view** In the **Branches** view, you can right-click on a branch and select **Rebase** to rebase your current HEAD onto the selected branch.
-   **Log Graph** On the Log graph of the **Log** window, you can perform a rebase by right-clicking on a commit and selecting **Rebase** from the context-menu.
-   **Log Graph** In the Log graph of the **Log** window, you can drag and drop commits or refs and then select to rebase in the occurring dialog after the drop.

Just like a merge, a rebase may fail due to merge conflicts.
If that happens, SmartGit will leave the working tree in *rebasing* state, allowing you to either manually resolve the conflicts or to **Abort** the rebase.

## Resolving Conflicts

Core Git rebase conflicts are different to other kinds of merge conflicts, because *left* and *right* files are swapped: when rebasing branch `A` to `B`, Git will first checkout `B`, then applies all commits from `A`.
If a conflict occurs, `HEAD` still points to `B` and hence the *left* file would be the file as it's present in `B`.

## Interactive Rebase

For details on *interactive rebase* refer to [Interactive Rebase](Rebase-Interactive.md).
