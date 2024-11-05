# Merge Preview

The *Merge Preview* is the result of a [Merge command](Merge.md#Merge-commands.merge) invoked from the
[Project Window](Project-Window.md#ProjectWindow-project-window) . It
shows a **Directories/Files** structure of which files and directories
will be affected by the merge.

For every file, the table shows the corresponding **Name** and its
**Relative Directory**, according to the merge root. **State** shows the
merge state for the file, either *Modified*, *Added*, *Removed*,
*Unchanged* or *Skipped* For *Modified* files, both the **Content** and
the **Properties** can be either *Conflicting*, *Modified* or
*Unchanged*. *Skipped* files can't be processed by the merge, e.g.
because they have been renamed or moved in the merge source, i.e. the
local working copy.
