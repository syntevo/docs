# SmartGit Integrations with other Applications and Git Hosting Services

SmartGit integrates with many modern Git Hosting services, such as GitHub, and can also be used with popular issue-tracking systems like JIRA.
These integrations extend SmartGit's functionality, enhancing productivity within a team as part of a broader software engineering development process (often referred to as 'DevOps').

## Supported Git Hosting services

Please refer to the applicable vendor-specific documentation to connect a SmartGit repository to a Git hosting provider:

- [GitHub](GitHub-integration.md) and [GitHub Enterprise On Premises](GitHub-Enterprise-Integration.md)
- [Microsoft Azure DevOps](Azure-DevOps.md)
- [Atlassian Bitbucket Cloud](Bitbucket-integration.md) and [Bitbucket and Atlassian Stash On Premises](BitBucket-Server-Atlassian-Stash-integration.md)
- [GitLab](GitLab.md)

Once integration is configured, the following features become available in SmartGit:

- [Integrated Cloning](Integrated-Cloning.md)
- [Integrated Pull Requests](Integrated-PullRequests.md)
- [Integrated Commenting on Pull Requests](Integrated-PullRequest-Comments.md)


#### Terminology Differences

> The terminology used by different hosting providers varies for features.
> SmartGit automatically adapts the terminology based on the connected hosting provider.
> However, for brevity, SmartGit's online documentation uses GitHub's terminology when referencing features linked to online hosting providers.

| GitHub             | Azure DevOps | BitBucket    | GitLab          |
| ------------------ | ------------ |------------- | --------------- |
| Pull Request       | Pull Request | Pull Request | Merge Request   |
| Reject PR          | Abandon PR   | Decline PR   | Close PR        |
| Approve PR Changes |              | Approve      |                 |
| *                  |              | Unapprove    | Revoke Approval |


### Feature Support Matrix:

|                                                        | GitHub | Azure DevOps | BitBucket | GitLab    |
| ------------------------------------------------------ | ------ | ------------ |---------- |---------- |
| Repository Selection & Cloning                         |   Yes  |     Yes      |     Yes   |     Yes   |
| Inbound & Outbound PR Notifications (Standard Window)  |   Yes  |              |           |           |
| Initiate Pull Request                                  |   Yes  |     Yes      |     Yes   |     Yes   |
| View, Add, Edit, and Delete Comments on PRs            |   Yes  |     Yes      |     Yes   |     Yes   |
| Approve Pull Request                                   |   Yes  |     Yes      |     Yes   |     Yes   |
| Merge Pull Request                                     |   Yes  |     Yes      |     Yes   |     Yes   |
| Close Pull Request                                     |   Yes  |     Yes      |     Yes   |     Yes   |


### Visual Indicators and Navigation
Once a repository is cloned from a linked hosting provider, SmartGit provides the following visual indicators and productivity aids:
- In the **Working Tree Window**, a [shortcut link and provider icon](Integrated-PullRequests.md#additional-pr-features-in-the-working-tree-window) above the *Branches View* allows quick navigation to pull requests in the **Log Window**.
- In the **Log Window**, the *Branches View* [shows available pull requests](Integrated-PullRequests.md#additional-pr-features-in-the-log-window) on the remote repository on the hosting provider.
  In addition, many additional [comment and review features](Integrated-PullRequest-Comments.md) become available.
- In the **Standard Window**, *Incoming* and *Outgoing* pull requests [are shown](Integrated-PullRequests.md#additional-pr-features-in-the-standard-window-currently-available-for-github-only).

## Supported Continuous Integration / Continuous Deployment services:
- [GitHub Actions](GitHub-Actions.md)
- [Jenkins](Jenkins.md)
- [JetBrains TeamCity](TeamCity.md)

### Additional SmartGit Features
- A `CI` indicator appears in the *All Branches + Tags* tab of the **Standard Window** for branch(es) configured for CI pipelines.
- Clicking a branch marked with the `CI` indicator opens a context menu, allowing navigation to the latest CI result on the CI/CD service provider.

## Integration with other Software
- [Bugtraq links to Web Issue Trackers](Bugtraq-links-to-issue-trackers.md) - Enables hyperlinks between commit messages in SmartGit and web-based issue trackers such as JIRA or Azure Boards.
- [Atlassian JIRA](JIRA.md) - Allows commit messages to be extracted from an open JIRA ticket
- [Codebeamer](Codebeamer.md) - TODO
- [Gerrit](Gerrit.md)
- [Git Large File Storage](Git-LFS.md)

## Tips
- If you have multiple identities/logins for the same hosting provider, you can add multiple hosting provider accounts in SmartGit.
- The default name for each hosting provider connection is the provider's name (e.g., *github.com* ).
  You can change this name under **Preferences \| Hosting Providers** by selecting the connection and clicking *Edit*.
  
