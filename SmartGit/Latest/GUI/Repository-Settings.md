# Repository \| Settings

Use this dialog to configure certain options of your repository (`<repository>/.git/config`).
The same global options can be found in the preferences.

## User

Configure your name and email address to identify who created the commits.

## Pull

With these settings you can configure whether to delete obsolete remote branches or how to handle submodules when pulling.

## Push

Configure what should happen with submodules if you push a submodule change.

## Signing

Configure the GPG program and your signing key to Sign Tags and Commits.
See [Signing](../HowTos/Sign-Tags-and-Commits.md).

#### Info
> You need to ensure the specified GPG program is configured to use an agent that can ask you for your key's passphrase using a GUI.
> 
> Otherwise you may get a gpg error "cannot open tty \`/dev/tty': Device not configured".

## Encoding

Here you can also configure the text encoding SmartGit should assume when viewing or editing text files, e.g. with the Compare, Index Editor or Conflict Solver.

UTF-8 with BOM, UTF-16 with BOM are detected automatically.
Files with UTF-8 and without BOM are likely to be automatically detected from the content.

## Tag-Grouping

Tag-Grouping specifies how tags (or more general: refs) will be grouped together.
This grouping:

-   allows a more compact display of a range of tags in the Log **Graph**
-   introduces additional "group"-nodes in the **Branches** view
-   adds **Closest Tags** category to the **Commit** view

For details on how tag-grouping patterns are specified, however over the blue ![](images/icons/emoticons/information.png) markers.

# Other Options

SmartGit supports other options either in `<repository>/.git/config` or `~/.gitconfig`:

- `smartgit.gui.prefixAddBranch`: this value defines the default prefix in the **Branch \| Add Branch** dialog
- `smartgit.gui.prefixStartFeature`: this value defines the default prefix in the **Branch \| Git-Flow \| Start Feature** dialog
