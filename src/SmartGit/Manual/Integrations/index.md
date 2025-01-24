# SmartGit Integrations with other Applications and Git Hosting Services

SmartGit works with many modern Git Hosting services, and can also be used with popular Issue Tracking systems. 
These integrations allow extended functionality in SmartGit, which can improve productivity within a team as part of a larger Software Engineering development process (often referred to as 'Dev Ops' processes)

## Supported Git Hosting services:

Please refer to the applicable vendor specific documentation in order to connect a SmartGit repository to a Git hosting provider:

- [Microsoft Azure DevOps](Azure-DevOps.md)
- [Atlassian Bitbucket Cloud](Bitbucket-integration) and [Bitbucket and Atlassian Stash On Premises](BitBucket-Server-Atlassian-Stash-integration.md)
- [GitHub](GitHub-integration) and [GitHub Enterprise On Premises](GitHub-Enterprise-Integration.md)
- [GitLab](GitLab.md)

**TODO Show icons for each vendor **

#### Note on Terminology:

> The terminology between hosting providers differs somewhat for equivalent or similar features, as per the below table.
> SmartGit will automatically change terminology to adapt to the Hosting Provider connected to the repository, where applicable.
> However, for brevity, the online documentation will use the GitHub terminology when referencing features linked to online hosting providers.

| GitHub             | Azure DevOps | BitBucket    | GitLab          |
| ------------------ | ------------ |------------- | --------------- |
| Pull Request       | Pull Request | Pull Request | Merge Request   |
| Reject PR          | Abandon PR   | Decline PR   | Close PR        |
| Approve PR Changes |              | Approve      |                 |
| *                  |              | Unapprove    | Revoke Approval |


### Feature Support Matrix:

|                                       | GitHub | Azure DevOps | BitBucket | GitLab    |
| ------------------------------------- | ------ | ------------ |---------- |---------- |
| Navigation Links                      |   Yes  |      *       |     *     |     *     |
| Repository Selection + Cloning        |   Yes  |     Yes      |     Yes   |     Yes   |
| Inbound and Outbound PR Notifications |   Yes  |              |           |           |
| Initiate Pull Request                 |   Yes  |     Yes      |     Yes   |     Yes   |
| View, Add, Edit and Delete Comments   |   Yes  |     Yes      |     Yes   |     Yes   |
| Approve Pull Request                  |   Yes  |     Yes      |     Yes   |     Yes   |
| Merge Pull Request                    |   Yes  |     Yes      |     Yes   |     Yes   |
| Close Pull Request                    |   Yes  |     Yes      |     Yes   |     Yes   |


### Visual Indicators and Navigation
The following visual indicators and productivity aids are made available once a repository is cloned from a linked hosting provider:
- An icon representing the hosting provider will appear above the *Branch View*. Clicking this icon will **TODO** seems to fetch ? Check for PRs and Comments?
- On the **Working Tree Window**, a link will appear next to the icon above the *Branches View* which will show open Pull Requests (in the navigation view)
- On the **Log Window**, the *Branches View* will show available Pull Requests on the remote repository on the hosting provider.
- In the **Standard Window**, 


## Supported Continuous Integration / Continuous Deployment services:
- [GitHub Actions](GitHub-Actions)
- [Jenkins](Jenkins.md)
- [JetBrains TeamCity](TeamCity.md)

### Additional SmartGit Features
- A `CI` indicator is shown in the *All Branches + Tags* tab of the **Standard Window** on the branch(es) which have been configured for CI Pipelines
- A branch marked witht the `CI` indicator can be clicked to open a context menu, allowing navigation to the latest CI Result on the CI/CD service provider

## Integration with other Software
- [Atlassian JIRA](JIRA.md) - Allows commit messages to be extracted from an open JIRA ticket
- [Gerrit](Gerrit.md) - **TODO**
- [Git Large File Storage](Git-LFS.md)


## Tips
- If you have multiple identities / logins to the same hosting provider, you can add multiple hosting provider accounts in SmartGit.
- The default name for each Hosting Provider connection is the name the Hosting Provider (e.g. *github.com* ).
  You can change the name under **Preferences \| Hosting Providers** by selecting the connection and clicking *Edit*.
  
