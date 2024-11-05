# Commit View

The **Commit** view in SmartGit's [**Working Tree**](Working-Tree-Window.md) and [**Log**](Log-Window.md) Windows will change, depending on which node is selected in the Graph:
- If the Working Tree node is selected, the view is used to [create a new commit](#create-new-commit) on the currently checked out branch or HEAD
- If an existing commit node is selected,the view will show important commit audit and metadata [information about this commit](#view-existing-commit).

#### Note
> The Commit view in the **Standard Window** is slightly different. Please refer to the [**Standard Window**](Standard-Window.md) documentation.

The layout of the **Commit** view depends on the **Graph** selection:

### Create New Commit

If the *working tree* node is selected, it shows :

- a field to compose the message for the next commit
- options available in the current context
- a **Commit** button to actually perform the commit, with the option to instead **Amend** the previous commit.

![SmartGit Commit View - Adding a new Commit](../images/Commit-View-Add-Commit.png)

*SmartGit Commit View - Adding new Commit*

### View Existing Commit

However, if an existing commit is selected, it shows details for the selected commit:

- **branches** and **tags** shows all branch/tag-refs which are displayed in the **Graph** for the selected commit.
- **same state tags** (only File Logs) shows those tags which contain the file with exactly the same content as for the selected commit; this category will only be present if **Tag-Grouping** has been configured in the **Repository Settings** (for details refer there).
- **closest tags** shows those tags for a commit:
    - from which the commit is reachable; and
    - from which there is no other tag reachable from which the commit is reachable, too. In addition, more relevant tags will be added if **Tag-Grouping** has been configured in the [**Repository Settings**](Repository/Repository-Settings.md).
- **on branches** shows all branch-refs for which the selected commit is an ancestor reachable by following only "primary" parents, i.e. is part of the branch's "natural" history
- **merged to branches** shows all branch-refs for which the selected commit is an ancestor, but only reachable by following at least one merge parent (2nd or higher parent of a commit)

![SmartGit Commit View - Viewing an existing Commit](../images/Commit-View-Show-Mode.png)

*SmartGit Commit View - Viewing existing Commits*

#### Tip

> As per the above image, you can select up to 2 Commits - the **Commit** view will show both commits.

## Variations of the Commit View

- When using the [Standard Window](Standard-Window.md), the Commit View will also show an exerpt of the 'Journal' beneath the view.
