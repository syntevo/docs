# GitHub integration

SmartGit integrates GitHub workflows in various places, provided that the connection to *github.com* or a custom *GitHub Enterprise instance* has been configured in the Preferences.

### Setup

To set up the GitHub integration, go to **Preferences**, section **Hosting Providers** and click the **Add** button.
In the **Add Hosting Provider** dialog, have **GitHub** selected and invoke **Generate API token**.
This should open up your default web browser where you will have to confirm by **Authorize Application**.
Be sure to also **Grant Access** to all of your organizations, otherwise the corresponding organization repositories won't show up/can't be accessed.

![](attachments/53215440/53215447.png)

Once you have confirmed this page, you will be redirected to a specific port on `127.0.0.1`, where SmartGit is waiting to intercept a one-time authorization code.
The code will be used to create an *application access token* which will be used to populate the **Token** field.

#### Note
> If this redirection does not work, this may be caused by your browser's HSTS configuration.
> To resolve this problem, remove any entries for `127.0.0.1` and try again.
> For more details on how to do that for various browser, refer to [this blog posting](https://weblog.west-wind.com/posts/2022/Oct/24/Fix-automatic-rerouting-of-http-to-https-on-localhost-in-Web-Browsers).

By default, **Use OAuth token for repository authentication** will be selected.
This will return the generated OAuth-token when Git asks for credentials (username + password) when connecting to your GitHub repository.
Using the OAuth-token has following advantages:

- its scope is more limited than plain password or possibly more powerful personal access tokens
- it will not require to create/enter a second set of credentials to SmartGit

Finally, confirm the **Add Hosting Provider** dialog using **Add**.

#### Info
> Once you have authorized SmartGit, it will show up in your GitHub **Settings**, section **Authorized Applications**.
> If you need to rerun through the Authorization process outlined above, you have to **Revoke** access there first and start over.
> ![](attachments/53215440/53215443.png)

#### Personal Access Tokens

Instead of an OAuth token, you may alternatively use a personal access token which has to be created manually in your [GitHub Developer Settings](https://github.com/settings/tokens).
When experimenting with tokens, try first with a *Classic Token*.
Make sure that your personal access token has at least following scopes assigned:
**repo**, **read:org**, **read:user**, **gist**, **workflow**

## Clone

When [cloning](Clone.md) a repository, you can select your repository from a list, instead of entering the URL.
SmartGit will display your own (*user*) repositories, as well as repositories of your *organization* (*org*).

![](images/github-clone.png)

## Working Tree window

The Working tree window contains a light-weight GitHub integration which just indicates incoming pull requests in the title of the **Branches** view.

#### Note
> Detailed pull request information and operations on pull requests are only available in the **Log** (see below).

## Log

In the *Log* window of your repository, you can interact with GitHub in following ways.

### Pull Requests

When initially loading the Log, SmartGit will also refresh information on related *Pull Requests* from the GitHub server:

-   **Incoming** pull requests are those which other users are requesting to pull from their repositories.
    They are displayed in a separate category called **Pull Requests** in the **Branches** view.
-   **Outgoing** pull requests are those which you have sent to other users/repositories, requesting them to pull your changes.
    They are display directly below the local (or if it does not exist), the remote branch in the **Branches** view.

*Incoming* pull requests, in first place, are just present on the server.
SmartGit learns about them only by calling a GitHub REST API and displays the retrieved information in the **Branches**.
To work with these pull requests (e.g. to review their commits, or **Merge** or **Reject** them), you first have to fetch them by invoking **Fetch** from the context menu of the pull request.
This will fetch all commits from the remote repository to a special branch in your local repository and will create an additional, virtual *merge* commit between the *base* commit from which the pull request has been forked and the latest (remote) pull request commit.

When selecting this *merge* node in the **Commits** view, you can see the entire changes which a multi-commit pull request includes and you can [comment](#comments) on these changes, if necessary.
After commenting changes, it's probably a good idea to **Reject** the pull request to signal the initiator of the pull request, that modifications are required before you are willing to pull his changes.
If you are fine with a pull request, you may **Merge** it.
This will request the GitHub server to merge the pull request and then SmartGit will pull the corresponding branch, so you will have the merged changes locally available.

*Outgoing* pull requests can be **Fetch**ed as well, however this is usually not necessary, as the pull request belongs to you and it contains your own commits.
If you decide that you want to take a pull request back, use **Reject**.

For a pull request which had been fetched once, there was a special *ref* created which will make it show up in the **Pull Requests** category, even if it is not present on the server anymore.
In this case, you may use **Drop Local** on such a pull request to get rid of the corresponding ref, the local merge commit, all other commits of the pull request and the entry in **Pull Requests** as well.
It's safe to use **Drop Local**, as it will only affect the local repository and you can re-fetch a pull request anytime you like using **Fetch** again.

You can invoke **Review\|Sync** to manually update the displayed information.
Usually you will want to do that, if you know that server-side information has changed since the Log has been opened.

To create a pull request, use **Create Pull Request** from the context menu of the **Branches** view.

### Comments

GitHub allows to comment on a commit itself or individual line changes (*diffs*).
Comments can be applied to a commit or to a Pull Request.
Pull Request Comments will be refreshed together with those pull requests which are locally available (see **Fetch Pull Request** above).
Plain Commit Comments will by default not be refreshed for performance reasons.
To tell SmartGit to fetch plain commit comments, too, configure `github.commitCommentPageLimit` in the **Preferences, Low-Level Properties**.

Both, Pull Request and Plain Commit Comments, can refer either to a commit itself or to a specific line in a file:

-   Commit comments will show up in the **Commits** view.
-   Comments on individual lines will show up in the **Changes** view and the affected files will be highlighted in the **Files** and **Commits** view, too.
    This works the same way for line-comments of Pull Requests, provided that the pull request has been **Fetch**ed and the local pull request *merge* commit has been selected.

Comments can be created, modified and removed using the corresponding actions from the **Comments** menu or context menu actions in the **Commits** and **Changes** view.
If a pull request *merge* commit is selected, only line-comments of the pull request can be manipulated.

More behavior of the GitHub integration can be customized by [Low-Level Properties](Preferences.md).

### Re-setup OAuth

Sometimes you may need to rerun the *OAuth* setup, e.g. if a more recent version of SmartGit will request additional scopes.
Usually, it's sufficient to just open **Preferences**, section **Authentication**, open the **GitHub** hosting provider and invoke **Generate API token** there.
If this does not solve your problem, take following steps to rerun the *OAuth* setup from scratch:

1.  In SmartGit:
    1.  get rid of all GitHub-related credentials from **Preferences**, section **Authentication**
    2.  get rid of the GitHub hosting provider from **Preferences**, section **Hosting Providers**
2.  In GitHub, open the [SmartGit application](https://github.com/settings/connections/applications/99bbba5634b1f1ef3b57) from your profile **Settings**, **Applications**, tab **Authorized OAuth Apps**:
    1.  Select "SmartGit" there:
        ![](attachments/53215440/53215441.png)
    2.  Invoke **Revoke Access**
3.  In SmartGit, rerun through the *OAuth* setup again:
    1.  open **Preferences**, section **Hosting Providers**
    2.  **Add** a new **GitHub** hosting provider, as described above

## Possible Problems & Solutions

### Authenticating with two or more accounts

#### Info
> SmartGit currently does not support having two **Hosting Providers** configured for "github.com", hence for the extended integration discussed above, you have to decide for one of your accounts.
> It's however possible to access repositories of multiple GitHub accounts, as explained below.

If you want to authenticate to your GitHub repositories, using two or more accounts, open **Preferences**, section **Hosting Providers**, open the GitHub hosting provider there and deselect **Use OAuth token for repository authentication**.
When pulling/pushing a GitHub repository for the next time, SmartGit will ask you for **Username** and **Password**.
For the **Username**, just enter the appropriate GitHub account name, for the **Password** it's recommended to generate a new *Personal Access Token* in your GitHub account settings (the **repo** scope needs to be selected).

Depending on your Git configuration, Git might request credentials only *per-domain* instead of *per-repository*.
If so, try to reconfigure:

```
git config --global credential.github.com.useHttpPath true
```

### Private repositories do not show up/403 when trying to access an organization repository

If you are authenticating using *OAuth* and you can't see private repositories of your GitHub *organization* or pushing to your organization's repositories fails with HTTP error code *403*, make sure that your organization allows **Third-party access** and SmartGit is **Approved**.
Your organization settings might look like this:

![](attachments/53215440/53215446.png)

Note that the screenshot above shows the interface of the organization's manager.
If you are not the manager, but just a member of the organization, you can request access for the [SmartGit application](https://github.com/settings/connections/applications/d9f33087e985e76e9029) to this organization from your **Settings - Applications**, tab **Authorized OAuth Apps**:
select **SmartGit** here and check for which organizations you may request access.
The screenshot below shows `syntdev2` for which access can be requested.
Once done so, the organization manager will receive a notification and may confirm.

![](attachments/53215440/53215442.png)

#### Note
> If your GitHub hosting provider is already set up in the Preferences and you need to rerun through the *OAuth* setup, [as explained above](#re-setup-oauth).

### Git-Flow Pull Requests will be closed on Finish Feature

When using [Git-Flow](Git-Flow.md) or [Git-Flow Light](Git-Flow-Light.md) in combination with pull requests, pull requests may be marked as **Closed** instead of **Merged** after invoking **Finish Feature**.
This happens when you have **Delete Feature Branch** selected for the **Finish Feature** dialog: with this option selected, the local and remote feature branch will be deleted immediately, however the resulting merge/rebase has not yet been pushed.
If a branch will be deleted *before* it has been merged, GitHub will mark the pull request as **Closed**.
If it's only deleted *after* the branch has been merged, it will be marked as **Merged**.
If you don't want your pull requests to become **Closed**, unselect **Delete Feature Branch**, push the resulting merge/rebase first and only then **Delete** the feature branch from GitHub (e.g. from the **Branches** view).

### Push fails with OAuth 'scope'-related warning

From time to time, GitHub may introduce new or change existing *OAuth permission scopes*.
In this case, SmartGit's OAuth token may stop working.
The solution is usually to rerun through the *OAuth* setup, [as explained above](#re-setup-oauth).

#### Note
> Be sure to always try with the [latest SmartGit release](https://www.syntevo.com/smartgit/download/) because we are regularly adjusting required *scopes* for the latest version.
> If you suspect that not even the latest version is requesting the scopes which are required for your scenario, you may manually change the *scopes* in the **Preferences**, **Low-Level Properties**, property "github.oauth.scopes".

Typical Git error messages hinting to this kind of problem:

```
! refs/heads/some-branch:refs/heads/some-branch [remote rejected]
(refusing to allow an OAuth App to create or update workflow
`.github/workflows/some-workflow.yml` without `workflow` scope)
```

### Distributed Reviews interference

When using GitHub, be sure to have [Distributed Reviews](Distributed-Reviews-add-on-.md) disabled for your repository, otherwise there may be confusion about GitHub vs. Distributed Reviews pull requests. To be sure to have Distributed Reviews disabled, invoke **Review\|Configure**:

- if SmartGit asks you whether to initialize the Review database, Distributed Reviews are not enabled (as it should be). Select **Cancel** to keep it disabled.
- if SmartGit asks you what to configure, Distributed Reviews are enabled.
  Select **Dispose Database** to disable it.

