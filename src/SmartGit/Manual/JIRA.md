# JIRA

The JIRA integration allows to select a commit message (including JIRA
key) directly from (open) JIRA issues and to optionally mark issues as
resolved on **Push**.

## Prerequisites

The JIRA integration is only available for **commercial** licenses and
will only be present, if the [Bugtraq configuration](Bugtraq-links-to-issue-trackers-.md) has been set up
properly for your JIRA server.


#### Note
> When connecting to a cloud-based JIRA instance (\*.atlassian.net), you
> have to login with your **username**, not your email address. You can
> find your username in your **Profile** (top-right corner).



## Authentication with API

Depending on the JIRA version and/or server vs. cloud instance, it may
be fine to authenticate to JIRA using your username/password or it may
be necessary to create an API token.

To create an API token, open your JIRA account and select **Security**
settings there.


#### Info
> For the cloud instance, you can find security settings at:
> <https://id.atlassian.com/manage-profile/security>



In the **API token** section, select **Create and manage API tokens**,
then select **Create API token**, label it e.g. "SmartGit" and finally
confirm with **Create**.

![](attachments/53215463/53215465.png)

In the next dialog, invoke **Copy to clipboard**. Finally, the token
should show up in the list.

![](attachments/53215463/53215466.png)

You should now be able to authenticate to JIRA from within SmartGit by
using your email address as **User Name** and the token as **Password**.

![](attachments/53215463/53215464.png)

## Commit Message Selection

The commit message selection is available in the Commit and Edit Last
Commit Message commands as well in some interactive rebase commands of
the **Journal** view.

![](attachments/53215463/53215467.png)

## Resolving on Push

For all **Push** operations (except of **Push To**), SmartGit checks the
pushed commits for *affected* JIRA issues and offers to mark them as
resolved in one or more JIRA versions. A JIRA issue is considered as
*affected*, if

1.  It's mentioned in at least one commit message of the *local* branch
    commits which are pushed; and

2.  It's not mentioned in any commit message of the *remote* branch
    commits which are going to be replaced; and

3.  when using Git-Flow, you are not pushing into a *feature* branch or
    a *hotfix* branch (SmartGit will ask you whether to resolve such
    commits when **Finishing** the feature or hotfix, i.e. integrating
    the commits into `develop` or `master`).

4.  The issue is actually *resolvable* (or more precisely: there is at
    least one *Transition* available which puts the issue into a
    *resolved* state. Note that, this is usually not the case for all
    issues, especially not for issues which are already resolved/closed.

  


#### Example
> In JIRA's "classic workflow", an issue which is *in progress* can be
> *resolved* or *closed*. Hence, for such issues which are mentioned in a
> commit message, SmartGit will offer both resolutions, because these are
> reasonable transitions when pushing a commit.
> 
> On the other hand, every *resolved* or *closed* issue can be *reopened*.
> For such issues which are mentioned in a commit message, SmartGit will
> not offer any resolution.

#### Info
> You can disable the Resolve-check by configuring `jira.resolveOnPush` in the Preferences, section **Low-Level Properties**.

### Custom workflows

For the detection of *resolvable* issues, SmartGit supports the common
default JIRA workflows. If you are using a custom workflow, you probably
have to tell SmartGit about *resolvable* states, using [low-level properties](System-Properties.md).

#### Note
> SmartGit will only offer resolution of issues if your JIRA credentials
> are properly configured. To ensure this, invoke **Select from JIRA** and
> enter your credentials these.  
> You can completely disable this functionality using [low-level properties](System-Properties.md).


## Support for 'commit.template'

The JIRA integration will honor the Git `commit.template` configuration.
Following keywords are substituted by the according JIRA issue
attributes:

-   `%BUGID%`
-   `%BUGSUMMARY%`
-   `%BUGDESCRIPTION%`

## Miscellaneous

The configuration of your JIRA connections are stored in `bugtracker.yml`, in the [Settings directory](Installation-and-Files.md). Referenced passwords are stored in `passwords`.

## Possible problems and solutions

### "No project could be found with key '...'" or "The value '...' does not exist for the field 'project'"

JIRA cloud may stop returning proper HTTP error `401` once an authentication with a token has been successful (for the first time) and the token is removed later on. This can been seen using curl:

Initially, the authentication with an invalid token fails with HTTP error code 401, which can be detected by SmartGit:

```
$ curl -I -H "Authorization: Basic bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbTpYcVF6ZFdFMGUxRUw1VmM2ZjRmWDY0MjQ=" https://yoursite.atlassian.net/rest/api/2/project/PROJECT/versions
HTTP/1.1 401 Unauthorized
```

Once the token has been created, the authentication succeeds, as expected:

```
$ curl -I -H "Authorization: Basic bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbTpIZk9rdjhHNDdZMjlLZEl0ZmczYkYxQ0I=" https://yoursite.atlassian.net/rest/api/2/project/PROJECT/versions
HTTP/1.1 200 OK
```

After the token is removed from JIRA's security settings, authentication may continue to succeed for a while (it seems to remain cached for a couple of minutes):

```
$ curl -I -H "Authorization: Basic bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbTpIZk9rdjhHNDdZMjlLZEl0ZmczYkYxQ0I=" https://yoursite.atlassian.net/rest/api/2/project/PROJECT/versions
HTTP/1.1 200 OK
```

Later, JIRA will start returning HTTP error code `404` which indicates to SmartGit that the token is good, but a non-existing project has been accessed:

```
$ curl -I -H "Authorization: Basic bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbTpIZk9rdjhHNDdZMjlLZEl0ZmczYkYxQ0I=" https://yoursite.atlassian.net/rest/api/2/project/PROJECT/versions
HTTP/1.1 404 Not Found
``` 

#### Solution

* Shutdown SmartGit
* Get rid of the corresponding configuration from `bugtracker.yml` (see above)
* Restart SmartGit
* Now SmartGit will ask for new credentials
