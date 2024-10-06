# Using the SmartGit Conflict Solver to resolve merge conflicts

SmartGit comes with a Conflict Solver tool that allows merge conflict resolution using the standard *Three-Way* merge approach.

For details on how Git manages merge conflicts, and the meaning of `ours`, `theirs`, `common`, and `base` files, refer to the [Git manual](https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging).

- The **left pane** shows the local branch commit version of the file (`ours` :2)
- The **center pane** shows the file's current conflicted Working Tree version, including the merge conflict markers.  
  You can use the **`Base Changes`** command to view the original version of the file (Common Base :1)
- The **right pane** shows the merged source version of the file (`theirs` :3)

![SmartGit Conflict Solver tool](../../images/Tools-SmartGit-ConflictSolver.png)

### SmartGit Conflict Solver Tool

The following commands are available in the SmartGit conflict resolver (commands are available as buttons, and in the drop-down menu):

- **Base Changes:** Opens a window that shows the original Common Base version of the file (:1) instead of the current Working Tree file (i.e., shows the original version before either our or their changes were made to the file).
- **Save:** Saves any changes to the Working Tree file, even if conflict markers remain.
- **Prev Change:** Moves the cursor to the previous change in the selected pane.
- **Next Change:** Moves the cursor to the next change in the selected pane.
- **Take Left, Right:** Replaces the conflict with both left and right changes, first `our` change then `their` change (thiscommand is only available in the Working Tree pane).
- **Take Left:** Replaces the conflict with only the left (`our`) change and discards the right (`their`) change (this command is only available in the Left and Working Tree panes).
- **Take Right:** Replaces the conflict with only the right (`their`) change and discards the left (`our`) change (this command is only available in the Working Tree and Right panes).
- **Take Right, Left:** Replaces the conflict with both left and right changes, first `their` change, then `our` change (this command is only available in the Working Tree pane).
- **Left + Merge:** Hides the right (`theirs`) window pane.
- **All:** Shows all three panes (`ours`, `Working Tree`, and `theirs`)
- **Right + Merge:** Hides the left (`ours`) window pane.
- **Merge Below:** Moves the `Working Tree` pane to the bottom. This is useful for merging files with long lines.
- **Close:** Closes the Conflict Solver. You will be prompted to do so if you haven't saved changes. The Conflict Solver will warn you if unresolved conflicts remain in the Working Tree file.

You can substitute the SmartGit Conflict Solver with another standalone tool if you prefer another three-way merge tool to resolve conflicts. 
Please refer to [Preferences | Tools](../../Preferences/Tools.md#conflict-solvers) for instructions on how to do this.
