# Repositories, Directories and Files

The Repositories view shows all repositories known to SmartGit and, for
repositories opened in this window, the directory structure (and their
states). The Files view displays the status of your working tree (and
Index). The primary directory states are listed in [Primary Directory States](#directory-states), and
possible states of submodules in [Submodule States](#submodule-states).
The possible file states are listed in [File States](#file-states).

## Repository Management

To add existing or new local repositories to SmartGit, please take a
look at the section [Repository-Related](Repository-Related.md).

## File Filtering

The **Files** view can be filtered by file state and
name. The state filters can be set using the small toolbar buttons above
the table as well as the menu items in the **View** menu. By default, if
committable files (e.g. *index-only changed* or *untracked*) are hidden,
the background turns to light-red as a reminder to not forget about
them. If this annoys you because you permanently have untracked files in
your working, you should consider to mark them as ignored. If this is no
option for you, you can deactivate this coloring feature in the
Preferences (page **User Interface**, option **Use background color for
the file table to indicate certain states**).

To filter by name, use the input field (or *\<Ctrl/Cmd>+\<F>*-keystroke)
above the file table. The context menu allows to enable regular
expressions and save patterns for later usage or delete them. Even if
unchanged files are hidden, they can be found by filtering by name - the
files matching by name but not by state are shown in gray, while a
light-yellow background indicates the name-filtering state.

## Directory States

Icon | State | Description
-------- | -------- | --------
![](attachments/53215375/53215401.png)| Default | Directory is present in the repository (more precisely: there is at least one versioned file below this directory stored in the repository).
![](attachments/53215375/53215399.png)| Modified | Directory is present in the repository and there are local changes within this directory in the working tree.
![](attachments/53215375/53215386.png)| Unversioned | Directory (and contained files) are present in the working tree, but have not been added to the repository yet. Use **Stage** to add the files to the repository.
![](attachments/53215375/53215385.png)| Ignored | Directory is not present in the repository (exists only in the working tree) and is marked as to be ignored.
![](attachments/53215375/53215376.png)| Missing | Directory is present in the repository, but does not exist in the working tree. Use **Stage** to remove the files from the repository or **Discard** to restore them in the working tree.
![](attachments/53215375/53215395.png)| Conflict | Repository contains conflicting files (only displayed on the root directory). Use **Resolve** to resolve the conflict.
![](attachments/53215375/53215403.png)| Merge | Repository is in 'merging' or 'rebasing' state (only displayed on the root directory). Either **Commit** the merge/rebase or use **Discard** to cancel the merge/rebase.
![](attachments/53215375/53215400.png)| Root/Submodule | Directory is either the repository root or a submodule root, see [Submodule States](#submodule-states)

## File States

Icon | State | Description
-------- | -------- | --------
![](attachments/53215375/53215378.png) | Unchanged | File is under version control and neither modified in working tree nor in Index.
![](attachments/53215375/53215386.png) | Unversioned | File is not under version control, but only exists in the working tree. Use **Stage** to add the file or **Ignore** to ignore the file, or **Commit** to commit it right away.
![](attachments/53215375/53215396.png) | Ignored | File is not under version control (exists only in the working tree) and is marked to be ignored.
![](attachments/53215375/53215377.png) | Modified | File is modified in the working tree. Use **Stage** to add the changes to the Index or **Commit** the changes immediately.
![](attachments/53215375/53215387.png) | Staged | File is modified and the changes have been staged to the Index. Either **Commit** the changes or **Unstage** changes to the working tree.
![](attachments/53215375/53215392.png) | Staged Modified | File is modified in the working tree and in the Index in different ways. You may **Commit** either Index changes only or working tree changes plus Index changes.
![](attachments/53215375/53215392.png) | Staged, WT as HEAD | File is modified in the working tree and in the Index in different ways, but the working tree state is identical to the HEAD state. Using **Stage** will turn the file back to unchanged again.
![](attachments/53215375/53215377.png) | Modified (File Mode) | The content of the file is not modified, but the executable bits are set different than in the repository. Refer to [Fixing 'Modified (File Mode)' on Windows](#fixing-modified-file-mode-on-windows) on how to fix that state on Windows.
![](attachments/53215375/53215377.png) | Modified (EOLs only) | The content of the file is modified, but only differs in line endings from the Index state. This state will only be determined/show up if [smartgit.refresh.inspectEol](System-Properties.md) system property is set.
![](attachments/53215375/53215377.png) | Modified (EOLs only, not stageable) | The content of the file is modified, but only differs in line endings from the Index state; but, due to the Git configuration (usually `core.autocrlf`) this modification can't be staged. <br> Usually, when trying to stage, Git will issue a warning `warning: LF will be replaced by CRLF in ...` here. This state will only be determined/show up if [smartgit.refresh.inspectEol](System-Properties.md) system property is set.
![](attachments/53215375/53215398.png) | Added | File has been added to Index. Use **Unstage** to remove from the Index.
![](attachments/53215375/53215393.png) | Removed | File has been removed from the Index. Use **Unstage** to un-schedule the removal from the Index.
![](attachments/53215375/53215388.png) | Renamed | File is scheduled for addition and has been detected as renamed, see [Preferences, section Refresh](Preferences.md#refresh)
![](attachments/53215375/53215384.png) | Renamed (untracked) | File is untracked and has been detected as renamed, see [Preferences, section Refresh](Preferences.md#refresh)
![](attachments/53215375/53215389.png) | Renamed (modified) | File is scheduled for addition, has been detected as renamed (in the Index) and – on top of that – is modified in the working tree. Use will probably want to use **Stage** to add the working tree changes to the Index.
![](attachments/53215375/53215383.png) | Rename Source | File is the added (or missing) source of a detected **Renamed** file.
![](attachments/53215375/53215382.png) | Rename Source (untracked) | File is the added (or missing) source of a detected **Renamed (untracked)** file.
![](attachments/53215375/53215376.png) | Missing | File is under version control, but does not exist in the working tree. Use **Stage** or **Remove** to remove from the Index or **Discard** to restore in the wirking tree.
![](attachments/53215375/53215391.png) | Added Modified | File has been added to the Index and there is an additional change in the working tree. Use **Commit** to either commit just the addition or commit addition and change.
![](attachments/53215375/53215390.png) | Intent-to-Add | File is planned to be added to the Index. Use **Add** or **Stage** to add actually or **Discard** to revert to untracked.
![](attachments/53215375/53215395.png) | Conflicted | A merge-like command resulted in conflicting changes. Use the **Conflict Solver** to fix the conflicts.
![](attachments/53215375/53215394.png) | Assume-Unchanged | File has the Assume Unchanged flag set. Use **Toggle 'Assume Unchanged'** to clear this flag.
![](attachments/53215375/53215385.png) | Skipped | File has the Skip Worktree flag set. Use **Toggle 'Skip Worktree'** to clear this flag.
![](attachments/53215375/53215397.png) | Inaccessible | File's working tree content is not accessible and hence its state can't be evaluated. This usually happens if another application has an exclusive file system lock on this file. To resolve, shutdown all applications which might possibly lock this file.

## Submodule States

Many of the file states apply for submodules, too. In addition, there
are following notable submodule states which may either refer to the
*state of the submodule point* relative to the parent repository or to
the *contents of the submodule working tree* or to a combination of both
of them.

Icon | State | Description
-------- | -------- | --------
![](attachments/53215375/53215378.png) | Submodule | Unchanged submodule.
![](attachments/53215375/53215377.png) | Modified pointer | Submodule in working tree points to a different commit than the one registered in the repository. Use **Stage** to register the new commit in the Index, or **Reset** to reset the submodule to the commit registered in the repository.
![](attachments/53215375/53215377.png) | Modified contents | The working tree (or Index) of the submodule contains modifications. Select/open the submodule repository and inspect changes.
![](attachments/53215375/53215380.png) | Uninitialized submodule | Use **Submodule\|Initialize** to initialize.
![](attachments/53215375/53215379.png) | Foreign repository | Nested repository is not registered in the parent repository as submodule. Use **Stage** to register (and add) the submodule to the parent repository.
![](attachments/53215375/53215376.png) | Missing submodule | Submodule is registered in the parent repository and initialized, but it's not locally present. Use **Submodule\|Initialize** to fix.

## File table "duplicate(!)" marker

If the file table shows a **duplicate(!)** marker after a file name,
this means that you are on Windows or on MacOS with case-insensitive
file name and your repository contains the same file, just with changed
case. Such a constellation does not work well for (Smart)Git, so you
should resolve the problem of duplicate files. The easiest way will
probably be to fix this on a case-sensitive file system.

## Fixing 'Modified (File Mode)' on Windows

On Windows, the *Modified (File Mode)* state is usually caused due to a
misconfiguration of your local repository, when not having
`core.filemode` configuration option explicitly set to `false` (the
default value is `true`).

Hence, if this option in not present in `.git/config` of your
repository, invoke `git config core.filemode false` in the root
directory of your repository to fix this problem.


