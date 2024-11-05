# Remote State

The remote state shows the files' repositories states compared to the
local working copy. It can also be interpreted as the action that would
happen when updating the working copy to HEAD (see
[Update](Update.md#Update-commands.update)). The remote state
of files is displayed in the file table column **Remote State**, the
remote state of directories is displayed in the tooltip for a directory.
See [Remote State Types](#remote-state-types) for the list of
possible remote states of files and directories.

To display the complete remote state information, especially the 'Will
be added ' state, it may be necessary to add directories and files that
do not exist locally to the directory tree or the file table. To such
directories and files the special local state 'Remote' is assigned, see
[Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states)
and [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states).

## Remote State Types


|            |                                                                                                                                     |
|------------|-------------------------------------------------------------------------------------------------------------------------------------|
| Unchanged  | The local entry is equal to the latest revision of this entry in the repository. An update on this entry will bring no changes.     |
| Modified   | For the local entry there exists a newer revision in the repository. An update will bring the corresponding changes for this entry. |
| Removed    | The local entry has been removed in the repository. An update will remove the entry locally.                                        |
| Added      | This entry does not exist locally, currently in a versioned state. An update will add this entry.                                   |
| Obstructed | For the local entry the latest repository revision contains another entry for being added. An update will fail here.                |


## Refresh Remote State

With **Query\|Refresh Remote State** SmartSVN will query the repository
and compare the latest repository revision with your local working copy.
In this way, to each file and directory the corresponding remote state
is assigned and displayed in the **Remote State** column; it will be
made visible, if necessary.

**Refresh Remote State** can be combined with the local Refresh and the
[scanning for locks](Locks.md#refresh) in
the Preferences to have the Remote State automatically refreshed.

If problems during the Remote State refresh are encountered, the [status bar](Project-Window.md#user-interface) will
display an **Error** in the *Refresh* area. The tooltip for this area
will show more details regarding the encountered problem.

## Clear Remote State

Use **Query\|Clear Remote State** to clear and hide the remote state.
This will remove all directories and files which have the local state
'Remote' (see [Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states)
and [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states))
and hide the **Remote State** file table column.
