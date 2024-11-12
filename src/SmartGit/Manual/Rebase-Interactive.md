# Interactive Rebase

SmartGit packages the Git interactive rebase functionality (`git rebase -i`) in simple as well as elaborate ways,
both in the [Log Graph](Log.md) and the [Journal View](Journal-View.md):

## Quick rearranging and squashing

Depending on the type of commit(s) selected, you can invoke various
operations from the context menu, most notably, you can easily rewrite
the history:

- To squash adjacent commits, select them and invoke **Squash Commits** and provide the new commit message.
- To reorder commits, just use drag and drop.
- To coalesce two (not necessarily adjacent) commits *with the same commit message*, drag one of the commits onto the other one.
- To change the commit message, select the commit and invoke **Edit Commit Message**.
- To change the author, select the commit and invoke **Edit Author**.

### Modify

To modify (or amend) a commit, select the commit and invoke **Modify** from the context menu.
This will start an interactive rebase and stop after the selected commit.
Perform the modification, then **Commit** (optionally using **Amend**).
Finally, click **Step** (in the banner) to let the rebase advance only to the next commit which then can be modified again.
Or click **Continue** (in the banner) to let the rebase run through completely.
To abort the Modify command and go back to the previous state, click **Abort**.

### Split

To split a commit, select the commit and invoke **Split** from the context menu.
This will start an interactive rebase and stop with the commit's changes in the Index.
**Unstage** or **Discard** all changes that you don't want to have in the first commit, and click **Continue** (in the banner).
After the first commit has been created, you can continue staging changes for the second commit and click **Continue** again, ...
Once all changes have been committed, finally click **Continue** once again to finish the rebase.

SmartGit will warn you if the new commits do not contain all changes of the old commit.
You may continue or let SmartGit put the missing changes into the Index.

## Using the interactive rebase editor

As stated above, you can perform various operations immediately, e.g. reordering commits by drag and drop.
If you have to make multiple changes at once you should rather use the Interactive Rebase.

To start the interactive rebase command, select the first commit that should be changed and invoke **Rebase Interactive From** from the context menu.
In the *Interactive Rebase* dialog you will be able to squash commits, reorder using drag and drop, edit commit messages, but these operations will only be executed when clicking the **Rebase** button.
In case of conflicts, the rebase will stop (like a normal rebase, too).
After solving the conflicts, click the **Continue** banner button.
To abort the interactive rebase and go back to the previous state, use the **Abort** button.

Commits with the same commit message are highlighted, so it is easier to see commits belonging together.
They can be amend-squashed by using drag and drop.
Alternatively, the Auto-Squash button offers following options how to squash such commits:

- To Top Commit: will move equally named commits to their last commit and squash them.
- Neighboring Commits: will squash those equally named, neighboring (adjacent) commits.
- To Bottom Commit: will move equally named commits to their first commit and squash them.

### Tip 1
When setting the low-level property **log.useCommitMessage.prefix** to, e.g. "`fixup! `", **Use Commit Message** (from the Log's or Journal's context menu) will use that as prefix for the message, and the Interactive Rebase will treat `foo` and `fixup! foo` as equally named.

### Tip 2
If the low-level property **git.rebaseInteractive.autoSquash** is set, the Interactive Rebase will automatically squash adjacent commits where the second commit has the "`fixup! <msg>`" message where `<msg>` is the previous commit's message (independent of the low-level property **log.useCommitMessage.prefix**).
