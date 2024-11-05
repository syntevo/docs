# Revision Graph

The **Revision Graph** is a standalone window that allows you to browse the history of a repository, which can be either the history of the entire repository, or the history of some directory or file inside the repository.
There are several ways to open the Revision Graph in SmartSVN, one of them being through the menu of the [Project Window](Project-Window.md#ProjectWindow-project-window) via **Query\|Revision Graph**.

## Configuration

When invoking the Revision Graph on a directory, you can choose **Restrict to Directory** to include only revisions in the graph for which the directory itself was touched (or copied).
This usually gives a reasonably sized graph and is the recommended option.
When selecting **Include Modified Children**, all revisions for which the directory itself or any directory or file below the directory has been touched.
This option is usually **not recommended** because it can result in huge graphs.

For files, there is no configuration necessary.

## Views

The Revision Graph window consists of several views: **Revisions**, **Revision Info**, **Directories** and **Files**.
The **Revisions** view is basically a table of commits with a graph showing the parent-child relationships between the commits.
This will be discussed in more detail in [Revisions view](#revisions-view).
The three other views display additional information related to the commit currently selected in the Revisions view:

-   The **Revision Info** view displays various attributes of the
    selected commit, such as commit message, revision number, commit
    date, author, etc.
-   The **Directories** and **Files** views provide a file-manager-like
    view of the files that were modified as part of the selected commit.
    What is shown in the Files view depends on the selection in the
    Directories view; that is, it shows all modified files in the commit
    beneath the directory currently selected in the Directories view.

At any time, exactly one of the four aforementioned views is 'active', as indicated by the color of the tab titles.
Menu and toolbar actions are always performed on the currently active view.


#### Note
> As the Revision Graph displays branches and tags, the Tag-Branch-Layout must be configured properly.

## Revisions view

The Revisions view lists all commits in the repository sorted by date, with the newest commits on top.

Each of the various table columns displays a certain commit attribute, such as **Message** and **Revision**.
You can hide and show columns by right-clicking on the column header area and selecting or deselecting entries in the context-menu.
You can also reorder the columns via drag and drop of the column headers.
The **Message** column contains a graph showing the parent-child relationships between the commits.
Generally, the graph will consist of vertical lines of different color, each of which represents a branch of development.
These branches may split or merge to represent branching and merging operations that occurred at some point in the repository history.
At the end of each branch, you will find a commit that has a colored label attached to it, i.e. a colored box containing the name of the branch the commit belongs to, such as *trunk* or *feature-branch*.
These labels will of course move along as you commit into the respective branches.
In addition to the branch labels, there are also labels for tags, like *1.0* or *1.5-beta-1*.

Tags will be displayed *inlined* if they represent a clean copy, without mixed revisions or modifications.
Otherwise, tags will be displayed as separate commits.

You can toggle which branches should be displayed in the **Branches** view.

With **View\|Show Dead Tags and Branches** you can toggle the display of branch/tag labels which do not exist anymore in the latest revision, but have been removed before.
These labels contain an additional **DEAD** marker.
Select **View\|Join Same Locations** to display revisions having the same URL in the same branch (column).
Having locations joint gives a better impression of which different URLs are used and can result in a more compact graph.
Depending on the number of branch replacements, it can also make branches lengthy and the graph more complex.
Disabling this option gives best results in combination with disabling **Show Dead Tags and Branches**.

On the top right of the **Revisions** view is a **Filter** text field that allows you to enter expressions for filtering out some of the commits in the Revision Graph.
This filter works just like the one on the [file table](Directory-Tree-and-File-Table.md#name-filters).
Additionally, the drop-down menu on the left of the filter field allows you to include or exclude certain commit attributes from being matched against, namely Author, Branch and Message.
For example, if only the Author field is selected, the filter expression entered into the filter field will only be matched against the author fields of the commits.

## Merge Information

The Revision Graph can display information on which revisions have been merged from other revisions in various ways.
Depending on the selected visualization method, it may be necessary to fetch SVN's *mergeinfo* for every displayed revision from the repository, what may take a while.
SmartSVN will cache this *mergeinfo* for the current graph, so subsequent invocations of mergeinfo-related queries are performed much faster.

All mergeinfo which has been loaded since the Revision Graph has been opened is cached and can be viewed with the **Merge Coloring** (see below).
To get rid of all cached mergeinfo, use **Query\|Clear Merge Information**.

### Merge Coloring

From the **View** menu, you can switch from default **Branch Coloring** to **Merge Coloring**.
Merge coloring shows all currently loaded (cached) mergeinfo relative to the currently selected revision.
Default colors have following meaning (colors can be adjusted in the Preferences):

-   **black:** current revision and its *natural* history
-   **green**: revision has been merged into the current revision once
-   **light green:** revision was merged into the current revision exactly at the current revision
-   **red:** revision has not yet been merged

### Merge Arrows

Use **Query\|Show Merge Arrows** to display *merge arrows* connecting merge source with merge target revisions.
Connectors will show up with normal (bold) lines, if the merge target contains **all** merge source revisions.
If it's just a partial merge, connectors will show up with thin, dashed lines.

Depending on the size of the graph, displaying merge arrows can take a very long time, because SmartSVN has to send multiple mergeinfo-query-requests for every single revision.

### Merge Sources

Use **Query\|Show Merge Sources** to display which revisions have been merged into the currently selected *target* revision(s).
This requires to load mergeinfo only for the currently selected revision and then switch to the **Merge Coloring**.

## Directories/Files view

The **Directories** and **Files** view show *all* touched directories and files for the currently selected revision.
Use **View\|Show Files Recursively** to have also files of subdirectories of the currently selected directory show up in the **Files** view.
When selecting **View\|Show Only Entries Below Selected Directory** is selected, not *all* directories and files will be shows, but only those which are part of the directory for which the Revision Graph had been invoked.

## Possible problems and solutions

#### Error "<...> is not beyond cache root <...>"

This error may show up if the [Log Cache](Log-Cache.md) has been limited to a sub-directory of the repository and for building the Revision Graph some Log-data outside of this directory is required.
To resolve the problem, open **Project|Manage Log Caches**, delete the corresponding cache and re-invoke the Revision Graph.
Now, when asked for the Log Cache remote location, select **Create cache for whole repository at**.
