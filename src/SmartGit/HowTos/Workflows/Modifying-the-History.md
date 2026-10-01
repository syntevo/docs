# Modifying the History

This page gives an overview of the various ways in which you can use
SmartGit to modify your repository's history.


> [!WARNING]
> It is generally a bad idea to modify the *remote* history (i.e. to modify commits you have already pushed to remote repositories), since this may cause a lot of trouble for other people working in them.

## Modifying a commit message

The simplest scenario is modifying the commit message of a commit. To do so,
open the **Context Menu** on the selected commit in the **Graph View** and
choose **Edit Message...**.

## Modifying the contents of a commit

If the commit you want to modify is the last commit in your history, there
are two quick ways which allow you to make modifications on this commit in
addition to the other ways of modifying commits outlined further down.

-   **Amend**: When performing a commit (e.g. via **Local\|Commit** or
    by pressing the **Commit** button on the main toolbar), you may
    toggle the option **Amend last commit instead of creating new one**
    on the commit dialog. With this option, the new changes will be
    added to the last commit, instead of being committed as a new
    commit.
-   **Undo Last Commit**: With the menu entry **Local\|Undo Last
    Commit** you can undo the last commit. By doing so, you won't lose
    any changes: The commit's changes will be restored in the Index and
    working tree so you can edit and possibly re-commit them.

For any other commit, including the last commit in your history, there are
a number of tools you can use to make modifications.

-   **Modify**: Use this option from the context menu in the **Graph View**
    to make arbitrary modifications to a commit.
    This is a very powerful option, as it allows you to modify the contents
    of a commit with no limits on the type of modification. The command is
    explained in more detail here: [Rebase-Interactive Split](../../Manual/GUI/Branch/Rebase-Interactive.md#modify)
-   **Split**: This option, also available from the context menu in the
    **Graph View**, enables you to split changes from a commit into two or
    more separate commits. [Rebase-Interactive Modify](../../Manual/GUI/Branch/Rebase-Interactive.md#split)
-   **Split Off Files**: In the changed files view of a commit, you can
    select **Split Off Files...** to quickly split the changes to the selected
    files into a separate commit. You will be asked to decide whether to
    split before, meaning the new commit will be placed before the original
    commit, or split after, meaning the new commit will be placed immediately
    after the original commit. Of course you can always re-arrange the commits
    later using drag&drop.
