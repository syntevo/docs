---
redirect_from:
  - /SmartGit/Latest/Check-Out
  - /SmartGit/Latest/Check-Out.html
---
# Using Check Out in SmartGit

The [Git Checkout Command](../../GitConcepts/Branches.md#working-with-branches-using-checkout) is used to switch between branches in a repository.

There are several ways to check out in SmartGit:

- **Working Tree/Log Window**: Double-click on a branch in the **Branches** view and confirm the **Check Out** dialog that appears.
- **Working Tree Window**: Invoke **Branch \| Check Out** from the menu. This opens a dialog containing a Log view, where you can select the commit to check out.
- **Log window**: In the [Log window](Log.md), select the commit to check out, and then select **Check Out** from the context menu.

When you check out a remote branch, you can optionally create a new local branch and set up branch tracking. It is recommended to generally make changes in your Working Tree after checking out a branch.

If you check out a local branch that tracks a remote branch, and if the remote branch has commits ahead of the local branch, you can either:
- Check out the local branch without merging new commits from the remote tracking branch, or
- Check out the local branch and allow SmartGit to perform a fast-forward merge to the latest commit of the remote branch.

For more information on merging, see [Merge](Merge.md).

## Common Issues during Checkout

-   If you have local changes in your working tree, the check out process may fail. In this case, SmartGit will offer to stash the local changes before executing the actual Check Out command, and then re-apply the changes from your stash after the command completes. For more information on stashes, see [Stashes](Local-Operations-on-the-Working-Tree.md#stashes).
-   If a `.gitattributes` file is present in your repository and its content differs between the checkout source commit (old commit) and the checkout target commit (new commit), SmartGit will inspect the line endings in your working tree. Changes in `.gitattributes` may require line endings for certain files to be modified.

#### Note
In most cases, line-ending corrections won't be necessary, and this part of the Check Out process is quick (you may not even notice it). However, certain changes to `.gitattributes` can affect many (or all) files, which may cause line-ending correction to take more time.

