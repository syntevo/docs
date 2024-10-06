# Check Out

There are various ways to check out in SmartGit:

-   **Working tree/Log window** Double-click on a branch in the **Branches** view and confirm the **Check Out** dialog that comes up.
-   **Working tree window** Invoke **Branch\|Check Out** from the menu.
    This will open a dialog containing a Log view, where you can select the commit to check out.
-   **Log window** On the [Log window](Log.md), select the commit to check out and then select **Check Out** from its context menu.

If you check out a remote branch, you can optionally create a new local
branch (recommended) and set up branch tracking.

If you check out a local branch that tracks a remote branch, and the
latter is ahead of the local branch by a couple of commits, you can
decide whether you want to just check out the latest commit of the local
branch, or to check out and let SmartGit do a fast-forward merge to the
latest commit of the remote branch. For further information on merging,
see [Merge](Merge.md).

## Checkout tasks

-   If you have local changes in your working tree, the Check Out might
    fail. In this case, SmartGit offers you to stash away the local
    changes before executing the actual Check Out command and re-apply
    the changes from the stash after executing the command. For further
    information on stashes, see
    [Stashes](Local-Operations-on-the-Working-Tree.md#stashes).

-   If a `.gitattributes` file is present in your repository and its
    content differs between the checkout source commit (old commit) and
    the checkout target commit (new commit), SmartGit will invoke a
    thorough inspection of line endings present in your working tree:
    due to `.gitattributes` changes the line endings for certain files
    may have to be changed.


	#### Note
	> Usually, line endings correction won't be necessary and this part of
	> the Check Out performs quickly (or you won't even notice it).
	> Certain changes to `.gitattributes` may affect many (or all files),
	> though. In this case, line endings correction may require a
	> significant amount of time.



 

 
