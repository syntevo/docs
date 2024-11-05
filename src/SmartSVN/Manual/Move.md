# Move

Use **Modify\|Move** to move and/or rename a file or directory which is
already under SVN control. The file with the old name will be scheduled
for removal, the file with the new name for addition. This command will
preserve the history of the moved item.

There is also a special mode of this command that can be used to tell
SmartSVN 'after the fact' that a file was moved. For this to work,
exactly two files must be selected: One that is missing or removed, and
another that is unversioned, added or replaced. SmartSVN will then
remove the missing file (if necessary), add the unversioned file (if
necessary), and connect the history of the added file to that of the
removed file.


#### Tip
>
>
>You can also use Drag-And-Drop to copy or move files and directories.
>
>
