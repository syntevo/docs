# Stage, Unstage, and the Index Editor

Git's [Index](../GitConcepts/The-Index.md) tracks which changes in the Working Tree have been selected for inclusion in the next commit.

Changes must be added to the Index before they can be added in a new commit.

## Common Staging Operations in SmartGit

SmartGit provides the following options for modifying the selection of changes:
- **Stage** adds a new, modified, or deleted file to the index.
  For files selected in the **Files View**, all changed files in the selection will be staged.
  If no files are selected, SmartGit will display the **Stage View** dialog, showing files eligible for staging and 
  allowing you to choose which files to include or exclude from the next commit.
  Once one or more files have been staged, the **Files View** will split, with the bottom half will showing already staged files.
- **Unstage** removes files from the index (i.e., excludes them from the next commit).
  Any selected staged files will be unstaged.
  If no staged files are chosen, SmartGit will display the **Stage View**, where you can deselect files unstage them.
- The [**Changes View**](Changes-View.md) is invaluable during all staging operations, allowing you to compare changes made to a selected file easily.
  It also allows you to stage and unstage individual *Hunks*, should you wish to avoid staging all changes in a file.
- [Advanced](#advanced-staging) -- The **Index Editor** allows direct editing of the Index's contents for a selected file.
  This lets you add or remove specific content to and from the Index.

### Behavior of Stage

The outcome of the **Stage** command depends on whether the file is tracked or untracked:
- **Untracked (new) file**: If you use Stage (e.g., via **Local \| Stage**), the file will be marked for addition to the repository.
- **Tracked file**: Using Stage on a tracked file includes any modifications in the next commit, such as added, modified, or deleted lines.
- **Previously tracked but deleted file**: The file will be deleted in the next commit.

Conversely, the **Unstage** command (via **Local \| Unstage**) removes the selected file from in the Index, ensuring its changes are not included in the next commit.

#### Tip
> The behavior of the **Changes View** varies depending on the file's staging status:
>- **Unstaged file**: The **Changes View** shows differences between the **Working Tree** and the **Index**.
>- **Staged file**: The **Changes View** shows differences between the repository's **Index** and the **HEAD** commit.

Once staging is complete, you can [Commit](Committing.md) changes via the [Commit View](Commit-View.md) or by selecting the Working Tree root in the **Repositories View** and invoking the **[Commit](Committing.md)** command.

## Advanced Staging

In addition to staging changes at file level, Git allows allows partial staging of changes to a file by enabling the staging of *Hunks* (groups of contiguous lines within a file).

Staging or unstaging hunks of modified files can be done in the **Changes View** or through the **Index Editor** dialog.

### The Index Editor

By selecting a modified file and invoking the **Index Editor** (e.g., via **Local \| Index Editor**), the **Index Editor** dialog displays a three-way diff view:

- **Repository state (HEAD)**: Shown in the left pane.
- **Index state**: Shown in the center pane.
- **Working Tree state**: Shown in the right pane.

As with the **Changes View**, use the `<<` and `>>` arrows or the `x` buttons to move change *Hunks* between views.

### Additional Capabilities of the Index Editor

In addition to staging entire files and *Hunks*, the **Index Editor** allows:
- **Staging individual lines**: Right-click a line to stage it.
- **Staging a selection of lines**.
- **Direct editing**: Modify the file's contents in the *Index* and the *Working Tree* areas, though the Repository area remains uneditable.

#### Note
> - If a File is only partly staged (i.e., not all change *Hunks* are added to the Index) or if subsequent changes are made to the Index version, the **Files View** will show the file in both the Unstaged and Staged panes.
  This enables you to use the **Changes View** to see the relative differences between:
>   - The *Working Tree* and *Index*.
>   - The *Index* and *HEAD*.
> - Editing the *Working Tree* and *Index* independently can result in changes in the *Index* not present in the *Working Tree* file. After committing changes from the Index, the Working Tree file may appear *Modified*.
> - If not all changes in a *Working Tree* file are staged, the remaining changes will stay unstaged after creating a new commit. These residual changes can be added to a future commit.

## Discarding Changes

Use **Local \| Discard** (or the equivalent context menu option) to revert the contents of the selected files:
- **Back to their [Index](../GitConcepts/The-Index.md) state**.
- **Back to their repository state (HEAD)**.

If the Working Tree is in a *merging* or *rebasing* state, this command can also be applied to the root of the Working Tree to exit the *merging* or *rebasing* state.
