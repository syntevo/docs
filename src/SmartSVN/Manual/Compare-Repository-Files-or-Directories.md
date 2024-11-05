# Compare Repository Files or Directories

The *Compare Repository Files or Directories* frame shows the
**Directories/Files** differences between two repository directories, a
*From* directory and a *To* directory. It can be invoked from the
project window using **Query\|Compare Repository Files or Directories**.

For every file, the table shows the corresponding **Name**. The **Name**
column also shows the 'state' icon of the file (the same for
directories). Possible states are: **Added**, **Modified**, **Modified
(properties only)**, **Modified (content and properties)**, **Removed**
and **Unchanged**; they are always referring to the *modification* from
*From* to *To* directory. The corresponding icons can be found in
[Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states)
and [Rare Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states2).
The state name is displayed in the **Modification** column.

While the state displayed in the **Name** is a combination of file
content and properties, the **Content** column refers only to the state
of the content. The **Properties** column refers only to the state of
the properties; valid states for properties are **Modified** and
**Unchanged**. The **Relative Directory** displays the file's path
relative to the compare directory.

Use **Show Changes** to open a [File Compare](File-Compare.md#FileCompare-file-compare) which shows
the differences for the currently selected file between *From* and *To*
directory.

## Configuration dialog

The comparison is performed for one **Repository** between directories
**From** and **To**.

Select **Recurse into subdirectories** to compare not only the directory
and its immediate files itself, but also descend into subdirectories.
Regarding **Ignore Ancestry**, refer to [Create Patch between URLs](https://www.syntevo.com/doc/display/SUWIP/Create+Patch+between+URLs#CreatePatchbetweenURLs-commands.create-patch-between-urls).
