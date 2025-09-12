# The Repositories View in SmartGit

The **Repositories View** displays a list of repositories known to SmartGit on your local computer.
It allows you to open an existing repository and shows you which repository or repositories are currently open by highlighting them in **bold**.

Please also refer to [Working with Repositories](Repository/index.md) for general repository operations.

## Working with Repositories

SmartGit remembers repositories you've previously opened, along with any GUI-related settings applied to each one.
To open a repository, double-click it.
If the repository is already open in another window, SmartGit will bring that window into focus.

If the current window is executing commands, or if **Open in New Window** was selected from the repository's context menu, the repository will open in a new window.
To open multiple repositories simultaneously, select each one (e.g., using **`Ctrl/Cmd` + click**) and choose **Open** from the context menu.

## Favorite Repositories
Repositories can be marked as favorites using the **Mark as Favorite** (**Unmark as Favorite**) option.
Favorite repositories are indicated with an asterisk (`*`) after their name and are listed before non-favorite repositories.
Additionally, SmartGit performs background refresh operations on favorite repositories.

## Grouping Repositories
Repositories can be organized into **Group** folders to simplify the management of multiple local repositories.

To create a group folder, right-click in the **Repositories View** and select **Add Group**, or choose **Add Group** from the **Repository** menu.

To move a repository into a group, right-click the repository, go to the **Move To** submenu, and select the target group.
Alternatively, you can drag and drop the repository into the desired group folder (see [autoscroll](Tips-and-Tricks.md#autoscrolling-while-drag-and-drop)).

### Tips
> - Groups can be nested inside other groups by selecting the parent group and then adding a new group.
> - To move a nested group back to the top level, use **Move To** and choose **No Group**.
> - You can select multiple repositories by holding **Control** or **Shift**.
> - To create a new top-level repository, ensure no group or repositories are selected -- you may need to hold **Control** to deselect a highlighted group.
