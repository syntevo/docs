# The Index

The *Index* is an intermediate cache for preparing a commit. With
SmartGit, you can make heavy use of the Index, or ignore its presence
completely - it's all up to you.

The **Stage** command allows you to save a file's content from your
working tree in the Index. If you stage a file that was previously
version-controlled, but is now missing in the working tree, it will be
marked for removal. If you select a file that
has Index changes, invoking **Commit** will give you the option to
commit all staged changes.

If you have staged some file changes and later modified the working tree
file again, you can use the **Discard** command to either revert the
working tree file content to the staged changes stored in the Index, or
to the file content stored in the repository (HEAD).

When *unstaging* previously staged changes, the staged changes will be
moved back to the working tree, if the latter hasn't been modified in
the meantime, otherwise the staged changes will be lost. In either case,
the Index will be reverted to the HEAD file content.

## Changes view

The **Changes** view of the SmartGit Working Tree window can show the changes
between the HEAD and the Index, or between the Index and the working
tree state of the selected file. You can switch between both views
either by clicking the left *HEAD* button or the right *Working Tree*
button. The detected and expected line separators are shown in the
Changes view title. Individual change hunks or inner-line changes can be
staged and unstaged there (if the line separators are not *mixed*).

## Index Editor

The Index Editor shows a 3-pane-view of HEAD, Index and the Working
Tree. The Index and the Working Tree state of a file can be edited
freely, e.g. to add further modifications to the Index which are not
available in the Working Tree.
