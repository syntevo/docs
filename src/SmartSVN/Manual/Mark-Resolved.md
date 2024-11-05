# Mark Resolved

Use **Modify\|Mark Resolved** to mark conflicting files (see [Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states))
or conflicting directories (see [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states))
as resolved. You have to resolve conflicts to be able to commit the
files/directories.

In case of directories you have the option to **Resolve files and
subdirectories recursively**. If selected, all conflicting files and
directories within the selected directory will be resolved. Otherwise
only the property conflicts of the directory itself will be resolved.

Regarding the **File Content**, use **Leave as is** to apply no further
modifications to resolved files. Use **Take working copy** to replace
the contents of resolved files by their contents as they were before the
update/merge. Use **Take new** to replace the contents of resolved files
by the contents of their corresponding pristine copies as they are now
after the update/merge. Use **Take old** to replace the contents of
resolved files by the contents of their corresponding pristine copies as
they were before the update/merge.

## Tree Conflicts

Certain kinds of conflicts are not directly related to the content or
properties of a file (or directory) but to conflicting actions on a
file/directory. Such conflicts are called *tree-conflicts*.

Tree conflicts are similar to *normal* conflicts as conflicting
files/directories can't be committed before they have been resolved. The
[Local State](File-Attributes.md#FileAttributes-mainwindow.filetable.attributes)
column for files shows details for a tree conflict, if present. File and
directory tooltips display this information as well.



#### Example
>
>
>
>You have modified file `foo.txt` in your working copy. Your co-worker
>has renamed `foo.txt` to `bar.txt` and has committed this change. When
>updating from the repository, you will receive `bar.txt` but because of
>your local modifications to `foo.txt` this file will not be deleted, but
>re-scheduled as copied from itself (but the revision before the update).
>Furthermore, `bar.txt` will receive your local modifications of
>`foo.txt`. This represents a tree conflict. There are different kind of
>tree-conflicts, for a detailed analysis refer to:
><http://svn.collab.net/repos/svn/branches/1.6.x/notes/tree-conflicts/>
>
>
