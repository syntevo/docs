# Ignore Patterns

Use **Properties\|Ignore Patterns** to add, change or delete *local
ignore patterns* for a directory. *Local ignore patterns* define file
and directory patterns to be ignored within the directory.

*Local ignore patterns* are stored within the working copy (in the
*svn:ignore* property of the directory) and will be committed. Therefore
ignore patterns can only be applied to versioned directories.

By default, the **Patterns** are only set to the selected directory. You
may also choose to set the patterns to all subdirectories by **Recurse
into subdirectories**. In case of recursive ignore patterns, you may
alternatively consider to specify *global ignore patterns* within the
[project settings](Project-Settings.md#global-ignores)
.

To add an ignore pattern, you can also use the **Modify\|Ignore**
command.
