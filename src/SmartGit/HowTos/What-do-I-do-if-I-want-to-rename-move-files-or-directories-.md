# What do I do if I want to rename/move files or directories?

If you've been using SVN before trying out Git, you might wonder what
you should do to properly rename or move files and directories in your
Git repository. The answer is that you can simply rename or move them.
This is due to the fact that Git handles renaming and moving quite
differently from SVN:

-   **SVN** In SVN, you have to explicitly mark renames and moves as
    such, otherwise SVN will think you've created a new file/directory.
-   **Git** In Git, you just rename or move your files/directories, and
    later Git will automatically detect renames. For details, refer to
    [Local Operations on the Working Tree](../Latest/Local-Operations-on-the-Working-Tree.md).
