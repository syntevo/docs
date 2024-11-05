# Queries

SmartSVN offers following non-modifying commands -- some of them work
locally, others by querying the repository -- from the **Query** menu:

-   Use **Open** to open the selected file or directory with the
    configured editor, refer to Open (Preferences).
-   Use **Open in Repository Browser** to open the selected file or
    directory in the [Repository Browser](Repository-Browser.md).

 

-   Use **Show Changes** to compare the selected files or directory
    against their pristine copies. **Show Changes** will correspondingly
    open one or more [File Compare](https://www.syntevo.com/doc/display/SUWIP/File+Compare#FileCompare-file-compare)
    frames or the [Properties Compare](https://www.syntevo.com/doc/display/SUWIP/Properties+Compare#PropertiesCompare-properties-compare)
    for a directory. For details, regarding the warning limit on the
    number of files to compare at once, refer to Open (Preferences). No
    connection to the repository is required.

-   Use **Compare with HEAD** to compare a single, local file with the
    HEAD revision in the repository. If you want to compare against an
    arbitrary revision or some other repository file, use **Compare with
    Revision**. The result will be a [File Compare](https://www.syntevo.com/doc/display/SUWIP/File+Compare#FileCompare-file-compare)
    frame.

-   Use **Compare with Previous** to compare a single, local file with
    the last but one revision in the repository (i.e. the revision
    before HEAD). If you want to compare against the HEAD revision
    itself, use **Compare with HEAD**. If you want to compare against an
    arbitrary revision or some other repository file, use **Compare with
    Revision**. The result will be a [File Compare](https://www.syntevo.com/doc/display/SUWIP/File+Compare#FileCompare-file-compare)
    frame.


    Use **Compare 2 Files** to compare two local files with each other.
    No connection to the repository is required. When having one or more
    *missing* files selected, their pristine copies will be used for the
    comparison instead.


-   Use [Compare Repository Files or Directories](Compare-Repository-Files-or-Directories.md) to show the
    difference between two repository directories.

 

-   Use **Log** to display the Log (i.e. the commit history) of the
    selected file or directory. The Log command will open the [Log window](https://www.syntevo.com/doc/display/SUWIP/Log#Log-log).
-   Use **Query\|Revision Graph** to open the [Revision Graph](https://www.syntevo.com/doc/display/SUWIP/Revision+Graph#RevisionGraph-revision-graph)
    for the selected file or directory.
-   Use [Annotate](Annotate.md) to display contents of a file with each
    line prefixed by history information

 

-   Use **Create Patch** to create a 'Unidiff' patch for the selected
    files/directory. A patch shows the changes in your working copy on a
    per-line basis, which can for instance be sent to other developers.
    See [Apply Patch](https://www.syntevo.com/doc/display/SUWIP/Apply+Patch#ApplyPatch-commands.apply-patch)
    on how to apply patches with SmartSVN.  

    The patch will be written to the given local **Output File**. In
    case of creating a patch for a directory, you can select **Recurse
    into subdirectories** to create the patch recursively for all files
    within the selected directory.

    Select **Ignore changes in EOL-Style** to not output line changes
    for which only the line ending differs. This can be useful if, after
    having the line endings of a local file changed temporarily, only
    'relevant' changes should be included in the patch.

    With **For Whitespaces** you can configure to not output certain
    changes which are only affecting whitespaces. Use **No special
    handing** to do not ignore any changes regarding whitespaces. Use
    **Ignore changes in the amount** to ignore lines for which only
    blocks with one or more whitespace characters have been replaced by
    blocks with one or more other whitespace characters. Use **Ignore
    them completely** to output only lines where anything except
    whitespaces has changed.



    Use **Create Patch between URLs** to create a 'Unidiff' patch
    between two arbitrary URLs. See **Create Patch** for more details on
    patches. [Compare Repository Files or Directories](Compare-Repository-Files-or-Directories.md) is a version
    of this command that presents the results in a more human-friendly
    way.

    The patch is generated from one **Repository** and contains the
    difference between **From** and **To**. The patch will be written to
    the local **Output File**.

    By default, this command takes the ancestry into account, meaning it
    does not simply calculate (and print out) the difference between two
    files which have the same path, but also checks if both files are
    actually related. You can switch this behavior off by selecting
    **Ignore ancestry** on the **Advanced** page. For details regarding
    the other **Advanced** options, refer to **Create Patch**.


 


    Use **Query\|Export Backup** to export a backup of the selected
    files/directory.

    **Export** displays what will be exported. Depending on the
    selection of files/directory this will either be the number of files
    being exported or **All files and directories**. **Relative To**
    displays the common root of all files to be exported and the
    exported file's paths will be relative to this directory.

    You can either export **Into zip-file** or **Into directory**. In
    both cases, specify the target *zip* file or directory, and
    optionally choose to **Wipe directory before copying**.

    Select **Include ignored files** and/or **Include ignored
    directories** if you want to include the respective ignored items
    (and their contents) as well.


-   Use **Remove Empty Directories** to make all empty subdirectories of
    the currently selected directory as removed.


    Use **Conflict Solver** to start a *Three-Way-Merge*, which can be
    invoked on *conflicting* files (see [Common Primary File States](https://www.syntevo.com/doc/display/SUWIP/Directory+Tree+and+File+Table#common-primary-file-states)).
    For details, refer to [Conflict Solver](https://www.syntevo.com/doc/display/SUWIP/Conflict+Solver#ConflictSolver-conflict-solver).
    When invoking this command on a binary file, it will open the [Mark Resolved](https://www.syntevo.com/doc/display/SUWIP/Mark+Resolved#MarkResolved-commands.mark-resolved)
    dialog.


 

 
