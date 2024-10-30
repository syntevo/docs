---
redirect_from:
  - /SmartGit/Latest/Repository-Settings
  - /SmartGit/Latest/Repository-Settings.html
---

# Repository Settings

After selecting a Repository, you can use the **Repository \| Settings** menu command or the Settings context menu on the highlighted repository. This opens a dialog to configure certain options of your repository (`<repository>/.git/config`) file.

**Note:**

- Changes made to a repository's configuration only affects the selected repository. You can set option defaults globally by using **Edit \| Preferences \| Git Config** [settings](../Preferences/Commands.md#git-config). This will become the configuration default for **all** repositories, although you can still override settings on individual repositories through **Repository \| Settings** on that repository.
- You can also edit the Git configuration directly by manualy updating your `.gitconfig` file, although you will lose the validation safety net that SmartGit provides.

## User Tab

Use this tab to configure your name and email address - this information will be used to identify the commit author when [committing](../Local-Operations-on-the-Working-Tree.md#commit) to this repository.

## Fetch and Pull Tab

These settings allow you to configure options related to the [Pull command](../Synchronizing-with-Remote-Repositories.md#pull):

- Whether to **Merge** from, or **Rebase** the local branch commits ahead onto the fetched changes, when pulling updates from a tracked remote branch.
- Whether to delete (prune) obsolete remote branches
- How to treat Submodule synchronization when pulling:
    - Always fetch new commits, tags, and branches from the submodule's remote
    - Update registered submodules
    - Initialize new submodules which have been added to the tracked remote branch

## Push Tab

This configuration allows you to choose what happens when you attempt to push, and a referenced submodule which has changes (only applicable to repositories containing submodules).

- **Abort if changes to submodules** - Your push operation will abort, and you will need to resolve the submodule synchronization, e.g. by explicitly pushing changes to submodules before pushing changes in the current (dependent) repository.
- **Ignore submodules** - Will only push changes in the current repository. Submodule changes will NOT be pushed to the remote.
- **Push submodules first** - SmartGit will automatically attempt to push changes to Submodules,before pushing changes to your current repository.

**Note**: If your changes depend on the changes you've made to your local submodule repository, and you choose Ignore submodule changes, other users may not be able to compile your changes.

## Signing Tab

This allows you to configure the GPG program and your private signing key to Sign Tags and Commits, to prove author identify.

Please refer to [Signing](../../HowTos/Sign-Tags-and-Commits.md) for further information.

**Note**
> You need to ensure the specified GPG program is configured to use an agent that can ask you for your key's passphrase using a GUI.
>
> Otherwise you may get a gpg error "cannot open tty \`/dev/tty': Device not configured".

## Encoding Tab

Here you can also configure the text encoding SmartGit should assume when viewing text files in the **Changes** view or **Compare** window, or when editing files, e.g. with the Compare, Index Editor or Conflict Solver.

SmartGit will automatically detect UTF-8 encoding, with or without leading byte order markers (BOM).

- UTF-8 with BOM, UTF-16 with Byte Order Markers (BOMs) are detected automatically.
- Files with UTF-8 and without BOMs are usually automatically detected from the content, so you don't usually need to explicitly add BOMs to UTF-8 encoded files.

Unless you have a specific reason for changing the encoding settings, it is recommended that the default UTF-8 encoding be used.

## Tag-Grouping

This tab provides advanced configuration options how SmartGit will group tags, branches, or other `refs` that match this configuration.

Tag grouping:

- Allows a more compact display of a range of tags in the Log **Graph**.
- Introduces additional "group"-nodes in the **Branches** view.
- Adds **Closest Tags** category to the **Commit** view.

For details on how tag-grouping patterns are specified, hover over the blue ![](../../images/icons/emoticons/information.png) markers.

# Other Options

SmartGit supports other options either in `<repository>/.git/config` or `~/.gitconfig`:

- `smartgit.gui.prefixAddBranch`: this value defines the default prefix in the **Branch \| Add Branch** dialog
- `smartgit.gui.prefixStartFeature`: this value defines the default prefix in the **Branch \| Git-Flow \| Start Feature** dialog
