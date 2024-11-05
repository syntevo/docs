# Why are my files/directories not shown?

If some of your files or directories are not showing up on the file table in the main window, check your settings in the filter component on the top right of the file table:

![](attachments/6979741/6979742.png)

The buttons on the right of the filter component control the visibility of various types of files and directories.
For instance, you can toggle the visibility of ignored files and directories (i.e. files and directories that match the rules specified in your `.gitignore`) by changing the selection state of the right-most button of the filter component.

If a file is is shown as ignored and you wonder why, use **Local\|Edit Ignore File** to see the ignore files and which one is matching (that you then can edit).

#### Note
> For performance reasons SmartGit does not scan into directories that are ignored.
