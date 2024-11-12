# Local Operations on the Working Tree

## Stage, Unstage, and the Index Editor

Git's [Index](The-Index.md) is basically a
selection of changes from the working tree to be included in the next
commit. SmartGit provides following facilities to modify this selection:

-   **Stage and Unstage commands** allow you to add and remove whole
    files to and from the Index, respectively.
-   **Changes view** allows you to add or remove individual \`hunks'
    (i.e. parts of the file) to and from the Index.
-   **Index Editor** allows you to directly edit the contents of the
    Index for a certain file, thereby adding or removing arbitrary
    content to and from the Index.

If you invoke Stage on an untracked file, e.g. via **Local\|Stage**,
that file will be scheduled for addition to the repository. On a tracked
file, the effect of Stage is to schedule for the next commit any changes
made to the file, including its removal.

Conversely, the Unstage command (**Local\|Stage**) will discard the
selected file's changes in the Index, meaning that the Index changes
will be lost, unless they are identical to the current changes in the
working tree.

Similarly, staging and unstaging hunks from the **Changes** view will
schedule or un-schedule parts of the file's changes for the next commit.

If you select a file and invoke the Index Editor, e.g. via
**Local\|Index Editor**, the Index Editor window will come up. It is
basically a three-way diff view where the three editors represent the
file's state in the repository, the Index and the working tree,
respectively. You can edit the file contents in the Index and the
working tree, and move changes between these two editors by clicking on
the arrow and \`x' buttons in-between.

Lastly, to commit staged changes, select the working tree root in the
**Repositories** view and invoke the [Commit](#commit) command.

## Ignore

Invoke **Local\|Ignore** on a selection of untracked files to mark them
as to be ignored. The Ignore command is useful for preventing certain
local files that should not be added to the repository from showing up
as \`untracked'. This reduces visual clutter and also makes sure you
won't accidentally add them to the repository. If the Files view option
**Show Ignored Files** is selected, ignored files will be shown.


#### Note
>
>
>**Show Ignored Files** will only display ignored files in versioned
>directories. Ignored files or sub-directories in ignored directories
>won't show up, as SmartGit will not even scan into these directories for
>performance reasons.
>
>

When you mark a file in SmartGit as \`ignored', an entry will be added
to the `.gitignore` file in the same directory. Git supports various
options to ignore files, e.g. patterns that apply to files in
subdirectories. With the SmartGit Ignore command you can only ignore
files in the same directory. To use the more advanced Git ignore
options, you may edit the `.gitignore` file(s) by hand.


#### Tip
> To understand by which configuration an *ignored* file is becoming
> ignored, use **Local\|Edit Ignore File**.



## Assume Unchanged

Invoke **Local\|Toggle 'Assume Unchanged'** on a selection of modified
files to 'ignore' their local modifications. Such files won't be
detected as modified afterwards and hence won't be included for the next
commit.

To turn a file back into *Modified* state, use **Toggle 'Assume
Unchanged'** on an *Assume-Unchanged* file again. If the **Files** view
option **Show Assume-Unchanged Files** is selected, *Assume-Unchanged*
files will be shown.

## Skipped

Invoke **Local\|Toggle 'Skip Worktree'** on a selection of files to skip
them from the *Index*. This is similar to [Assume Unchanged](#assume-unchanged) , but in general more persistent in case
of commands like **Reset**.

To get a file back into the Index, use **Toggle 'Skip Worktree'** on a
*Skipped* file again. If the Files view option **Show Skipped Files** is
selected, *Skipped* files will be shown.

## Commit

The Commit command is used for saving local changes in the local
repository. You can invoke it via **Local\|Commit**.

If the working tree is in *merging* or *rebasing* state (see
[Merge](Merge.md) and [Rebase](Rebase.md)), you can only commit the whole
working tree. Otherwise, you can select the files to commit. Previously
tracked, but now missing files will be removed from the repository, and
untracked new files will be added. This behavior can be changed in the
Preferences, section **Commands**.

If you have [staged changes in the Index](#stage-unstage-and-the-index-editor), you can commit them by
selecting at least one file with Index changes or by selecting the
working tree root before invoking the Commit command.

While entering the commit message, you can use
*\<Ctrl>+\<Space>*-keystroke to auto-complete file names or file paths.
Use **Select from Log** to pick a commit message or SHA ID from the Log.
By default, SmartGit will 'guide' you to write commit messages in some
standard format, which will not exceed certain line lengths. You can
disable this line length guide in the preferences.

If **Amend last commit instead of creating a new one** is selected, you
can update the commit message and files of the previous commit, e.g. to
add a forgotten file. By default, this option is only available for not
yet pushed commits. You can enable this option for already pushed
commits in the Preferences, section **Commands**.

If you commit while the working tree is in *merging* state, you will
have the option to create either a merge commit or a normal commit. See
[Merge](Merge.md) for details.


#### Note
>
>
>If the commit fails because Git complains "unable to auto-detect email
>address", you can set your name and email address in the [Repository Settings](Repository-Related.md#settings) .
>
>

## Altering Local Commits

SmartGit provides several ways to make alterations to local commits:

-   **Undo Last Commit** Invoke **Local\|Undo Last Commit** to undo the last commit. The contents of the last
    commit will be moved to the
    [Index](The-Index.md), so no changes will
    be lost.
-   **Edit Commit Message** Invoke **Local\|Edit Commit Message** to edit the commit message of the last
    commit. In the **Journal** view on the working tree window or the
    **Graph** view of the log window, you can edit the commit message of
    any of the local commits by selecting the commit and invoking **Edit
    Commit Message** from the commit's context menu.
-   **Squash Commits** To combine a range of local commits into a single
    commit, select the commit range in the **Journal** view off the
    working tree window or the **Graph** view of the log window, and
    invoke **Squash Commits** from the context menu of the commit range.
-   **Reorder Commits** In the **Journal** view of the working tree
    window or the **Graph** view of the log window you can drag&drop a
    commit to some other location in the list to effectively change its
    position.


#### Warning
>
>
>Do not undo an already pushed commit unless you know what you're doing!
>If you do this, you need to force-push your local changes, which might
>discard other users' commits in the remote repository.
>
>

## Discard

Use **Local\|Discard** to revert the contents of the selected files
either back to their [Index](The-Index.md)
state, or back to their repository state (HEAD). If the working tree is
in a *merging* or *rebasing* state, use this command on the root of the
working tree to get out of the *merging* or *rebasing* state.

## Remove

Use **Local\|Remove** to remove files from the local repository and
optionally to delete them in the working tree.

If the local file in the working tree is already missing,
[staging](#stage-unstage-and-the-index-editor) will have the same
effect, but the Remove command also allows you to remove files from the
repository while keeping them locally.

## Moving/Renaming Files

In general, Git's move/rename tracking happens always on-the-fly, e.g.
when logging or blaming a file. Hence, there is no need for an explicit
*move* operation: just move your files with your favorite tools (IDE,
file explorer, from command line).

Still, Git offers a `git move` command for convenience which performs a
normal file system move and then stages the removed and the newly added
file to the *Index*. For a GUI client like SmartGit, providing such an
operation is not necessary. Still, because users are frequently confused
about the missing move operation, SmartGit provides **Local\|Move or Rename**.

## Delete

Use **Local\|Delete** to delete local files (or directories) from the
working tree. You either may delete the files directly or move them to
the trash.

## Stashes

Stashes are a convenient way to put the current working tree changes or
just some selected files aside and re-apply them later.

Use **Local\|Stash All** to stash away all local modifications of your
working tree. To stash away only the selected files, use **Local\|Stash
Selection**. The resulting stash will show up in the **Branches** view.


#### Note
>
>
>The option **Include untracked files** (Preferences, page **Commands**)
>is convenient to include *untracked* files for the stash as well.
>Depending on the operating system it may take significantly longer to
>execute the operation.
>
>

Right-click the stash and select **Apply Stash** to re-apply the
contained changes to your working tree again. To get rid of obsolete
stashes, use **Drop Stash**, however be aware that this will
irretrievably get rid of the changes which are stored in the stash. Use
**Rename Stash** to change the displayed stash message.

## Run Garbage Collector

The **Run Garbage Collector** command runs some housekeeping tasks. When
rebasing commits of a side-branch to newer commits of the main-branch,
the rebased commits get obsolete. Same applied for the previous commit
when commit-amending. You can make those commits visible in SmartGit's
Log by selecting the **Recyclable Commits** option in the *Branches*
view.
