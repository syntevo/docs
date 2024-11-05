# Ignore

Use **Modify\|Ignore** to mark unversioned files or directories as to be
ignored 'locally'. This is useful for files or directories which should
not be put under SVN control. These are usually temporary, intermediate
or automatically generated files, like *C*'s `.obj` or *Java*'s `.class`
files, or directories containing such files.

*Local ignore patterns* are stored within the working copy (in the
*svn:ignore* property of the corresponding parent directories) and will
be committed. Therefore, to have a file locally ignored, its parent
directory must either be ignored as well, or be versioned, so that the
necessary *svn:ignore* property can be stored there. Hence, when trying
to ignore a file or directory within another unversioned directory,
SmartSVN will ask you to add this parent directory. In addition to
*local ignore patterns*, you can configure *global ignored patterns* in
the [project settings](Project-Settings.md#ProjectSettings-project.settings)
.

You can select **Ignore Explicitly** to add each selected file/directory
explicitly to the ignore list. If SmartSVN detects a common pattern for
the selected files/directory, it will also allow you to **Ignore As
Pattern**.

This command is a shortcut for editing the *svn:ignore* property
directly by by **Properties\|Ignore Patterns**. Refer to [Ignore Patterns](Ignore-Patterns.md#IgnorePatterns-commands.ignore-patterns)
for details.
