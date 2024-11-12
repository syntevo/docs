# Merge

### 'Normal' Merge

In case of a normal merge, a merge commit with at least two parent
commits (i.e., the last from the current branch and the last from the
merged branch) is created. See the following figure, where `>` indicates
where the HEAD is pointing to:



``` text
                            o [> master]
                            |\
o [> master]                o \
|                  ==>      |  |
|  o [a-branch]             |  o [a-branch]
.  .                        .  .
```



### Fast-forward Merge

If the current branch is completely included in the branch to be merged
with (i.e. the latter is simply a couple of commits ahead), then no
extra merge commits is created. Instead, the branch pointer of the
current branch is moved forward to match the branch pointer of the other
branch, as shown below:



``` text
o [origin/master]             o [> master][origin/master]
|                     ==>     |
o [> master]                  o
.                             .
```



In SmartGit, there are several places from which you can initiate a
merge:

-   **Menu and toolbar** On the Working tree window, select **Branch\|Merge** to open the **Merge** dialog, where you can select the
    branch to be merged into the current branch. Depending on your
    toolbar settings, you can also open this dialog via the **Merge**
    button on the toolbar.
-   **Branches view** In the **Branches** view (available both on the
    Working tree and the Log window), you can right-click on a branch and
    select **Merge** to merge the selected branch into the current
    branch.
-   **Log Graph** On the Log graph of the **Log** window, you can
    perform a merge by right-clicking on a commit (usually the one where
    the branch to be merged with points to) and selecting **Merge** from
    the context-menu.

Regardless of how you invoked the Merge command, you will be given the
choice between **Create Merge-Commit** and **Merge to Working Tree**,
and optionally also **Fast-Forward** if a fast-forward merge is
possible.

If you choose **Create Merge-Commit**, SmartGit will perform the merge
and create a merge commit, assuming there are no merge conflicts. If
there are merge conflicts, or if you choose **Merge to Working Tree**,
SmartGit will perform the merge, but leave the working tree in a
*merging* state, so that you can manually resolve merge conflicts and
review the changes to be made. See [Resolving Conflicts](#resolving-conflicts) for further information on how to deal
with merge conflicts.

### Squash Merge

The squash merge works like a normal merge, except that it discards the
information about where the changes came from. Hence it only allows you
to create normal commits. The squash merge is useful for merging changes
from local (feature) branches where you don't want all of your feature
branch commits to be pushed into the remote repository.



``` text
                            o [> master] (changes from a-branch)
                            |
o [> master]                o
|                  ==>      |
|  o [a-branch]             |  o [a-branch]
.  .                        .  .
```



On the **Commit** dialog, you can choose between a normal merge (merge
commit) and a squash merge (simple commit). Thus, to perform a squash
merge you have to choose **Merge to Working Tree** when initiating the
merge, since otherwise you won't see the **Commit** dialog.

### Merge versus Rebase

A Git-specific alternative to merging is *rebasing* (see
[Rebase](Rebase.md)), which can be used to keep the history linear.
For example, if a user has made local commits and performs a pull with
merge, a merge commit with two parent commits - the user's last commit
and the last commit from the tracked branch - is created. When using
rebase instead of merge, Git applies the local commits on top of the
commits from the tracked branch, thus avoiding a merge commit.

## Resolving Conflicts

When a merge, a [cherry-pick](Cherry-Pick.md) (or
its counterpart, the [revert](Revert.md)) or a [rebase](Rebase.md) fails due to
conflicting changes, SmartGit stops the operation and leaves the working
tree in a conflicted state, so that you can either abort the operation,
or resolve the conflicts and continue with the operation. This section
explains how you can do that with SmartGit. Generally, the following
options are available:

-   **Resolve dialog** If you select a file containing conflicts and
    then invoke **Local** **\|Resolve** in the menu of SmartGit's main
    window, you can set the file's contents to either of the two
    conflicting versions, i.e. \`Ours' or \`Theirs'. Optionally, you may
    also choose not to stage the resetting of the file contents, meaning
    that the conflict marker on that file won't be removed.
-   **Conflict Solver** Selecting a file containing conflicts and
    invoking **Query** **\|Conflict Solver** will open the Conflict
    Solver, a three-way diff between the two conflicting versions (left
    and right editor) and a third version (center editor) that contains
    the conflicting hunks from both sides, along with conflict markers.
    You can directly edit the text in the center editor, and you can
    move changes from the left and right side into the center by
    clicking on the arrow and \`x' buttons between the editors.
-   **Discard command** To abort the merge, cherry-pick, revert or
    rebase, select the repository in the **Repositories** view and
    invoke **Branch \|Abort** or **Local** **\|Discard**.

Lastly, if all conflicts have been resolved, you can continue with the
merge, cherry-pick or rebase by selecting the repository in the
**Repositories** view and invoking **Local** **\|Commit**. If you are
rebasing, the Commit toolbar button has changed its name to
**Continue**.
