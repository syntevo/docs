# Bitbucket integration

Once Bitbucket integration is configured, the following integrated functionality is available from within SmartGit:

- [Integrated Cloning](Integrated-Cloning.md)
- [Integrated Pull Requests](Integrated-PullRequests.md)
- [Integrated Commenting](Integrated-Comments.md)

Some integration behavior can be customized by [low-level properties](../GUI/AdvancedSettings/Low-Level-Properties.md#systemproperties-properties.bitbucket).

### Setup

To set up the Bitbucket integration, go to **Preferences**, section **Hosting Providers** and select *Bitbucket* from the **Add** dropdown.

In the **Add Hosting Provider** dialog, click on the *Generate Token* button.

SmartGit should open your default web browser and navigate to Bitbucket, where you will have to confirm access by selecting **Grant**.

![Bitbucket access request](../attachments/bitbucket-oauth-grant.png)

Once confirmed, you will be redirected to a specific port on `localhost`, where SmartGit is waiting to intercept a one-time authorization code. 

The code will be used to create an *application access token* which will be used to populate the **Token** field. 

Finally, confirm the **Add Hosting Provider** dialog by clicking **Add**.

Once you have authorized SmartGit, it will show up in your Bitbucket **Settings**, under section **App Authorizations**.

![Bitbucket App Authorizations](../attachments/bitbucket-oauth-overview.png)

#### Note
> If you need to rerun through the Authorization process outlined above, you have to **Revoke** access to the SmartGit application and start over.

### Setup using App Password (only basic repository access)

If you are only interested in accessing your Bitbucket repositories but don't require enhanced integration, including pull requests, you may connect to Bitbucket using [App Passwords](https://support.atlassian.com/bitbucket-cloud/docs/app-passwords/).

For the App Password, only **Repositories** **Read** and **Write** access will be required.

![](../attachments/bitbucket-app-password.png)

Once you have created the App Password, just use it as **Password** when SmartGit asks you for credentials (e.g. on Pull or Push).

## Possible Problems & Solutions

### Authenticating with two or more accounts

If you want to authenticate to your Bitbucket repositories, using two or more accounts, open **Preferences**, section **Hosting Providers**, open the Bitbucket hosting provider there and deselect **Use OAuth token for repository authentication**. The next time that you pull from, or push to a Bitbucket repository, SmartGit will ask you for **Username** and **Password**. For the **Username**, just enter the appropriate Bitbucket account name, for the **Password** it is recommended to generate a new *App password* in your Bitbucket account settings.

Depending on your Git configuration, Git might request credentials only *per-domain* instead of *per-repository*.

If so, try to reconfigure:

``` bash
git config --global credential.useHttpPath true
```

Or even more selectively:

``` bash
git config --global credential.bitbucket.com.useHttpPath true
```


