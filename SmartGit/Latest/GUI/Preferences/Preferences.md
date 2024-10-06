---
redirect_from:
  - /SmartGit/Latest/Preferences
  - /SmartGit/Latest/Preferences.html
---
# Preferences

The preferences dialog in SmartGit (**Edit \| Preferences**) allows you to customize SmartGit to suit your workflow and personal preferences. 
This will open a dialog where you can adjust settings such as user-interface options, additional tools, proxy settings and keyboard shortcuts. 

> [!NOTE]
> Some highlighted options require an application restart to be applied.

**Tip:** Use the ‘Search’ function to change the theme of SmartGit e.g., type in "Theme" to take you to the directly to the available theme settings under [User Interface](User-Interface.md). The 'Theme' setting will be highlighted.

**TODO** Image of the Search and feature highlight.

## Commands

The [Commands](Commands.md) section allows configuration of common Git, and SmartGit behavior, including:

- [Common Git command options](Commands.md#main-tab)
- [Standard Window preferences](Commands.md#standard-window)
- [Log and Working Tree Window Preferences](Commands.md#log-and-working-tree-window)
- [Git Executable preferences](Commands.md#git-executable)
- [Git Config file editor](Commands.md#git-config)
- [Authentication options](Commands.md#authentication)

## User Interface Preferences

The `User Interface` preferences allow customization of the appearance of SmartGit.
Please refer to [User Interface Preferences](<User Interface.md>) for further details.

## Tools

SmartGit supports a wide number of external tool configurations which can be hooked into SmartGit. Please refer to [Tools Preferences](Tools.md) for more details.

## Proxy

On this page you can configure the proxy to be used by SmartGit.
The proxy will be used exactly as configured for the check for new versions.
It will also be used for Git HTTP and HTTPs under certain conditions:

-   **Use following proxy** has been selected and
-   there is no `http.proxy` and no `https.proxy` configuration found in your `.gitconfig` and Git's system `config` and
-   the neither of following system environment variables is set: `HTTP_PROXY`, `HTTPS_PROXY`, `NO_PROXY`

## Privacy

When **Contact gravatar.com to show images for the users** is selected, a hash of the email address is generated and then gravatar.com is contacted to request the belonging graphic which the user first has to configure there.
