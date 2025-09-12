# Moving, Renaming and Deleting Files
In general, changes to file locations or file names, and removing a file from the repository is done the same way as any other staging operation.
However, there are some additional considerations.

## Remove
Use **Local \| Remove** to remove files from the local repository and optionally to delete them in the working tree.

If the local file in the working tree is already removed, [staging](Stage-Unstage-IndexEditor.md#stage-unstage-and-the-index-editor) the file deletion will have the same effect, however, the Remove command also allows you to remove files from the repository while keeping them locally.

#### Tip
> If you remove a file from a repository but wish to keep the file in your local *Working Tree*, you should consider ignoring the file in order to prevent it from being accidentally re-added to the repository in a future commit.

## Moving/Renaming Files

In general, Git's move/rename tracking happens automatically based off the content similarities in a file, e.g. when logging or blaming a file, the move/rename operation will be detected and changes to the file can be tracked before and after the move/rename.

As a result, there is no need for an explicit *move* operation: just move your files with your favorite tools (IDE, file explorer, from command line).

However, Git does possess a `git move` command for convenience which performs a normal file system move and then stages the removed and the newly added file to the *Index*.
Due to demand from users for access to the Git `move` operation, SmartGit provides **Local \| Move or Rename**.

#### Note
> It is recommended not to make major changes to the contents of a file in the same commit as a move/rename on the file, as this may cause Git to be unable to follow the file through the rename.
> Consider instead splitting the content changes, and the move/rename into two distinct commits.

## Delete

Use **Local \| Delete** to delete local files (or directories) from the working tree.
You either may permanently delete the files directly, or move them to the trash (operating-system specific, e.g. the recycle bin on Windows).
