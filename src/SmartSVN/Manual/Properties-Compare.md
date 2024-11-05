# Properties Compare

The *Properties Compare* window shows the properties of two files or
directories, one in the left and one in the right area of the window. A
Properties Compare is typically invoked together with a [File Compare](File-Compare.md#FileCompare-file-compare) , e.g. by
**Query\|Show Changes** from the [Project Window](Project-Window.md#ProjectWindow-project-window) .

The table displays all properties of both files/directories with their
**Name**, **State**, **Old Value** and **New Value**. **Old Value**
corresponds to the value of the first file/directory and a **New Value**
corresponds to the value of the second file/directory. When the
properties compare has been invoked for a versioned file or directory,
*old* refers to the pristine copy of the file/directory and *new* refers
to the working copy file/directory. The **State** column shows the
property's state, either **Modified**, **Added**, **Removed** or
**Unchanged**. The **Name** column renders the property's state by using
different colors, similar to the [File Compare](File-Compare.md#FileCompare-file-compare) .

The lower area of the dialog shows the differences between **Old Value**
and **New Value** for the currently selected property, similar to the
[File Compare](File-Compare.md#FileCompare-file-compare).
