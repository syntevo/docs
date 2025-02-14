# Integrated Comments (Log View Only)

Once [integrated with a Hosting Provider](index.md), SmartGit allows comments on commits and pull requests in the repository to be retrieved from the Hosting Provider.

## Viewing Comments

The [**Log Window**](../GUI/Log-Window.md) provides an additional *Comments* tab at the top right hand side of the **Files View**.

Selecting a comment in the *Comments* tab allows you to:
  - *Jump To* the comment, by showing the comment at the applicable location in the reviewed file in the **Compare View**.
  - *Edit* or *Delete* a comment (if the comment was created by yourself)
  - *Reply To* the comment. SmartGit will prompt you for a reply message.

## Adding Comments

Select the [*Virtual Merge Commit*](Integrated-PullRequests.md#additional-pr-features-in-the-log-window) obtained by fetching the PR from the **Branches View** of the **Log Window**, which will show the files which have been changed in the PR in the **Files View**.

Selecting a file in the **Files View** will show the changes in the [**Changes View**](../GUI/Changes-View.md) as usual.

In the **Changes View**, clicking on a change allows you to add a comment on the change (*Add 'Provider' Comment*, where *'Provider'* will be your repository host, e.g. GitHub).

- If you are the author of the comment, you can edit the comment by clicking on it (or clicking the comment and selecting *Edit*)
- You may be able to delete the comment by clicking on it (or clicking the comment and selecting *Delete*), depending on your permissions on the server.

## Comment Visual Indicators
When SmartGit detects comments, the following visual indicators are present in the **Log Window**:
- Comment 'bubble' icon alongside the *Virtual Merge Commit* in the **Graph View**
- Comment 'bubble' icon alongside each file changed in the commit
- When a file containing comments is selected in the **Files View** and displayed in the **Changes View**, SmartGit will display the comments at the line number where the comment was made.

## Note on types of Comments

Commenting implementation is specific to each Hosting Provider, and there may be different commenting options, depending on the provider.

For example, on a Pull Request, GitHub allows comments to be added to:
- individual line changes (*diffs*) in a PR
- a specific commit in the Pull Request (Plain Commit comment)
- The Pull Request as a whole (PR Comment)

#### Technical Notes on Comments

SmartGit has the following default behaviour:

- Pull Request comments will be refreshed together with those pull requests which are locally available (see **Fetch Pull Request** above).
- Plain Commit comments will by default not be refreshed for performance reasons. 

To tell SmartGit to fetch plain commit comments, too, configure option `github.commitCommentPageLimit` in [**Preferences \| Low-Level Properties**](../GUI/AdvancedSettings/Low-Level-Properties.md)

Pull Request and Plain Commit comments can both refer either to a commit itself or to a specific line in a file:

- Commit comments will show up in the **Commits** view.
- Comments on individual lines will show up in the **Changes** view and the affected files will be highlighted in the **Files** and **Commits** view, too.
  This works the same way for line-comments of Pull Requests, provided that the pull request has been **Fetch**ed and the local pull request *merge* commit has been selected.

If a pull request *merge* commit is selected, only line-comments of the pull request can be manipulated.

Comments on individual lines will show up in the Changes view and the affected files will be highlighted in the Files and Commits view, too. 
This works the same way for line-comments of Pull Requests, provided that the pull request has been Fetched and the local pull request merge commit has been selected.
Comments can be created, modified and removed using the corresponding actions from the Comments menu or context menu actions in the Commits and Changes view. 
If a pull request merge commit is selected, only line-comments of the pull request can be manipulated.

After commenting changes, it’s probably a good idea to Reject the pull request to signal the initiator of the pull request, that modifications are required before you are willing to pull his changes. 
If you are fine with a pull request, you may Merge it.
This will request the Hosting Provider server to merge the pull request and then SmartGit will pull the corresponding branch, so you will have the merged changes locally available.
