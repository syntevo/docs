# How to perform squash merges

In SmartGit, squash merges can be performed from the **Standard Window**, the **Log Window**, or the **Working Tree Window**.
Make sure you've checked out the target branch onto which you want to apply the merge commit.

-   **Standard Window**: In the **Graph** view, right-click the topmost commit (i.e. the newest) from the commits you want to squash-merge into the current branch.
    Select **Merge** and, on the confirmation dialog, choose **Merge to Working Tree**.
-   **Log Window**: In the **Graph** view, right-click the topmost commit (i.e. the newest) from the commits you want to squash-merge into the current branch.
    Select **Merge** and, on the confirmation dialog, choose **Merge to Working Tree**.
-   **Working Tree Window**: From the main menu, select **Branch\|Merge**.
    In the Merge dialog, select the topmost commit (i.e. the newest) from the commits you want to squash-merge into the current branch.
    Ensure **Branch consisting of selected commit and its ancestors** is selected, then click **Merge**.

Regardless of which window you merged from,
your working tree is now in a merging state. If there are any conflicts,
you'll have to resolve them before you can proceed. Resolving conflicts
is covered in another How-To: [How to resolve conflicts](How-to-resolve-conflicts.md).

If there weren't any conflicts, or after all conflicts have been resolved, perform a commit (e.g. **Local\|Commit**) to finish the squash merge operation.
On the commit dialog, choose **Simple commit ("squash")** (instead of **Merge commit**), enter a commit message, then click **Commit**.


> [!NOTE]
> Don't be puzzled if the resulting Git commands (reported in the **Output** view) do not mention a `--squash` option.
> Before committing, SmartGit simply deletes `.git/MERGE_HEAD` to convert the scheduled merge to a simple commit.
