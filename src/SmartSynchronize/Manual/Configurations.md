# Configurations

SmartSynchronize has different types of configuration: *preferences*, *view settings* and *directory compare settings*.
View settings define how the editors of the current file compare or file merge window should compare or display something.
[Directory compare settings](Directory-compare.md#settings) define how the directory compare of the current window should perform the comparison and what files or directories should be ignored.
Preferences apply to the whole applications and contain default view settings as well as default directory compare settings.
Preferences you usually have to configure one time, but view settings might be changed for different viewed file types and directory compare settings for different directory compares.

## Preferences

On macOS you can open the preferences dialog from the application menu.
On other operating systems, you can open it from the Welcome dialog or with the **Edit\|Preferences** menu item from the *File Compare*, *Directory Compare* and *File Merge* windows.

### Text Editors

On the *Font* tab you can define the font which should be used in the compare and merge text editors.
Note, that only fixed-size fonts can be choosen.

On the *Colors* tab you can define the foreground and background colors which should be used in the compare and merge text editors.

On the *Editor* tab you can customize the behaviour of different keyboard commands.

After clicking **OK** these changes will be applied to all open compare or merge windows.

### Directory Compare Defaults

On this card you can define the defaults which are used for new directory compares.
Please refer to the [Directory Compare Settings](Directory-compare.md#settings) for detailed description.

### Accelerators

Use this card to customize the accelerators of the compare and merge windows.
Double click the menu item row, press the key combination and click the **Assign** button.
To remove an assigned accelerator, e.g. because you want to reuse it for a different menu item of the same window, click the **Clear** button.
To get the original accelerator, click the **Reset** button.

### Check for Update

Select the option "Automatically check for available updates" if SmartSynchronize should check daily for new SmartSynchronize updates on the syntevo.com-website.


## View Settings

Depending on the window, the view settings can be changed with different menu items.
Use the menu item **View\|Settings** in the File Compare and File Merge windows.
Use the menu item **Preview\|Settings** in the Directory Compare window.

On the *General* card, you can define the tab size, whether whitespaces or line numbers should be shown.
On the *Compare* card, define whether changes in whitespace should be ignored, whether and how to detect inner-line changes.
Select the option *Store as default* to remember the settings as default for new opened windows.
