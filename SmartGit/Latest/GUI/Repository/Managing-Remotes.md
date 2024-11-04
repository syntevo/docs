---
redirect_from:
  - /SmartGit/Latest/Managing-Remotes
  - /SmartGit/Latest/Managing-Remotes.html
---

# Managing Remotes

Frequently, developers may [Clone](Clone.md) a remote repository, and will always pull or push new commits and branches in your local repository only to this remote (with a default name of *origin*).

However, there are times when you will need to perform more advanced interactions with remotes, e.g.:

- If the location of the remote repository changes
- If you wish your local repository to track multiple remote repositories
- If you wish to change the protocol, e.g. between SSH and HTTPS
- If you wish to remove references to a remote repository

The follow commands are available from the **Remote** menu:

- **Add** - This allows you to add another tracked remote for your local repository. Provide a URL (SSH or HTTPS), Path (if the remote is on a file system), and a friendly Name by which to refer to the remote.
    - The **Verify repository connection** checkbox will validate that the remote exists, if selected.
- **Rename** allows you to change the Name given to the remote (e.g. you can rename *origin* to *myhost*). This only affects your environment, other users of the remote repository will be unaffected.
- **Delete** removes the local repository tracking to the selected remote. Again, other users of the remote will be unaffected. You can re-establish tracking to a remote by using the **Add Remote** command, above.

The **Rename** and **Delete** remote commands are also available off the **Branches** view of the Log Window or Standard Window.
