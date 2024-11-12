# Tracing the modified state of a file

When the reason for the **modified** state of a specific file is
unclear, following procedure allows to debug details for this file.

### Compare with git status

Give `git status` a try and see whether the same modification is present
there. If so, you may still run through this procedure, but likely the
answer to this question is found elsewhere (reason may be a wrong
`.git/config`, EOL-related issues or [Git-LFS issues](#git-lfs-issues)).

If invoking `git status` does not show the same modification or even
resets the modification in SmartGit, the resulting debug information
should be sufficient to understand the difference between SmartGit's
status detection and Git's status.

### Procedure

-   Shutdown SmartGit.

-   Add `smartgit.statusscanner.trace`=\<relative-path>
    to [smartgit.properties](../Latest/System-Properties.md)
    (in the settings directory, see About dialog).  
    `<relative-`path> is the repository-relative path of the file for
    which the modification should be traced. On Windows, also replace
    backslashes by forward slashes.


	#### Example
	> On Windows, for example for file `C:\vss\Project\FOO\bar\file` with
	> repository root `C:\vss\Project`, you should add line:
	> 
	> `smartgit.statusscanner.trace`=FOO/bar/file



-   Get rid of the `log` directory inside the settings directory.

-   Restart SmartGit.

-   Open the offending repository and wait until the Refresh has
    finished and the modified file is showing up.

-   Make sure the files inside the `log` directory contain debug lines
    for the `smartgit.status.index` category.  
    You may use `grep "smartgit.status.index" log.txt*` to find out.

-   ZIP the `log` directory and send to `smartgit@syntevo.com`, together
    with an explanation of the problem.

### Git-LFS Issues

If executing `git status` also shows the files as modified, try invoking `git lfs status`:

```
$ git lfs status
On branch master
Objects to be pushed to origin/master:


Objects to be committed:


Objects not staged for commit:

        _img/screenshots/android_auto/de/11_android_auto_map.png (Git: 0731d28 -> File: 0731d28)
...
```
Then [this stackoverflow article](https://stackoverflow.com/questions/46704572) might help you.
