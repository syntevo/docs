# Repository Browser

The Repository Browser offers a direct view into the repository and
basic commands to manipulate repository contents directly. The
Repository Browser comes as a stand-alone frame. It can be invoked from
within the [Project Window](Project-Window.md#ProjectWindow-project-window) by
**Query\|Open in Repository Browser** or by **Window\|New Repository
Browser**. If a [tray icon](Shell-Integration.md#tray-icon)
is present the Repository Browser frame can be invoked by **New
Repository Browser**. The Repository Browser can also be invoked from
[Project Window](Project-Window.md#ProjectWindow-project-window)
commands via [Repository path input fields](Common-Features.md#repository-path-input-fields)
and commands like [Check Out](Check-Out.md#CheckOut-commands.check-out) or [Import into Repository](Import-into-Repository.md#ImportintoRepository-commands.create-module)
provide inbound Repository Browsers.

The Repository Browser displays the repository content with a
**Directory** tree and a **File** table, similar to the [Project Window](Project-Window.md#ProjectWindow-project-window) . For
details on the **File Filter**, refer to [Name Filters](Directory-Tree-and-File-Table.md#name-filters).

The repository file system is only scanned on demand. This happens when
currently unscanned directories are expanded. The Tag-Branch-Layouts
will be used to display directory icons. [Directory States](#directory-states) shows
the possible directory states.

## Directory States


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |              |                                                                                                                                 |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------|
| ![](attachments/2327422/2327429.png)      | Default      | An already scanned repository directory without special meaning.                                                                |
| ![](attachments/2327422/2327423.png)    | Unscanned    | A not yet scanned repository directory.                                                                                         |
| ![](attachments/2327422/2327428.png)         | Root         | A project root, according to some Tag-Branch-Layout.                                                                            |
| ![](attachments/2327422/2327424.png) | Trunk/Branch | A *trunk* or *branch*, according to some Tag-Branch-Layout.                                                                     |
| ![](attachments/2327422/2327425.png)          | Tag          | A *tag* according to some Tag-Branch-Layout.                                                                                    |
| ![](attachments/2327422/2327427.png) | Intermediate | An intermediate directory according to some Tag-Branch-Layout. For instance the parent directory (container) of the *branches*. |
| ![](attachments/2327422/2327426.png)        | Error        | An error has occurred while scanning the repository, only displayed for the root directory.                                     |


## Repository menu

-   Use **Open** to change the currently browsed repository. This
    command opens a dialog where you can enter a **Repository URL** to
    browse. It's recommended (though not necessary) to enter repository
    root URLs.
-   Use **Show Revision** to change the currently displayed revision.
-   Use **Check Out** to check out the currently selected directory.
    This will bring up a simplified **Check Out** wizard, for details
    refer to [Check Out](Check-Out.md#CheckOut-commands.check-out).
-   **Manage Log Caches**, see [Manage Log Caches](Log-Cache.md#manage-log-caches).
-   Use **Close** to close the frame.
-   Use **Exit** to exit SmartSVN.

## Edit menu

-   Use **Stop** to cancel the currently processing operation. This
    action might not be applicable for certain operations.
-   Use **File Filter** to put the focus into the **File Filter** field.
-   Use **Configure Layout** to configure the Tag-Branch-Layout for the
    currently selected directory.
-   Use **Dismiss Layout** to dismiss the Tag-Branch-Layout for the
    currently selected directory. This can be useful to get rid of a
    'deeper' layout in favor of its parent layout.
-   Use **Copy Name** to copy the name of the selected file/directory to
    the system clipboard. If multiple files are selected, all names will
    be copied, each on a new line.
-   Use **Copy URL** to copy the URLs of the selected file/directory to
    the system clipboard. If multiple files are selected, all URLs will
    be copied, each on a new line.
-   Use **Set Encoding** to configure the encoding which will be used
    when displaying file contents for the various **Query**-commands.
    Refer to [Text File Encoding](Project-Settings.md#text-file-encoding)
    for details on when encodings will be applied.
-   Use **Customize** to customize accelerators.
-   Use **Preferences** to show the application preferences (see
    [Preferences](Preferences.md#Preferences-preferences)).

## View menu

-   Use **Refresh** to explicitly refresh the contents of the
    **Directory** tree and the **File** table from the repository.
-   Select **Files from Subdirectories** to also view files from within
    subdirectories of the currently selected directory.

## Modify menu

-   **Create Directory**, see [Create Directory (Repository)](.md#CreateDirectory(Repository)-repository-browser.create-directory).
-   **Remove**, see [Remove (Repository)](.md#Remove(Repository)-repository-browser.remove).
-   **Rename**, see [Rename](Rename-Repository-.md).
-   **Copy**, see
    [Copy/Move](.md#Copy/Move(Repository)-repository-browser.copy-move).
-   **Move**, see
    [Copy/Move](.md#Copy/Move(Repository)-repository-browser.copy-move)
-   **Edit Properties**, see [Edit Properties (Repository)](Edit-Properties-Repository-.md).

## Query menu

-   Use **Open** to open the currently selected file. SmartSVN will
    check out the file to a temporary location and open it in the
    specified editor. For details refer to the corresponding
    [Open](Menus.md#query) command in
    the [Project Window](Project-Window.md#ProjectWindow-project-window) .
-   Use **Open in Repository Browser** to open the currently selected
    file or directory in a new repository browser window. This is
    especially useful for externals.
-   Use **Compare** on a selection of two files or two directories to
    compare their contents. For details refer to [File Compare](File-Compare.md) and [Compare Repository Files or Directories (Command)](Compare-Repository-Files-or-Directories.md), respectively.
-   Use **Log** to display the log for the currently selected directory
    or file. For details refer to the Log.
-   Use **Revision Graph** to display the revision graph for the
    currently selected directory or file. For details refer to the
    [Revision Graph](Revision-Graph.md).
-   Use **Annotate** to display an annotated view of the currently
    selected file's content. For details refer to [Annotate](Annotate.md).
-   Use **Save As** to save the contents of the selected file to a local
    file. Enter the **Target Path** and select whether to **Expands
    keywords** or leave them unexpanded (as they are in the repository).

## Window menu

Refer to [Window](Menus.md#window) for
more details.

## Help menu

Refer to [Help](Menus.md#help) for
more details.


