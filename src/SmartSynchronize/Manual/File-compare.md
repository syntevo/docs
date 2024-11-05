# File Compare

To compare or synchronize two files, use the File Compare.
You can start it either from the Welcome dialog, by double-clicking a file in the Directory Compare window or by passing the target file paths as command line parameters.
If you pass one file and a directory path as command line parameters, SmartSynchronize tries to compare the specified file and the file with the same name in the specified directory.

The File Compare displays the files left to right.
At the outer left and right borders the changes are marked with colors.
Clicking there with the left mouse button centers the corresponding change within the text editors.
Between the two file editors, the changes are linked with colored areas.
There you will also find small buttons which allow to synchronize the particular change block from one to the other file.
You also can use the menu items **Edit\|Take Left Block**, **Edit\|Take Right Block**, their accelerators (shortcuts) or their toolbar buttons.
To apply individual inner-line changes, right click at the change and select **Apply Left** or **Apply Right**.
With **Go To\|Next Difference** and **Go To\|Previous Difference** (or their accelerators and toolbar buttons) you can navigate from change to change.
To create a colored HTML file showing the two compared files as they occur on the screen, use **File\|Export as HTML-File**.

To configure the tab size, whether linenumbers or whitespaces should be displayed, use the menu item **View\|Settings**.
For detailed option description, please refer to [View Settings](Configurations.md#view-settings).

Use **Edit\|Set Left Encoding** or **Edit\|Set Right Encoding** to set the encoding used to read and write the corresponding text file.

Use **File\|Refresh** if the files have changed on disk and you want to reload them.
If you have made changes to the files, you will be asked whether to store them.
