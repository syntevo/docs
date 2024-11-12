# Bitbucket integration

SmartGit integrates Bitbucket workflows in various places, very similar
to the
[GitHub](GitHub-integration.md)
integration. Some behavior can be customized by [system properties](System-Properties.md#SystemProperties-properties.bitbucket).

### Setup

To set up the Bitbucket integration, go to **Preferences**, section
**Hosting Providers** and use **Add** there. In the **Add Hosting
Provider** dialog, have **Bitbucket** selected and invoke **Generate API
token**. This should open up your default web browser where you will
have to confirm by **Grant**.

![](attachments/bitbucket-oauth-grant.png)

Once you have confirmed this page, you will be redirected to a specific port on `localhost`, where SmartGit is waiting to intercept a one-time authorization code.
The code will be used to
create an *application access token* which will be used to populate the
**Token** field. Finally, confirm the **Add Hosting Provider** dialog
using **Add**.

Once you have authorized SmartGit, it will show up in your GitHub
**Settings**, section **OAuth**. If you need to rerun through the
Authorization process outlined above, you have to **Revoke** access
there first and start over.

![](attachments/bitbucket-oauth-overview.png)

### Setup using App Password (only basic repository access)

If you are only interested in accessing your Bitbucket repositories but don't care about the enhanced integration, including pull requests, you may connect to Bitbucket using [App Passwords](https://support.atlassian.com/bitbucket-cloud/docs/app-passwords/).

For the App Password, only **Repositories** **Read** and **Write** access will be required.

![](attachments/bitbucket-app-password.png)

Once you have created the App Password, just use it as **Password** when SmartGit asks you for credentials (e.g. on Pull or Push). 


## Possible Problems & Solutions

### Authenticating with two or more accounts

If you want to authenticate to your Bitbucket repositories, using two or
more accounts, open **Preferences**, section **Hosting Providers**, open
the Bitbucket hosting provider there and deselect **Use OAuth token for
repository authentication**. When pulling/pushing a Bitbucket repository
for the next time, SmartGit will ask you for **Username** and
**Password**. For the **Username**, just enter the appropriate Bitbucket
account name, for the **Password** it's recommended to generate a new
*App password* in your Bitbucket account settings.

Depending on your Git configuration, Git might request credentials only
*per-domain* instead of *per-repository*. If so, try to reconfigure:



``` java
git config --global credential.useHttpPath true
```



Or even more selectively:



``` java
git config --global credential.bitbucket.com.useHttpPath true
```




