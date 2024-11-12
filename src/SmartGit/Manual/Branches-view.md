# Branches view

The **Branches** view shows *local* and *remote* branches, tags and
other *refs* from your repository and offers operations on these
*refs*. *Remotes* will also be displayed and used to group the *remote
branches*.

![branches-view](attachments/branches-view.png)

The current branch is shown with the filled triangle and bold text.
Any other tag or branch that points to the same commit as HEAD (the current branch) is shown with a non-filled triangle.
Lightly displayed branches below a remote indicate branches that are tracked by local branches (AKA already locally available).

Behind a tracked branch you can find symbols to indicate the the tracking state.
An '=' indicates that the tracking branch is equal to its tracked branch.
An '>' indicates "outgoing" commits, an '<' "incoming" commits.

The checkboxes in front of refs (only in the Branches view of the Log window) are used to select which branches are shown in the Graph.
The used color inside the checkbox is the color used in the Graph for the ref symbol.
Clicking a checkbox of a category (e.g. "Features" or "\<remote\>") selects/unselects all refs of this category.

If "Recyclable Commits" is selected, all commits not reachable by refs are shown in the Graph.
That is useful to, e.g., access a previous commit after amending a commit, or after a ref has been deleted.

## Tag-Grouping

The **Tags**-part of the **Branches** view will be grouped according to
a *tag-grouping configuration*. This configuration is stored in your
repository's `.git/config` and can be edited in **Repository\|Settings**, section **Tag-Grouping**.
To disable this grouping feature for the current repository, set both **Pattern** fields empty.
