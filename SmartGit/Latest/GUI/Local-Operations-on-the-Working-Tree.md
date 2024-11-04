---
redirect_from:
  - /SmartGit/Latest/Local-Operations-on-the-Working-Tree
  - /SmartGit/Latest/Local-Operations-on-the-Working-Tree.html
---

# Local Operations on the Working Tree

## Stage, Unstage, and the Index Editor

Git's [Index](../GitConcepts/The-Index.md) tracks which changes in the Working Tree have been selected for inclusion in the next commit.

SmartGit provides the following options to modify this selection:

- **Stage and Unstage commands** allow you to add or remove all changes made to a file to and from the Index.
- The **Changes View** lets you add or remove only `hunks` (i.e., parts of a file) to or from the Index (`git add -i`).
- The **Index Editor** allows direct editing of the contents of the Index for a specific file, letting you add or remove arbitrary content to and from the Index.

Depending on whether a file is tracked or untracked:

- If you use **Stage** on an untracked (new) file (e.g., via *Local \| Stage*), it will be scheduled for addition to the repository.
- If **Stage** is used on an already-tracked file, changes will be scheduled for the next commit, including any modifications or deletions.

Conversely, the **Unstage** command (via *Local \| Unstage*) will remove the selected file from in the Index, so its changes will not be part of the next commit.

Staging and unstaging hunks from the **Changes View** will schedule or unschedule parts of modified files for the next commit.

If you select a file and invoke the **Index Editor** (e.g., via *Local \| Index Editor*), the window will display a three-way diff view, showing:

- The file's state in the Repository
- The Index
- The Working Tree

You can edit the file's contents in the Index and the Working Tree but not in the repository version. Use the arrow and \`x` buttons to move changes between views. Select the working tree root in the **Repositories View** to commit staged changes and invoke the **[Commit](#commit)** command (see below).

## Ignore

The **Local \| Ignore** command marks selected untracked files as `ignored`, which is useful for preventing files like compiled output, binary, debugging, and runtime log files from being added to the repository. Ignored files will no longer appear as 'untracked', reducing visual clutter and the risk of unintentionally adding them. If the option **Show Ignored Files** is selected, ignored files will still be displayed.

#### Note:

> SmartGit only displays ignored files in versioned directories. Ignored files or sub-directories within ignored directories are not shown for performance reasons.

When a file is maked as ignored in SmartGit, an entry is added to the `.gitignore` file in the same directory. The `.gitignore` file will be added to the repository if it isn't present. To use more advanced Git ignore options, you may need to edit the `.gitignore` file(s) by hand, which will allow advanced patterns, such as entire folders, and files matching wild card patterns to be ignored.

#### Tip

> To understand why a file is *ignored*, use **Local\|Edit Ignore File**.

## Assume Unchanged

Invoke **Local \| Toggle 'Assume Unchanged'** (`assume-unchanged`) on selected modified files to prevent their local changes from being deleted. These files will no longer appear modified or included in the next commit.

To reverse this, toggle the command again. Those files will be displayed if the **Files View** option **Show Assume-Unchanged Files** is selected.

## Skipped

The **Local \| Toggle 'Skip Worktree'** (`--skip-worktree`) command skips selected files from being added to the *Index*. This is similar to [Assume Unchanged](#assume-unchanged) but more persistent especially for commands like **Reset**.

Use the toggle command again to bring a file back into the *Index*. Skipped files can be displayed by enabling **Show Skipped Files** in the **Files View**.

## Commit

The **Commit** command creates a new commit from staged changes in the local repository.
- It is recommended that the [**Commit View**](Commit-View.md) be used in most instances, allowing new commits to be easily created.
- However, the **Local \| Commit** command will bring up a dialog allowing additional functionality such as re-selecting a commit message from a recent previous commit.

If the Working Tree is in a *merging* or *rebasing* state (see [Merge](Branch/Merge.md) and [Rebase](Branch/Rebase.md)), you can only commit the entire working tree. Otherwise, you can select specific files to commit. Missing previously tracked files will be removed from the repository, and new untracked files will be added. This behavior can be adjusted in the **Preferences** under the **Commands** section.

If you have [staged changes in the Index](#stage-unstage-and-the-index-editor), you can commit them by selecting at least one file with Index changes or selecting the working tree root before invoking the Commit command.

While entering the commit message, use *\<Ctrl>+\<Space>*-keystroke to auto-complete file names or file paths.

Use **Select from Log** to choose a commit message or SHA ID from the Log. By default, SmartGit 'guides' you in writing commit messages in a standardized format with limited line lengths. You can disable this line length guide in **Edit \| Preferences**.

If **Amend last commit** is selected, you can combine the current changes with the previous commit, such as adding a forgotten file. By default, this option is only available for commits not yet pushed. You can enable this option for already pushed commits in Preferences, section **Commands**. When amending a commit, you have the option to replace, or reuse the commit message on the previous commit.

**Note:** Amend last commit is equivalent to removing the previous commit, and replacing it with a new commit representing changes made in both commits. This is why amending a commit which has already been pushed to a remote repository is not advised.

If you commit while the working tree is in *merging* state, you will have the option to create either a merge commit or a normal commit. See [Merge](Branch/Merge.md) for details.

#### Note

>
>If the commit fails because Git complains "unable to auto-detect email address", you should set your name and email address in the [Repository Settings](Repository/Repository-Settings.md) .
>

## Altering Local Commits

SmartGit provides several ways to make alterations to local commits:

- **Undo Last Commit** will undo the last commit. The contents of the last commit will be moved to the [Index](../GitConcepts/The-Index.md), so no changes will be lost.
- **Edit Commit Message** allows you to edit the commit message of the last commit. In the **Journal** view on the working tree window or the **Graph** view of the log window, you can edit the commit message of any of the local commits by selecting the commit and invoking **Edit Commit Message** from the commit's context menu.
- **Squash Commits** allows you to combine a range of local commits into a single commit, by selecting the commit range in the **Journal** view off the working tree window or the **Graph** view of the log window, and then invoking **Squash Commits** from the context menu of the commit range.
- **Reorder Commits** - In the **Journal** view of the working tree window or the **Graph** view of the log window you can drag & drop a commit to another location in the list to effectively change its position.

#### Warning

>
>Do not undo a commit that has already been pushed to a remote repository unless you understand the implications.
> This could require a force-push, potentially discarding other users' commits in the remote repository.
>

## Discard

Use **Local \| Discard** to revert the contents of the selected files either back to their [Index](../GitConcepts/The-Index.md) state, or back to their repository state (HEAD). If the Working Tree is in a *merging* or *rebasing* state, this command can be used on the root of the Working Tree to get out of the *merging* or *rebasing* state.

## Remove

Use **Local \| Remove** to remove files from the local repository and optionally to delete them in the working tree.

If the local file in the working tree is already removed, [staging](#stage-unstage-and-the-index-editor) the file deletion will have the same effect, however, the Remove command also allows you to remove files from the repository while keeping them locally.

## Moving / Renaming Files

In general, Git's move/rename tracking happens always on-the-fly, e.g. when logging or blaming a file. Hence, there is no need for an explicit *move* operation: just move your files with your favorite tools (IDE, file explorer, from command line).

However, Git does possess a `git move` command for convenience which performs a normal file system move and then stages the removed and the newly added file to the *Index*. For a GUI client like SmartGit, providing such an operation is not usually necessary. But due to demand from users for the missing `move` operation, SmartGit provides **Local \| Move or Rename**.

## Delete

Use **Local \| Delete** to delete local files (or directories) from the working tree. You either may delete the files directly or move them to the trash.

## Stashes

Stashes are a convenient way to put the current working tree changes or just some selected files aside and re-apply them later.

Use **Local \| Stash All** to stash away all local modifications of your working tree. To stash away only the selected files, use **Local \| Stash Selection**. The resulting stash will show up in the **Branches** view.

#### Note

>
>The option **Include untracked files** (Preferences, page **Commands**)
> is convenient to include *untracked* files for the stash as well.
> Depending on the operating system it may take significantly longer to execute the operation.
>

Right-click the stash and select **Apply Stash** to re-apply the contained changes to your Working Tree (e.g. after switching branches). To get rid of obsolete stashes, use **Drop Stash**, however be aware that this will irretrievably get rid of the changes which are stored in the stash. The **Rename Stash** command allows you to change the displayed stash message.

## Run Garbage Collector

The Git Garbage Collector usually runs in the background, however, you can choose to explicitly execute the **Run Garbage Collector** command to force the garbage collector (`git gc`) to run immediately.

The Git Garbage Collector performs housekeeping tasks such as deleting commits which are no longer referenced in the repository, such as:

- commits which have been rebased
- commits which have been amended and rewritten to a new commit
- commits which have been squashed

You can view commits eligible for garbage collection in SmartGit's Log by selecting the **Recyclable Commits** option in the *Branches* view.
