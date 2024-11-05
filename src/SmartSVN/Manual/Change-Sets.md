# Change Sets

A Change Set is a group of committable files and directories, with a
message assigned. Subversion itself supports *Changelists* which
currently can contain only files. SmartSVN automatically synchronizes
the files of a Change Set with the corresponding SVN changelist. Change
Sets are also known as 'prepared commit' in other version control
systems.

Change Sets are displayed in the [Directory Tree](Directory-Tree-and-File-Table.md#DirectoryTreeandFileTable-mainwindow.filetable)
below the normal project directory structure. [Change Set icons](#change-set-icons) shows the icons which are used for
Change Set directories.

You can create a Change Set by selecting the files/directory to assign
to the Change Set and invoking **Change Set\|Move to Change Set** ([Move to Change Set](#move-to-change-set)). You can use the
same menu item to add more committable files/directories to the Change
Set, to move the selected files/directories to a different Change Set or
to remove files/directories from a Change Set. When you are ready to
commit, you can simply select the Change Set in the directory structure
and invoke **Modify\|Commit**
([Commit](Commit.md#Commit-commands.commit)).

When the project directory structure is selected (as opposed to a Change
Set), deactivating **View\|Files Assigned to Change Set** ([Directory Tree and File Table](Directory-Tree-and-File-Table.md#DirectoryTreeandFileTable-mainwindow.filetable))
will give a better overview of changed files not already assigned to a
Change Set.


#### Note
>
>
>A file/directory can only be assigned to one Change Set.
>
>

## Change Set icons


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |                                                                                                                                                                                                                      |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327417/2327418.png) | Change Set root node                                                                                                                                                                                                 |
| ![](attachments/2327417/2327419.png)   | Change Set root node, which contains the modified project root directory                                                                                                                                             |
| ![](attachments/2327417/2327420.png)        | A *virtual* Change Set directory, which does not represent an actual project directory, but is necessary to display child directories and files.                                                                     |
| (various)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | A Change Set directory which represents (or is equal to) the corresponding project directory, see [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states). |


## Move to Change Set

Use **Change Set\|Move to Change Set** to change the assigned Change Set
of selected, committable files/directories.

To move the selected files/directory to a new Change Set, select **New
Change Set** and enter the **Message** of the new Change Set. Select
**Remove this Change Set once it gets empty** to automatically remove
this Change Set once it gets empty. Select **Allow only committable
entries** to automatically remove *unchanged* and other non-committable
entries from Change Sets.



#### Example
>
>
>
>When having **Remove this Change Set once it gets empty** and **Allow
>only committable entries** selected, the Change Set will be
>automatically removed after committing it because
>
>-   the committed files will turn their state into *unchanged* after the
>    commit and hence will be removed from the Change Set and
>-   the Change Set will be empty and hence will be removed itself.
>
>

To move the selected files/directory to another, already existing Change
Set, select **Existing Change Set** and choose the **Target Change
Set**.

To remove the selected files/directory from their currently assigned
Change Set, select **Remove from Change Set**.


#### Tip
>
>
>You can use Drag-and-Drop to move files to a Change Set.
>
>

## Move Up

Use **Change Set\|Move Up** to move the selected Change Set one position
up (when having multiple Change Sets).

## Move Down

Use **Change Set\|Move Down** to move the selected Change Set one
position down (when having multiple Change Sets).

## Delete

Use **Change Set\|Delete** to delete the selected Change Set. This will
only affect the Change Set assignment, not the files nor their SVN
state.

## Edit Properties (Change Set)

Use **Change Set\|Edit Properties** to change the **Message** and other
properties of the selected Change Set. For details, refer to [Move to Change Set](#move-to-change-set).


