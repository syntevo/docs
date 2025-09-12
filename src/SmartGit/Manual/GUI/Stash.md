# Stashing

Stashes are a convenient way to temporarily store the current *Working Tree* changes (either all changes, or just selected changes) aside, and then re-apply them later.
For example, stashes are useful if you realize that you have started making changes to files in the *Working Tree* without first checking out the correct branch.

## Creating a Stash

Use **Local \| Stash All** to stash away all local modifications of your *Working Tree*, and provide a brief message to describe the stash.
To stash away only the selected files, use **Local \| Stash Selection**.
The resulting stash will show up in the **Branches View**.

By default, after the stash operation, SmartGit will clear the *Index* and *Working Tree* (allowing checkout of another branch).
However, SmartGit offers the option of retaining changes to the *Index* and *Working Tree* if required.

#### Note

> The option **Include untracked files** (Preferences, page **Commands**) is convenient to include *untracked* files for the stash as well.
> Depending on the operating system it may take significantly longer to execute the operation.

## Applying a Stash

To apply a stash to the current state of the *Working Tree*, right-click the stash and select **Apply Stash** to re-apply the contained changes to your *Working Tree* (e.g. after switching branches).

## Other Stash Commands

The following commands can be executed by right-clicking on a Stash (under **Stashes** in the **Branch View**):
- To get rid of obsolete stashes, use **Drop Stash**; however, be aware that this will irretrievably delete any changes which are stored in the stash.
- The **Rename Stash** command allows you to change the displayed stash message.
- **Compare with HEAD** / **Compare with Selected Commit** allows you to compare the contents of the stash against the HEAD / selected commit, respectively.
- **Copy Message** copies the stash message of the selected Stash into the OS clipboard.
