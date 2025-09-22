# How to perform normal merges and squash merges

A normal merge allows you to join two branches.
A squash merge is similar to a normal merge, except that the information about where the merged-in changes came from is not recorded.
This is illustrated below:

![](images/how-to-perform-normal-merges-and-squash-merges.png)

A normal merge is shown on the left, and a squash merge on the right.
In the normal merge, a new commit F is created by merging the changes from another branch into the current branch.
As a result, F has the two parents D and E.
In the squash merge on the other hand, the new commit F is created by combining the commits B, C and D, and applying them on top of E.
In the history, it will then look as if F had a single parent, namely E.
You may think of squash merging as cherry-picking multiple commits instead of just one.

In SmartGit, normal and squash merges can be performed from the **Standard Window**, the **Log Window**, or the **Working Tree Window**.
In all cases, make sure you've checked out the target branch onto which you want to apply the merge commit.

-   **Standard Window**: In the **Graph** view, right-click the topmost commit (i.e. the newest) from the commits you want to merge or squash-merge into the current branch.
    Select **Merge**.
    On the confirmation dialog, choose either **Merge to Working Tree** or **Create Merge-Commit** for a normal merge.
    For a squash merge, choose **Merge to Working Tree**.
-   **Log Window**: In the **Graph** view, right-click the topmost commit (i.e. the newest) from the commits you want to merge or squash-merge into the current branch.
    Select **Merge**.
    On the confirmation dialog, choose either **Merge to Working Tree** or **Create Merge-Commit** for a normal merge.
    For a squash merge, choose **Merge to Working Tree**.
-   **Working Tree Window**: From the main menu, select **Branch\|Merge**.
    In the Merge dialog, select the topmost commit (i.e. the newest) from the commits you want to merge or squash-merge into the current branch.
    For a normal merge, choose either **Merge to Working Tree** or **Create Merge-Commit** (the latter will automatically create a commit).
    For a squash merge, select **Merge to Working Tree**.

Regardless of which window you merged from,
if you had selected **Create Merge-Commit**, you are most likely done.
If there were merge conflicts or you had selected **Merge to Working
Tree**, conflicts have to be resolved now and you'll finally need to
perform a commit (e.g. by selecting **Local\|Commit** in the menu) to
conclude the merge operation. On the commit dialog, you can choose now
whether you want to perform a normal merge (**Merge Commit**) or a
squash merge (**Simple commit**).
Enter a commit message, select the
appropriate merge type, then click on **Commit**.
