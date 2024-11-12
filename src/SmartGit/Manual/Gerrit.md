# Gerrit

SmartGit provides integration with Gerrit in the *Log* and the *Working Tree* windows.
You can invoke the **Push to Gerrit** command in the **Branches** view if a Gerrit remote has been detected.
It will offer a dialog with special Gerrit-related Push options.

Prerequisites are that `.git/hooks/commit-msg` exists and is related to Gerrit.

## .gitreview

If a `.gitreview` file is present in the root directory of your repository,
SmartGit will detect the Gerrit server from its properties,
according to the [git-review documentation](https://linux.die.net/man/1/git-review).
Given this configuration, a matching remote will be looked up from your `.git/config`.

The `defaultbranch` will be used as **Target** branch if configured.

If there is a `review.remote` configuration present in your `.git/config`, this will take precedence.

## General remote detection

If there is no `.gitreview` file present, SmartGit will detect a remote as being connected to Gerrit if an appropriate `remote` can be determined from `.gitconfig` for the selected branch:
-   If the remote is configured as `review.remote`, this remote will be used.
-   If the branch is tracking a remote branch and its remote is connecting to port 29418 (default Gerrit SSH port), this remote will be used.
-   If the branch is not tracking a remote branch:
    -   If there is a unique remote connecting to port 29418, this remote is used.
    -   If there is no remote connecting to port 29418 but there is only a single remote overall, this remote is used.


#### Tip
> To have Gerrit-related commands available in context menu,
> set [Low-level Property](System-Properties.md) `ui.showPushToGerritInMenu`.




#### Info
> If **Push to Gerrit** doesn't show up for you despite of the above
> conditions being met, you may enable debug logging for
> "smartgit.gerrit". For details refer to Debugging.


