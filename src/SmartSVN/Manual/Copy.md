# Copy

Use **Modify\|Copy** to create a copy of a file or directory which is
already under SVN control. This command will preserve the history of the
copied item.

Select the **Target Directory** under which the copy of the
file/directory will be created, and specify the **New Name**.

There is also a special mode of this command that can be used to tell
SmartSVN 'after the fact' that a file was copied. For this to work,
exactly two files must be selected: One that is versioned, but not added
or replaced, and another that is unversioned, added or replaced.
SmartSVN will then add the unversioned file (if necessary) and connect
the history of the added file to that of the other file.


#### Tip
>
>
>You can also use Drag-And-Drop to copy or move files and directories.
>
>
