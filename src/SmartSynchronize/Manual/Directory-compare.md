# Directory Compare

To compare two directory structures recursively or merge changed files between them, use the Directory Compare.
You can start it either from the Welcome dialog or by passing two directory names as command line parameters.

## Directory Compare Display

SmartSynchronize combines the content of both directory structures visually so they appear as one directory structure.
To the left the combined directory structure tree is displayed.
If a subdirectory is only available in the left or right directory structure, only the corresponding part of the icon is displayed.
If a directory icon is painted fully red, this directory contains modified, left-only or right-only files.
If only the back part of the directory icon is red, it contains at least on red subdirectory.



To the right you can see the files and their states.
By default, all files from subdirectories are displayed.
A partially red icon indicates a file which is only available in one directory structure.
The value in the *Changes* table column which is only shown for text files, displays the kind of detected changes.
`+9 -3 ~4`, for example, means 9 added, 3 removed and 4 changed lines, when you think of the older directory structure to the left and the newer one to the right.
If you want to see the detailed changes, double click the file to open the File Compare.

Use **Edit\|Synchronize Left to Right** or **Edit\|Synchronize Right to Left** menu items to synchronize the change of the selected file pairs to the other side.

#### Note
> This does not just copy files, but also creates new or deletes obsolete files, depending on the file's existence and the direction of the synchronization.

## Automatic Synchronization

To synchronize directory structures easily, use the menu item **File\|Synchronize**.
A dialog will open which lets you specify the time of the last synchronization (there is also an option to remember this date automatically) and shows suggestions how to copy or delete files.

The suggestions are based on the specified time of the last synchronization, the file existance and file times.
For example, if left and right files exist, the left file time is not later than the last synchronization time, but the right one is, the file will be copied from the right to the left.
If the left file is missing and the right one older than the last synchronization time, the right file will be deleted.

Be sure to verify the suggestions in the dialog before clicking **OK**!

## Settings

With **View\|Files From Subdirectories** and **View\|Unchanged Files** or the corresponding toolbar buttons, you can define what files should be shown.

With **File\|Settings** you can edit directory compare settings.
These settings will be stored with the profiles, so they can be different for different profiles.
In the [Preferences](Configurations.md#preferences) you can define their defaults.

### Compare

Select, whether SmartSynchronize should compare files by comparing the file contents or by comparing only the file sizes and modification times.
If the *Quick Compare* option is selected, SmartSynchronize optionally can skip files with modification times older than the specified number of days.

If *Inspect EOL for building change overview* is selected, SmartSynchronize will detect also files, which just differ by their line separators in the left or right directory, and displays the file state accordingly.
If *Evaluate line-based changes (in background)* is selected, SmartSynchronize will start a detailed analysis of the file content to display the count of added, removed and changed lines.

### Display

When option *Show Settings before Refresh*, these settings dialog will be shown before starting to (re)compare these directories.
When option *Display detailed state based on file time*, SmartSynchronize shows different file states (and file icons) for changed files, depending on whether the left file is newer than the right one or visa versa.

### File Filters and Directory Filters

When working with projects, they often contain files or directories which you don't want to synchronize, because they are of temporary nature or specific to the particular directory structure.
These are, for example, files with the extension `.obj` or `.class` or directories with version control information like `.git` or `.svn`.


For directories you can define include and exclude patterns.
Use the include patterns to cherry-pick only a few parts out of the directory structures.
With the exclude patterns you can define directories which should not be scanned.
For files you just can define exclude pattern for files which should be ignored.


To define a filter pattern, use the known wildcards '*' (zero or more arbitrary characters) and '?' (one arbitrary character).
If the pattern contains at least one slash, it will be tried to match with the file or directory *path* relative to the correspodning directory structure's root directory.
Otherwise it will be tried to match with the file or directory *name*.

#### Example
```
*.class
```
This pattern matches files (or directories) whose names end with the text ".class", e.g., `Foo.class` or `Bar.class`, but not `Foo.classes` or `Bar.txt`.


```
.*
```
This pattern matches files (or directories) whose name is starting with a period, e.g. `.classes`.
Those are considered hidden files on Unix based operating systems.


```
/*/foo/bar
```
This pattern matches files (or directories) in subdirectories whose path end with "/foo/bar" (or "\foo\bar"), but not the file or directory "/foo/bar" itself.

### File Encoding

Here you can define the text file encodings which should be used for the left and right directory structures.
By default the system encoding is used.
Changing these options can be necessary when comparing files from different operating systems (independent of the possible different line separators).

## Working with Profiles

If you need to compare or synchronize the same directory pairs multiple times, you can save them as a named profile, which can quickly be selected from subsequent directory comparisons.
When the directory compare is open, click **File\|Save Profile** and enter the name of the profile.
With **File\|Profile Manager** you can rename, delete or reorder your saved profiles.
