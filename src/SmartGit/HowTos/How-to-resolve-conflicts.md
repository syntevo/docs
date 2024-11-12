# How to resolve conflicts

A merge, rebase or cherry-pick may fail due to conflicting changes
between two or more commits. If that happens, SmartGit will halt the
operation and remain in a conflict state. The following screenshot shows
what the *Repositories* view and *Files* view would look like in that
state:

![](attachments/6979703/6979704.png)

There are two ways to leave the conflict state: Resolving the conflicts
and continuing the operation, or canceling the operation.

-   **Resolving the conflicts:** To resolve the conflicts, go through
    all conflicted files one by one and modify them as needed. SmartGit
    provides two features to facilitate this: First, there is a
    three-panel editor called the *Conflict Solver*. It can be opened
    for the currently selected file either through the menu entry
    **Query\|Conflict Solver** in the main menu or through the file's
    context menu. Second, you can instruct SmartGit to resolve the
    conflicts in a particular file by choosing a certain version of it.
    To do this, open the *Resolve* dialog, either through the main menu
    **Local\|Resolve**, or through the file's context menu, and choose
    the version of the file to keep.
-   **Canceling the operation:** You can cancel the operation that led
    to the conflict state by selecting the repository root in the
    *Repositories* view and invoking the *Discard* command. The latter
    can be done either by clicking on the *Discard* button on the main
    toolbar, or through the main menu: **Local\|Discard**.


