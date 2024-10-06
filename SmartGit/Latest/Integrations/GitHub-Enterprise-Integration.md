# GitHub Enterprise Integration

Authenticating to a GitHub Enterprise instance is slightly different
than to *github.com* due to the nature of *OAuth*. Basically you have
to use **Personal Access Tokens** there. This approach can be performed by
an individual user without needing administrative rights for the
GitHub Enterprise instance.

# Personal Access Token

Personal access tokens are working for GitHub Enterprise as well as
for *github.com*. To create a personal access token, go to
your **Account** settings and select **Personal Access Tokens**.
Invoke **Generate New Token**, enter `SmartGit` for the **Token
Description** and for **Select scopes** select the `repo` scope and
the `read:org` scope.

![](attachments/53215448/53215449.png)

 

After confirming with **Generate Token**, you will see the new token in
your list of tokens. Copy the token to the clipboard and paste it into
the **Token** field of SmartGit's **GitHub** configuration dialog.
