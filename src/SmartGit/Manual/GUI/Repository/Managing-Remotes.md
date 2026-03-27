# Managing Remotes

Frequently, developers may [Clone](Clone.md) a remote repository, and will always pull or push new commits and branches in your local repository only to this remote (with a default name of *origin*).

However, there are times when you will need to perform more advanced interactions with remotes, e.g.:

- If the location of the remote repository changes
- If you wish your local repository to track multiple remote repositories
- If you wish to change the protocol, e.g. between SSH and HTTPS
- If you wish to remove references to a remote repository

The following commands are available from the **Remote** menu:

- **Add** allows you to add another tracked remote for your local repository.
- **Rename** allows you to change the local name of an existing remote.
- **Delete** removes the selected remote from the local repository configuration.
- **Properties** lets you edit the URL and related settings for an existing remote.
- **Fetch More** lets you fetch additional remote branches which are not yet available locally.
- **Set Depth** deepens a shallow remote fetch configuration.

The **Rename** and **Delete** remote commands are also available from the **Branches** view of the **Log Window** or **Standard Window**.

## Adding a remote

Use **Remote \| Add** to open the **Add Remote Repository** dialog.

Specify:

- **URL or Path** for the remote repository.
- **Name** for the local remote entry.
- **Verify repository connection** if SmartGit should test the entered location before adding it.

The **URL or Path** field also offers a popup to select a local repository or a repository from a configured hosting provider.
This is useful when you do not want to type the URL manually.

If you have cloned a fork of a GitHub repository (for simple remote setups) SmartGit will detect the original repository and suggests to add at as `upstream` repository.

## Editing remote properties

Use **Remote \| Properties** to adjust an existing remote.

The dialog always shows the main **URL or Path**.
Depending on the remote configuration, it may also show **Push URL**.
Use **Push URL** if fetches and pushes should go to different locations.

Some remotes also offer **Perform background Poll or Fetch**.
Use this when you want SmartGit's background Poll or Fetch behavior for this remote to be enabled or disabled explicitly.

## Fetching additional refs

Use **Remote \| Fetch More** if a remote contains branches which are not yet available in the local repository.
This command is especially relevant after a narrow clone where **Fetch all Heads and Tags** had been disabled.

For a shallow repository, the dialog can also offer **Fetch all commits for existing branches ("unshallow")**.
Otherwise, select one or more additional branches to fetch.

## Changing shallow depth

Use **Remote \| Set Depth** to fetch a specific depth for the selected remote.
Enter the desired **Depth** in commits.
A very large value effectively removes the practical depth limit.

## Selecting a remote

When SmartGit cannot infer the intended remote, it shows a small selector dialog with a **Remote** field.
This is only a chooser.
It does not change repository configuration by itself.
