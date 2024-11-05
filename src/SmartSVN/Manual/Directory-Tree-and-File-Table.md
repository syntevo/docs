# Directory Tree and File Table

The directory tree and the file table show the local directories/files
below the project's root directory. `.svn`-directories, *ignored*
directories and files within other ignored directories are not
displayed.

## Directory States/Directory Tree

The directory tree shows the project's directories and their SVN states,
which are denoted by different icons. The primary directory states are
listed in [Primary Directory States](#primary-directory-states). Every primary
state may be combined with additional states listed in [Additional Directory States](#additional-directory-states). In case
of a versioned directory, the corresponding revision number is displayed
after the name of the directory. The revision will be omitted if it's
equal to its parent directory revision. If the directory hasn't been
checked out with depth [Fully recursive](Common-Features.md#recursivedepth-options),
the check out depth will be displayed in parantheses, too. The tooltip
shows detailed SVN information for the corresponding directory, similar
to the contents of the file table, see below.

### Primary Directory States


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                   |                                                                                                                                                                                                                                       |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327307/2327341.png)            | Unchanged         | Directory is under version control, not modified and equal to its revision in the repository (i.e. to its pristine copy).                                                                                                             |
| ![](attachments/2327307/2327332.png)       | Unversioned       | Directory is not under version control and hence only exists locally.                                                                                                                                                                 |
| ![](attachments/2327307/2327348.png)           | Ignored           | Directory is not under version control (exists only locally) and is marked as to be ignored.                                                                                                                                          |
| ![](attachments/2327307/2327346.png)          | Modified          | Directory itself is modified in its properties (compared to its revision in the repository, i.e. to its pristine copy.)                                                                                                               |
| ![](attachments/2327307/2327358.png)             | Added             | Directory is scheduled for addition.                                                                                                                                                                                                  |
| ![](attachments/2327307/2327339.png)           | Removed           | Directory is scheduled for removal.                                                                                                                                                                                                   |
| ![](attachments/2327307/2327340.png)          | Replaced          | Directory has been scheduled for removal and was added again.                                                                                                                                                                         |
| ![](attachments/2327307/2327349.png)            | Copied            | Directory has been added with history.                                                                                                                                                                                                |
| ![](attachments/2327307/2327347.png) | History-Scheduled | A parent directory has been added with history, which implicitly adds this directory with history.                                                                                                                                    |
| ![](attachments/2327307/2327345.png)           | Missing           | Directory is versioned, but does not exist locally.                                                                                                                                                                                   |
| ![](attachments/2327307/2327357.png)     | Added-Missing     | The directory has been scheduled for addition, but is locally missing. Refer to the [Fix command](Fix.md#Fix-commands.fix) .                                                                                                |
| ![](attachments/2327307/2327350.png)          | Conflict          | An update command lead to conflicting changes in directories' properties.                                                                                                                                                             |
| ![](attachments/2327307/2327344.png)        | Incomplete        | A previous update was not completed. Run the update again to finish it.                                                                                                                                                               |
| ![](attachments/2327307/2327336.png)              | Root              | Directory is either the project root or an external root.                                                                                                                                                                             |
| ![](attachments/2327307/2327335.png)       | Nested Root       | Directory is a nested working copy root, but no external. Refer to the [Fix command](Fix.md#Fix-commands.fix) .                                                                                                             |
| ![](attachments/2327307/2327342.png)        | Obstructed        | A file exists locally, but according to the pristine copy (i.e. the information from the repository) it should be a directory. Please backup the file, then remove it and update the directory from the repository.                   |
| ![](attachments/2327307/2327343.png)           | Phantom           | The directory neither exists locally nor is versioned, but is still present in the working copy metadata (.svn directory). It's probably part of a [tree conflict](Mark-Resolved.md#tree-conflicts) . |
| ![](attachments/2327307/2327338.png)            | Remote            | Directory only exists in the repository. This state is only used for the remote state command (see [Remote State](Remote-State.md#RemoteState-commands.remote-state)).                                                      |
| ![](attachments/2327307/2327337.png)         | Unscanned         | Directory has not been scanned yet (see [Refresh](Refresh.md#Refresh-commands.refresh)).                                                                                                                                    |


### Additional Directory States


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |                         |                                                                                                                                                                                  |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327307/2327351.png)        | Switched                | Directory is switched (compared to its parent); see [Switch](Switch.md#Switch-commands.switch).                                                                        |
| ![](attachments/2327307/2327354.png)          | Locked                  | Directory is locked *locally* because an operation has been interrupted before. A [Cleanup](Clean-Up.md#CleanUp-commands.clean-up) should fix the problem.             |
| ![](attachments/2327307/2327359.png)    | Direct Local Changes    | There are local changes to this directory itself.                                                                                                                                |
| ![](attachments/2327307/2327353.png)  | Indirect Local Changes  | There are local changes to one of its files or to one of the subdirectories of this directory.                                                                                   |
| ![](attachments/2327307/2327355.png)   | Direct Remote Changes   | There are remote changes to this directory itself, see [Remote State](Remote-State.md#RemoteState-commands.remote-state).                                              |
| ![](attachments/2327307/2327356.png) | Indirect Remote Changes | There are remote changes to one of its files or to one of the subdirectories of this directory, see [Remote State](Remote-State.md#RemoteState-commands.remote-state). |
| ![](attachments/2327307/2327352.png)   | Tree Conflict           | The directory is part of a *tree-conflict*, see [Tree Conflicts](Mark-Resolved.md#tree-conflicts) for details.                                   |


To *speed search* the directory tree for a certain directory, click into
the tree (so the **Directories** view becomes active) and start typing
the directory name. This will make a small popup come up, which displays
the characters you have already entered. Wildcard symbols '\*' and '%'
can be used with the usual meaning.

## File States/File Table

The file table shows the project's files with their SVN states and
various additional information. The primary file states are listed in
[Primary File States](#common-primary-file-states). Every
primary state may be combined with additional states listed in
[Additional File States](#additional-file-states). The
rest of this section explains configuration options for the file table.
They are always related only to the current project and are also stored
with the current project.

### Name Filters

The toolbar of the file table contains the **Filter** input field, which
can be used to restrict the displayed files to a certain file name
pattern. By default, simple patterns, including the wildcard symbols
'\*' and '%', are supported. You can also use '!' at the beginning of a
pattern to invert it. For example, '!\*.txt' will show all files which
don't have the .txt extension.

To clear the **Filter** field, click on the button on the right side of
the field. In the drop-down menu on the left side of the **Filter**
field, you can select **Regular Expressions** instead of simple
patterns. For details on the supported regular expression constructs
refer to
<http://java.sun.com/j2se/1.5.0/docs/api/java/util/regex/Pattern.html>.
With **Save Pattern** you can save a pattern. Once a pattern is saved it
will be displayed in the top of the drop-down menu. It can be used by
selecting it and removed again by **Remove Pattern**.

Similar to the directory tree, the speed search is also available for
the file table.

### Common Primary File States


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |                            |                                                                                                                                                                                                                                                         |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327307/2327312.png)                   | Unchanged                  | File is under version control, not modified and equal to its revision in the repository (i.e. to its pristine copy).                                                                                                                                    |
| ![](attachments/2327307/2327308.png)                 | Unversioned                | File is not under version control, but only exists locally.                                                                                                                                                                                             |
| ![](attachments/2327307/2327324.png)                     | Ignored                    | File is not under version control (exists only locally) and is marked as to be ignored.                                                                                                                                                                 |
| ![](attachments/2327307/2327318.png)            | Modified                   | File is modified in its content but not in its properties (compared to its revision in the repository, i.e. to its pristine copy).                                                                                                                      |
| ![](attachments/2327307/2327319.png)         | Modified (properties only) | File is modified in its properties but not in its content (compared to its revision in the repository, i.e. to its pristine copy).                                                                                                                      |
| ![](attachments/2327307/2327317.png) | Modified (properties only) | File is modified in its content and properties (compared to its revision in the repository, i.e. to its pristine copy).                                                                                                                                 |
| ![](attachments/2327307/2327316.png)                     | Missing                    | File is under version control, but does not exist locally.                                                                                                                                                                                              |
| ![](attachments/2327307/2327333.png)                       | Added                      | File is scheduled for addition.                                                                                                                                                                                                                         |
| ![](attachments/2327307/2327310.png)                     | Removed                    | File is scheduled for removal.                                                                                                                                                                                                                          |
| ![](attachments/2327307/2327311.png)                    | Replaced                   | File has been scheduled for removal and was added again.                                                                                                                                                                                                |
| ![](attachments/2327307/2327322.png)                      | Copied                     | File has been added with history.                                                                                                                                                                                                                       |
| ![](attachments/2327307/2327323.png)           | History-Scheduled          | A parent directory has been added with history, which implicitly adds this file with history.                                                                                                                                                           |
| ![](attachments/2327307/2327309.png)                      | Remote                     | File does not exist locally, but only in the repository. This state is only used for the remote state (see [Remote State](Remote-State.md#RemoteState-commands.remote-state)).                                                                |
| ![](attachments/2327307/2327328.png)                    | Conflict                   | An update command lead to conflicting changes either in content or in properties.                                                                                                                                                                       |
| ![](attachments/2327307/2327321.png)                      | Merged                     | The file has been merged. Refer to the [Merge command](Merge.md#Merge-commands.merge) for details.                                                                                                                                            |
| ![](attachments/2327307/2327320.png)                  | Incomplete                 | A previous update was not completed. Run the update again to finish it.                                                                                                                                                                                 |
| ![](attachments/2327307/2327313.png)               | Name conflict              | There exists another file in the repository with the same name, only differing in upper/lower case. Such files can't be checked out on case-insensitive file systems. To fix this problem the corresponding files have to be renamed in the repository. |
| ![](attachments/2327307/2327314.png)                  | Obstructed                 | A directory exists locally, but according to the pristine copy (i.e. the information from the repository) it should be a file. Please backup the contents of the directory, then remove it and update the file from the repository.                     |
| ![](attachments/2327307/2327325.png)                | Inaccessible               | The file's content is not accessible, hence its state (modification) can't be determined. It's probably locked by another application.                                                                                                                  |
| ![](attachments/2327307/2327315.png)                     | Phantom                    | The file neither exists locally nor is versioned, but is still present in the working copy metadata (.svn directory). It's probably part of a [tree conflict](Mark-Resolved.md#tree-conflicts) .                        |
| ![](attachments/2327307/2327327.png)                | Case-Changed               | The case of the file name has changed on an operating system that is case-insensitive with respect to file names. Refer to the [Fix command](Fix.md#Fix-commands.fix) on how to handle such files.                                            |


### Additional File States


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |               |                                                                                                                                           |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327307/2327331.png)      | Switched      | File is switched (compared to its parent directory); see [Switch](Switch.md#Switch-commands.switch).                            |
| ![](attachments/2327307/2327326.png) | Tree Conflict | The file is part of a *tree-conflict*, see [Tree Conflicts](Mark-Resolved.md#tree-conflicts) for details. |


### 'Lock' column states


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |                |                                                                                                                                                                           |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327307/2327330.png)  | Locked (Self)  | The file is locked in the repository by yourself (or more specifically, it is locked for the current working copy). See [Locks](Locks.md#Locks-commands.locks). |
| ![](attachments/2327307/2327329.png) | Locked (Other) | The file is locked in the repository by some other user, see [Locks](Locks.md#Locks-commands.locks).                                                            |
| ![](attachments/2327307/2327334.png) | Lock Necessary | The file needs to be locked before starting to work, see [Change 'Needs Lock'](Locks.md#change-needs-lock).                                      |


## State Filters

With the menu items in the **View** menu, you can also set filters to
display only files which meet certain criteria. Refer to the [View menu](Menus.md#view) for details.
The filter behavior can be customized in the Preferences with **Hide
ignored and repository-only directories according to View-menu filters**
on the **User Interface** page.

## Double Click

By default, if you double-click on a file in the file table, the file
will be 'opened' in one of several ways, depending on its file state:

-   For an *unchanged* file which is *remotely changed* (see [Remote State](Remote-State.md#RemoteState-commands.remote-state)),
    the **Compare with HEAD** command is invoked.
-   An *unchanged*, *unversioned* or *added* file is opened with the
    file editor, see the **Query\|Open** command
    ([Query](Menus.md#query)) for
    further details.
-   A *conflicting* file is opened with the Conflict Solver ([Conflict Solver](Conflict-Solver.md#ConflictSolver-conflict-solver)).
-   All other files are opened by comparing them (**Show Changes**).

If, for example, you want to always *open*
([Edit](Menus.md#edit)) the file
independent of its state by double-clicking it, assign the
*\<Enter>*-keystroke accelerator ([Preferences](Preferences.md)) to the
**Query\|Open** menu item.


