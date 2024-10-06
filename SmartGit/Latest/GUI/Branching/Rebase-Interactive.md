---
redirect_from:
  - /SmartGit/Latest/Rebase-Interactive
  - /SmartGit/Latest/Rebase-Interactive.html
---
# Interactive Rebasing in SmartGit

As the name suggests, Interactive Rebasing (`git rebase -i`) allows fine-level control over what should happen with each commit.

SmartGit provides comprehensive tools to keep your repository's history clean and structured.

SmartGit packages the interactive rebase functionality of Git in simple yet powerful ways through its user interface, accessible from 
both the [Log Graph](../Log.md) and the [Journal View](../Journal-View.md).

**Note:**
During many rebasing operations, your Working Directory will be left in a `Rebasing` state, allowing for manual user operations.
Once finished, you will need to commit and *complete* the rebase operation, or *abort* the rebase.
Please refer to [Working Tree States](/SmartGit/Latest/GitConcepts/Working-Tree-States.md). for further information.

## Quick rearranging and squashing

You can invoke various operations from the context menu depending on the type of commit(s) selected. Most notably, you can efficiently rewrite history:

- **Squashing adjacent commits:** Select the commits you want to squash, invoke the **"Squash..."** option, and provide an updated commit message.
- **Reordering commits:** Drag a commit to the desired position and select the **"Move Commit"** option.
- **Coalescing two commits:** To combine two commits (not necessarily adjacent), drag one onto the other and provide a consolidated *commit message*.
- **Editing the commit message:** Select the commit and invoke the **"Edit Message"** option.
- **Changing the author:** Select the commit and invoke the **"Edit Author"** option.

### Modify

To modify (or amend) a commit, select the commit and invoke **Modify** from the context menu.
This will start an interactive rebase and stop after the selected commit.
Perform the required modification to the files your Working Directory and then **Commit** (optionally using **Amend**).
Finally, click **Step** (in the banner) to advance to the next commit, which can also be modified.
Or click **Continue** (in the banner) to let the rebase run through completely.
To abort the modification and revert to the previous state, click **Abort**.

### Split

Select a commit and invoke **"Split"** from the context menu to split it.
This starts an interactive rebase and pause with the commit's changes in the Index.
**Unstage** or **Discard** changes that you don't want in the first commit, and click **Continue** (in the banner).
After creating the first commit, continue staging changes for the second commit and click **"Continue"** again. 
Once all changes have been committed, click **Continue** one final time to complete the rebase.

SmartGit will warn you if the new commits do not contain all changes of the old commit.
You may continue or let SmartGit place the missing changes into the Index.

## Using the interactive rebase editor

As mentioned above, you can perform various operations immediately, (e.g., reordering commits by drag and drop).
However, if you need to make multiple changes simultaneously, use the Interactive Rebase feature.

Select the first commit that should be changed to start the interactive rebase and invoke **"Rebase Interactive From"** from the context menu.

In the *Interactive Rebase* dialog, you can squash commits, reorder them using drag and drop, or edit commit messages.  These operations will only be executed after clicking the **Rebase** button.

In case of conflicts, the rebase operation will pause (just as it would in a normal rebase).
After resolving the conflicts, click the **Continue** banner button.
To abort the interactive rebase and return to the previous state, click **Abort**.

Commits with the same commit message are highlighted, making it easier to see related commits.
They can be amend-squashed using drag and drop.
Alternatively, the "Auto-Squash" button offers the following options:

- **To Top Commit:** Moves equally named commits to the last commit and squashes them.
- **Neighboring Commits:** Squashes equally named, adjacent commits.
- **To Bottom Commit:** Moves equally named commits to the first commit and squashes them.

### Interactive Rebasing Tips
- You can use the low-level configuration property **log.useCommitMessage.prefix** to specify a prefix that is used on commit messages.
  For example, if you set the commit message prefix to "`fixup! `", when using **Commit Message** (from the Log's or Journal's context menu), SmartGit will prefix the commit message with "`fixup! `". The Interactive Rebase process will then treat `foo` and `fixup! foo` as equally named commits.
- The low-level configuration property **git.rebaseInteractive.autoSquash** controls whether Interactive Rebasing will automatically squash adjacent commits whenever subsequent commits have a "`fixup! *msg*`" message, where `*msg*` matches the previous commit's message (independent of the low-level property **log.useCommitMessage.prefix**).

