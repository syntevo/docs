# Bitbucket Server (Atlassian Stash) Integration

SmartGit integrates Bitbucket Server (Atlassian Stash) workflows in several places, very similar to the [GitHub](GitHub-integration.md) integration.

## Setup

To set up the Bitbucket Server integration, first create a *personal access token* in Bitbucket Server.
Go to **Manage Account** \| **Personal access tokens** \| **Create a token**.
For the **Token name**, use something like "SmartGit" here and for **Permissions**, select **Write** access.

![Create a personal access token in Bitbucket Server](../attachments/53215454/53215455.png)

After invoking **Create**, copy the token to the clipboard and also consider to store it in some safe place (like a password manager), because you won't be able to access this token again from the Bitbucket UI.

In SmartGit, go to **Preferences** -> **Hosting Providers** -> **Add**.
In the **Add Hosting Provider** dialog, have **Bitbucket Server** selected:

- for **Account** use your Bitbucket Server account name
- for **Password** use the generated access token
- for **Server URL** enter the same top-level **URL** which you are using in your browser to access Bitbucket

> [!NOTE]
> Unless your server is using 2-way-SSL, you don't need to provide **Client Certificate** and **Client Password**.
> Authentication using *SSH* is unrelated to this configuration.
