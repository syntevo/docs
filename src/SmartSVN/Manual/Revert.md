# Revert

Use **Modify\|Revert** to revert the local changes of the selected
files/directories. In case of directories you have the option to
**Revert Recursively** (i.e. to recurse into subdirectories). If
deselected, only the properties of the directory itself will be
reverted.

-   Added and copied files/directories will be unscheduled for addition
    and returned to unversioned state.
-   Removed files/directories will be unscheduled for removal and
    restored with their content and properties taken from the pristine
    copy.
-   Replaced files/directories will be unscheduled for replacement and
    restored with their content and properties taken from the pristine
    copy.
-   Modified files/directories will be restored with their content and
    properties taken from the pristine copy (overwriting local
    changes!).
-   Missing files will be restored with their content and properties
    taken from the pristine copy. Missing directories can't be restored,
    because the pristine copy is also missing. You have to freshly
    [Update](Update.md#Update-commands.update) them from the
    repository.
-   Conflicted files/directories will be restored with their content and
    properties taken from the pristine copy (ignoring local changes
    which caused the conflict!).
-   For Case-changed files their original file names will be restored
    and modifications in contents/properties will be reverted.


#### Warning
>
>
>Be careful before reverting a file or directory as all local
>modifications will be lost.
>
>
