# Git Log

The SmartGit Log display provides interactive visualization of the Git Log, allowing you to view the structure of the commit history in a repository, and to visualize the changes made to files and directories as commits are added.

Log is invoked from the **Query\|Log** menu option.

#### Tip

> If you make frequent use of the Log, you should consider configuring the [Log Window](Log-Window.md) as your default window when using SmartGit in the [Preferences](Preferences/User-Interface.md).

SmartGit's Log extends changes to not just your local repository's commits, but also allows you to use the **Working Tree/Index** node to operate on local changes which are not yet committed.

The Log display has the following elements:

- The [*Branches View*](Branches-view.md), allowing you to select which branches should be include in the log display. Toggle a branch to include/exclude as necessary.
- The [*Graph View*](Graph-View.md), showing a visualization of the commit history and the current HEAD references of the selected branches. You can select one or more commits on the Graph to compare changes between commits.
- The [*Commit View*](Commit-View.md), showing audit information about who and when a commit was authored, as well as the commit SHA and message.
- The *Files View*, showing state of the files as at the time of the selected Commit.
- The *Changes View*, showing differences between commits.

SmartGit's Log displays the working tree state and the repository's history as a list of commits, sorted by increasing age, and with a graph on the left side to show the parent-child relationships between the commits.

# Controlling the Scope of Files available in the Log Tool

The content displayed in the Log depends on what was selected when the Log command was invoked:

- To view the history of the entire repository (*root* Log), select the repository in the *Repositories View* before invoking the Log command.
- To view the history of a directory within the repository, select the directory in the *Repositories View* before invoking the Log command.
- To view the history of a single file within the repository, select the file in the *Files View* before invoking the Log command. If the file is not visible in the *Files View*, either adjust the file table's filter settings (on its top right), or enter the name of the file in the search field above the file table.

A *root* Log can be invoked from other places in SmartGit as well:

- In the *Branches View* (just in the *Working Tree* window), you can right-click on a branch and select **Log** to open the Log for the selected branch.
- In the *Journal View*, you can right-click on a specific commit and invoke **Log** to open the Log for the current branch, with the selected commit pre-selected in the Log.

# Comparing Changes between Commits

- If you select a single commit:
    - the *Commit View* shows the audit and commit message information for the commit.
    - the *Files view* shows the files state as at the selected commit.
    - selecting a file will show the changes committed made to this file between this commit and the previous commit, in the *Changes View*.
- If you select any two commits Graph View:
    - When you select a file in the *Files View* SmartGit will compare these two commits in the *Changes View*
    - The *Commit View* will show the respective commit audit and message information for both commits.

If the **Working Tree/Index** node is selected at the top of the commit tree, the *Files view* shows the files from the index and working tree. Selecting a file will display its index or working tree changes.

Use the checkboxes in the *Branches view* to control what is displayed in the *Graph view*. The *Recyclable Commits* checkbox at the bottom of the *Branch view* will display all commits no longer accessible from a branch or tag. This can be useful for accessing "lost" commits.

#### Note

> Git does not keep record of the (current) branch as part of a commit.
> However, when creating merge commits, Git always uses the currently checked out (branch that points to a) commit as first parent and the merged one as
> second parent.
> This way it's possible to find out which commits belong to the same branch (first parent) and which were merged (second parent).

## Log Commands

In the *Log* window, virtually all commands which are available in the context of the *Working Tree* window are available here:

- Commands which are available from the main menu bar
- Commands available on the context menu when a commit is selected
- Commands available in the **Graph** view, like *local refs* or the *HEAD*-arrow can be modified using drag-and-drop
- Commands which assist with re-writing commits. For details refer to [Interactive Rebase](Branch/Rebase-Interactive.md)

## Compare Commits

You can compare two commits in the **Graph** by selecting both commits (*Ctrl*-click). The difference from the *newer* commit compared to the *older* commit will be displayed in the **Files** view. By selecting a file you can see detailed change in the **Changes** view. In a similar way, you can compare the Index against a specific commit.

#### Tip

> When comparing branches you can also invoke **Reveal Commit** from the
> context menu of the first branch in the **Branches** view, then invoke
> **Compare with Selected Commit** on the second branch.

## Recyclable Commits

In the **Branches** view, you can toggle **Recyclable Commits** to get list obsolete heads which are no longer reachable from any *ref* in git. These unreachable commits may be eligible for permanent deletion (garbage collection).
(Technically, SmartGit will include all commits which are found in the reflogs (`.git/logs`-files) when determining which commits are `Recyclable`.)

## Skip merge optimization when filtering

By default, SmartGit will "optimize" the display of merge commits when filtering the Log Graph. To skip the merge optimization, in the Preferences, section **Low-Level Property** you may set `log.graph.topoFilter.alwaysIncludeContainingMerges` to `true`. For example, for following unfiltered Graph:

```                                                                                  
0 : 57d # [b6][*master] commit 6
     |\                                                                                 
     | \                                                                                
1 : b52 |  # [b5] commit 5
     |  |                                                                               
     |  |                                                                               
2 :  | 8e8 # [b4] commit 4
     | /|                                                                               
     |/ |                                                                               
3 :  | fe0 # [b3] commit 3
     |  |                                                                               
     |  |                                                                               
4 : 722 |  # [b2] commit 2         
     | /                                                                                
     |/                                                                                 
5 : dd2 # [b1] commit 1          
```

Filtering for "commit 1" and "commit 3" will by default give:

```
0: 57d # [6] [b6][*master] commit 6
    |\                                     
    | \                                    
1:  | fe0 # [6] [b3][b4] commit 3
    | /                                    
    |/                                     
2: dd2 # [6] [b1][b2][b5]<b4> commit 1
```

And with `log.graph.topoFilter.alwaysIncludeContainingMerges=true` it will give:

```
0 : 57d # [6] [b6][*master] commit 6
     |\                                                                       
     | \                                                                      
1 :  | 8e8 # [6] [b4] commit 4
     | /|                                                                     
     |/ |                                                                     
2 :  | fe0 # [6] [b3] commit 3
     | /                                                                      
     |/                                                                       
3 : dd2 # [6] [b1][b2][b5] commit 1
```
