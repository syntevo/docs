---
redirect_from:
  - /SmartGit/Latest/The-Index
  - /SmartGit/Latest/The-Index.html
---
# The Index

The *Index* is an intermediate cache for preparing a commit by identifying which file changes (including new and deleted files) you'd like to include in your next commit. 

With SmartGit, you have the option to view the details of the Index, or, if you prefer simplicity, SmartGit can automatically manage the Index for you, allowing you to ignore its presence completely - it's all up to you.

The **Stage** command allows you to save a file's content from your
working tree into the Index. If you stage a file that was previously
version-controlled but is now missing in the working tree, it will be
marked for removal. If you select a file with Index changes, invoking **Commit** will give you the option to
commit all staged changes.

If you have staged some file changes and later modify the working tree
file again, you can use the **Discard** command to either revert the
working tree file's content to the staged changes stored in the Index or
to the file content stored in the repository (HEAD).

When *unstaging* previously staged changes, the staged changes will be
moved back to the working tree, if the latter hasn't been modified in
the meantime; otherwise, the staged changes will be lost. Either way,
the Index will be reverted to the HEAD file content.

## Changes view

The **Changes** view of the SmartGit Working Tree window can show the differences
between the HEAD and the Index, or between the Index and the working
tree state of the selected file. You can switch between both views
either by clicking the left **HEAD** button or the right **Working Tree**
button. The detected and expected line separators are shown in the
Changes view title. Individual change hunks or inner-line changes can be
staged and unstaged there (if the line separators are not *mixed*).

## Index Editor

The **Index Editor** shows a three-pane-view of HEAD, the Index, and the Working
Tree. The Index and the Working Tree states of a file can be edited
freely, for example, to add further modifications to the Index that are not
available in the Working Tree.
