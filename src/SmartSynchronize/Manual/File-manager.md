# File Manager

To create, copy, move, delete files or directories, use the File Manager.
The File Manager comes as a keyboard-usage oriented dual-pane flavor where either the left or right side can be source or target of the file operation.

## Navigation

With **Tab** you can switch between the left and right view.
Use the cursor keys for navigation.
The `..` directory means the parent directory.
**Left** moves a directory level up, **right** moves into the selected directory or dives into an archive.
If the `7z` executable is configured, this works even for self-extracting archives.
With the **Enter** key on a file the first matching command from the Tools section in the preferences will be executed.

Above each pane, there are 3 buttons and the path shown.
The left-most button allows to quickly select drives (Windows) or partitions (macOS, Linux), as well as *favorite* directories.
The next two buttons allow to access the directory history - a long click will show a popup.
Click on a part of the shown path to quickly go to this (grand) parent directory.

Another way of quickly accessing directories you already have navigated to, is to **Ctrl/Cmd+P** and start typing parts of the directory name.

You can configure favorite directories in the preferences.
Those you can quickly select in the **Directory\|Change Left/Right Path** popup.
If the name of the favorite has a leading letter or digit followed by a space, you can switch to that path quickly without the popup by pressing **Ctrl/Cmd+<letter/digit>**.
On Windows you can change drives by pressing **Ctrl/Cmd+<drive letter>**.
Note, that favorite names have precedence over drives.

## Sorting

In the [Preferences](Preferences.md) you can configure whether sub directories will be sorted like normal files or always shown before the files (default).
SmartSynchronize can remember different sortings for different directories, and one default sorting.
For example, it makes sense to keep the `Downloads` directory sorted by *Last Modified Time*, so newly downloaded files show up at the top, while for nearly all other directories sorting by *Name* or *Extension* might be more appropriate.

Use the **View** menu options to change the sorting of a path.
Select **View\|Remember Sorting for This Path** to remember the sorting for the current path.
Changing the sorting for a remembered path will update the remembered sorting automatically.
If **View\|Remember Sorting for This Path** is not selected, the default sorting is used.
To remember the default sorting, select **View\|Remember Sorting Now**.

## Viewer

**F3** opens a simple file viewer.
For text files, common encodings like UTF-8 (with or without BOM) or UTF-16 are detected.
Alternatively, a hex viewer is available for binary content.
If text viewer is active, you can search or use the mouse to select and copy text.

## Editor

**F4** searches the *editor tools* configured in the preferences for the first one matching the file name.
This means, it is very easy to configure a different editor for graphic files, e.g. `*.png`, than for text files.

## Tools

Even more flexible it is to configure several external tools.
They can work on selected files or directories, or simply be used to launch another application.
Some common features, e.g. *Reveal in Explorer* or *Open Terminal*, are configured this way in the preferences allowing tweaking of the invoked command.
The configured tools are shown in the **Commands** menu.
Those tools, that apply to files, are also shown in the context menu of each file panel.
