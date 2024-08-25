# GitLab

SmartGit integrates GitLab workflows in various places, very similar to
the [GitHub](GitHub-integration.md)
integration. Some behavior can be customized by [low-level properties](System-Properties.md).

### Setup

To set up the GitLab integration, go to **Preferences**, section
**Hosting Providers** and use **Add** there. In the **Add Hosting
Provider** dialog, have **GitLab** selected and invoke **Generate API
token**. This should open up your default web browser where you will
have to confirm by **Authorize.**

**![](attachments/53215471/53215474.png)**

Once you have confirmed this page, you will be redirected to a specific port on `localhost`, where SmartGit is waiting to intercept a one-time authorization code.
The code will be used to
create an *application access token* which will be used to populate the
**Token** field. Finally, confirm the **Add Hosting Provider** dialog
using **Add**.

#### Info
> Once you have authorized SmartGit, it will show up in your GitLab
> **Settings**, section **Applications**. If you need to rerun through the
> Authorization process outlined above, you have to **Revoke** access
> there first and start over.
> 
> ![](attachments/53215471/53215472.png)

#### Personal Access Tokens

Instead of an OAuth token, you may alternatively use a personal access token which has to be created manually in your [GitLab User Settings](https://gitlab.com/-/profile/personal_access_tokens).
Make sure that your personal access token has at least following scopes assigned:
**api**, **read_user**, **write_repository**.

## Possible Problems & Solutions

### Authenticating with two or more accounts

#### Info
> SmartGit currently does not support having two **Hosting Providers**
> configured for "gitlab.com", hence for the extended integration
> you have to decide for one of your accounts. It's
> however possible to access repositories of multiple GitLab accounts, as
> explained below.

If you want to authenticate to your GitLab repositories, using two or
more accounts, open **Preferences**, section **Hosting Providers**, open
the GitLab hosting provider there and deselect **Use OAuth token for
repository authentication**. When pulling/pushing a GitLab repository
for the next time, SmartGit will ask you for **Username** and
**Password**. For the **Username**, just enter the appropriate GitLab
account name, for the **Password** it's recommended to generate a new
*Personal Access Token* in your GitLab account settings (see above).

Depending on your Git configuration, Git might request credentials only
*per-domain* instead of *per-repository*. If so, try to reconfigure:

``` java
git config --global credential.gitlab.com.useHttpPath true
```

