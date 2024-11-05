# How to perform normal merges and squash merges

A normal merge allows you to join two branches. A squash merge is
similar to a normal merge, except that the information about where the
merged-in changes came from is not recorded. This is illustrated below:

![](attachments/6979700/6979701.png)

A normal merge is shown on the left, and a squash merge on the right. In
the normal merge, a new commit F is created by merging the changes from
another branch into the current branch. As a result, F has the two
parents D and E. In the squash merge on the other hand, the new commit F
is created by combining the commits B, C and D, and applying them on top
of E. In the history, it will then look as if F had a single parent,
namely E. You may of think of squash merging as cherry-picking multiple
commits instead of just one.

In SmartGit, normal and squash merges can be performed either from the
main window or the log window. In either case, make sure you've checked
out the branch onto which you want to apply the merge commit.

-   Main window: From the main menu, select **Branch\|Merge**. On the
    Merge dialog that shows up, first select the topmost commit (i.e.
    the newest) from the ones you want to want to merge or squash merge
    into the current branch. If you want to perform a normal merge,
    choose either **Merge to Working Tree** or **Create Merge-Commit**.
    The second option will automatically create a commit. In the case of
    a squash merge, you have to select the **Merge to Working Tree**
    option.
-   Log window: On the *Commits* view, right-click on the topmost commit
    from the ones to merge or squash merge into the current branch. In
    the context menu, click on **Merge**. Now a confirmation dialog
    shows up. If you want to perform a normal merge, choose either
    **Merge to Working Tree** or **Create Merge-Commit**. The second
    option will automatically create a commit. In the case of a squash
    merge, you have to select the **Merge to Working Tree** option.

Regardless of whether you merged from the main window or the log window,
if you had selected **Create Merge-Commit**, you are most likely done.
If there were merge conflicts or you had selected **Merge to Working
Tree**, conflicts have to be resolved now and you'll finally need to
perform a commit (e.g. by selecting **Local\|Commit** in the menu) to
conclude the merge operation. On the commit dialog, you can choose now
whether you want to perform a normal merge (**Merge Commit**) or a
squash merge (**Simple commit**). Enter a commit message, select the
appropriate merge type, then click on **Commit**.


