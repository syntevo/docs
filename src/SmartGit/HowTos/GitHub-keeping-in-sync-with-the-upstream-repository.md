# GitHub: keeping in sync with the upstream repository

To keep in sync with or update from the *upstream* repository, the
upstream repository must be available as additional **Remote**:

-   when freshly cloning a repository from GitHub, SmartGit will ask you
    whether to add the upstream repository as additional remote, as part
    of the **Clone** wizard
-   to manually add the Remote, use **Remote\|Add** in the main window,
    enter the **URL** to the upstream repository and call it `upstream`.

## Merging from upstream

To incorporate changes from the upstream repository, invoke **Pull** and
select to **Fetch From** `upstream`. This will update your `upstream/*`
refs. To review the changes, you may open the **Log** and
toggle `upstream` in the **Branches** view.

You may now use **Merge**, **Rebase** or **Cherry-Pick** to incorporate
upstream changes into your local branch.

## Updating upstream

To push changes from your current branch directly to the upstream
repository (instead of the remote repository `origin`), just invoke
**Push** and select the `upstream` remote.

To update *all* branches in *upstream* from your *remote* repository,
first **Pull** your remote repository (usually `origin`) to make sure
you will have the latest commits present. Now select `origin` in the
**Branches** view, right-click and invoke **Push To**. For **Target
Repository**, select `upstream` here.


#### Warning
> Do not use **Force pushing** nor **Remove remote branches which don't
> have a local counterpart** unless you are the owner of the `upstream`
> repository and you are aware of the consequences.



 

 

 

 
