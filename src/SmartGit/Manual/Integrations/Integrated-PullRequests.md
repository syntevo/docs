# Integrated Pull Requests

If a repository has been cloned from, and integrated to, a [Hosting Provider](index.md) such as GitHub, when SmartGit detects changes on the Hosting Provider, it will also refresh information on related Pull Requests (PRs) from the remote.

## Summary of Pull Requests features in SmartGit

The following items summarize the integrated features available directly within SmartGit, without having to interact with the pull request on the Hosting Provider.

- In the [**Standard Window**](#additional-pr-features-in-the-standard-window-currently-available-for-github-only):
  - Pull requests which have been created by you, or assigned to you, will be displayed with an *Outbound* or *Inbound* icon, respectively.
  - A *Virtual Merge Commit* representing the outcome of the pull request will allow you to view changed files in the **Files View** and **Changes View**.
  - The ability to **Approve** an incoming pull request, without providing further feedback.
    To leave feedback, use [commenting](Integrated-PullRequest-Comments.md) in the **Log Window**.
- In the [**Working Tree Window**](#additional-pr-features-in-the-working-tree-window) and **Log Window**:
  - Clicking on the Hosting Provider **Icon** will check for new branches and pull requests on the remote.
- In the [**Log Window**](#additional-pr-features-in-the-log-window):
  - The **Branches View** will show available pull requests.
  - A *Virtual Merge Commit* representing the outcome of the pull request will allow you to view changed files in the **Files View** and **Changes View**.
  - The ability to **View**, **Edit**, and **Create** comments on the pull request.
  - The ability to **Merge** or **Reject** the pull request.

## Creating a Pull Request

After pushing commits to a remote branch, you may want to create a pull request on the remote by using the Hosting Provider's custom web user interface.

With integration enabled, SmartGit provides linked shortcuts to create the pull request:
- In the **Branch View** of the **Log Window**, by clicking on the pushed branch under the remote folder, or clicking on the locally tracked branch, and selecting **Create Pull Request**.
- In the **My History View** of the **Standard Window**, by clicking on the pushed branch, and selecting **Create Pull Request**.
If you have made commits subsequent to pushing the branch to the remote, SmartGit will prompt you to push the new commits before proceeding with creating the pull request.

## Additional PR features in the Standard Window (currently available for GitHub only)

Additional functionality is available in the **Standard Window** when a repository is [integrated to GitHub](GitHub-integration.md), and where a pull request has been created by you, or assigned to you.
When SmartGit detects that you are involved in a pull request, an **Icon** will be shown in the **My History** area, as well as in the **Graph View**.

- *Incoming* pull requests are those which other users have created and assigned to you.
  On the commit, the icon below is displayed alongside the Hosting Provider's pull request reference identifier.

![Incoming Pull Request in the Standard Window](../images/Integrations-StandardWindow-IncomingPullRequest.png)

- *Outgoing* pull requests are those which you have initiated to other users/repositories, requesting them to merge your changes.
  On the commit, the icon below is displayed alongside the Hosting Provider's pull request reference identifier.

![Outgoing Pull Request in the Standard Window](../images/Integrations-StandardWindow-OutgoingPullRequest.png)

Clicking on the pull request **Icon** will allow you to open the pull request in GitHub, and will also allow you to **Approve** an incoming pull request, without providing further feedback.
To leave feedback, use the advanced [commenting review](Integrated-PullRequest-Comments.md) features in the **Log Window**.

## Additional PR features in the Working Tree Window

The **Working Tree Window** contains a light-weight GitHub integration at the top of the **Branches View**.
- A **Pull Requests** link which will take you to the **Log Window**, where the pull requests will be shown.
- An **Icon** showing the Hosting Provider connected to this repository.
  Clicking on the **Icon** will refresh the state of remote branches and pull requests.
- In the **Working Tree Window**, if open pull requests are present, a hyperlink will be shown taking you to the pull request on the **Branches View** of the **Log Window**.

#### Note

> Detailed pull request information and operations on pull requests are only available in the **Log** (see below).

## Additional PR features in the Log Window

When integrated to a repository, the **Log Window** allows interaction with pull requests in the following ways.

- Above the **Branches View**, a Hosting Provider specific **Icon** will appear.
  Clicking on the **Icon** will force a refresh of PR and branch information from the server.
- To create a pull request, click on a branch and use **Create Pull Request** from the context menu of the **Branches View**.
- On the **Log Window**, the **Branches View** will show available pull requests.

![Pull Requests under the Log Window Branches View](../images/Integrations-Branches-PullRequests.png)

- To work with the pull request on the Hosting Provider web site, click on the pull request to open the context menu, and select **Open in Web Browser**.
- To work with these pull requests locally in SmartGit (e.g. to review their commits, or **Merge** or **Reject** them):
  - The commits in the pull request can be fetched by invoking **Fetch** from the context menu of the pull request.
  - This will fetch all commits from the remote repository to a special branch in your local repository and will create an additional, *Virtual Merge Commit* between the base commit from which the pull request has been forked and the latest (remote) pull request commit.
  - The virtual merge commit is represented by a diamond icon in the **Graph View** of the **Log Window**.

![Pull Requests under the Log Window Branches View](../images/Integrations-PullRequest-VirtualMergeCommit.png)

  - Clicking on the *Virtual Merge Commit* in the **Graph View** of the **Log Window** will allow you to view the result of the pull request in the **Files View** and the [**Compare View**](../GUI/Compare-View.md) as per any normal commit.
  - You can remove the local *Virtual Merge Commit* by using the **Drop Local** command by either clicking on the pull request in the **Branches View**, or clicking on the diamond icon in the **Graph View**.

### Reviewing a Pull Request from within the SmartGit Log Window

In addition to using the Hosting Provider's standard pull request review features by using **Open in Web Browser**, it is also possible to review pull requests directly in SmartGit, viewing, adding, and editing comments on the pull request.

In addition, when the repository is integrated to the Hosting Provider, the **Files View** of the **Log Window** will show comments in the pull request.

Please refer to [integrated comments](Integrated-PullRequest-Comments.md) for detailed information on viewing, adding, or editing comments.

#### Technical note on the synchronization between SmartGit and pull requests on the remote server

**When does SmartGit detect pull requests?**
- When initially loading the **Log Window**, SmartGit will also refresh information on related pull requests from the Hosting Provider's server.
- When a user performs a **Fetch** or **Pull** from the remote in the **Standard Window**.
- When the user clicks on the Hosting Provider **Icon**s (i.e. GitHub/AzureDevOps/BitBucket, etc.).

**When does SmartGit synchronize pull requests?**

*Incoming* pull requests, in first place, are just present on the server.
SmartGit learns about them only by calling a GitHub REST API and displays the retrieved information in the **Branches**.
To work with these pull requests (e.g. to review their commits, or **Merge** or **Reject** them), you first have to fetch them by invoking **Fetch** from the context menu of the pull request.
This will fetch all commits from the remote repository to a special branch in your local repository and will create an additional, virtual *merge* commit between the *base* commit from which the pull request has been forked and the latest (remote) pull request commit.

When selecting this *merge* node in the **Commits** view, you can see the entire changes which a multi-commit pull request includes and you can [comment](Integrated-PullRequest-Comments.md) on these changes, if necessary.
After commenting on changes, it's probably a good idea to **Reject** the pull request to signal the initiator of the pull request that modifications are required before you are willing to pull their changes.
If you are fine with a pull request, you may **Merge** it.
This will request the GitHub server to merge the pull request and then SmartGit will pull the corresponding branch, so you will have the merged changes locally available.

*Outgoing* pull requests can be **Fetch**ed as well; however, this is usually not necessary, as the pull request belongs to you and it contains your own commits.
If you decide that you want to take a pull request back, use **Reject**.

For a pull request which had been fetched once, there was a special *ref* created which will make it show up in the **Pull Requests** category, even if it is not present on the server anymore.
In this case, you may use **Drop Local** on such a pull request to get rid of the corresponding ref, the local merge commit, all other commits of the pull request, and the entry in **Pull Requests** as well.
It's safe to use **Drop Local**, as it will only affect the local repository and you can re-fetch a pull request anytime you like using **Fetch** again.

You can invoke **Review \| Sync** to manually update the displayed information.
Usually you will want to do that if you know that server-side information has changed since the **Log Window** has been opened.
