# Menus

This section summarizes actions which are available from the various
Project Window menus.

## Project

-   **Check Out**, see [Check Out](Check-Out.md#CheckOut-commands.check-out).
-   **Open Working Copy**, see
    [Projects](Projects.md#Projects-project).
-   **Edit Working Copy**, see
    [Projects](Projects.md#Projects-project).
-   **Manage as Project**, see
    [Projects](Projects.md#Projects-project).
-   **Remove Working Copy**, see
    [Projects](Projects.md#Projects-project).
-   **Import into Repository**, see [Import into Repository](Import-into-Repository.md#ImportintoRepository-commands.create-module).
-   **Set Up Local repository**, see [Set Up Local Repository](Set-Up-Local-Repository.md#SetUpLocalRepository-commands.repository-setup).
-   **Open or Manage Projects**, see [Project Manager](Project-Manager.md#ProjectManager-project.manager).
-   **Close**, see [Projects](Projects.md#Projects-project).
-   **Manage Log Caches**, see [Manage Log Caches](Log-Cache.md#manage-log-caches).
-   **Settings**, see [Project Settings](Project-Settings.md#ProjectSettings-project.settings).
-   **Default Settings**, see [Project Settings](Project-Settings.md#ProjectSettings-project.settings).
-   **Exit** exits SmartSVN.

## Edit

-   **Stop** stops the currently running operation. Depending on the
    type of operation, this action might not be applicable. On the other
    hand, while an operation is running, most of the other actions are
    not applicable.
-   **Reveal in Finder** (Mac OS only) brings the *Finder* process to
    front and selects the currently selected file/directory.
-   **File Filter** positions the cursor in the file table's filter
    field.
-   **Select Committable Files** selects all committable files in the
    file table. Because SmartSVN allows to automatically add
    *unversioned* or remove *missing* files for a commit, such files are
    also selected.
-   **Select Directory** selects the deepest common directory for all
    selected files in the file table.
-   **Select in Project** selects the currently selected
    files/directories from the
    [Transactions](Project-Transactions.md#ProjectTransactions-project-transactions)
    view or the **Output** area in the file table/directory tree.
-   **Copy Name** copies the name of the selected file/directory to the
    system clipboard. If multiple files are selected, all names will be
    copied, each on a new line.
-   **Copy Path** copies the path of the selected file/directory to the
    system clipboard. If multiple files are selected, all paths will be
    copied, each on a new line.
-   **Copy Relative Path and Revision** copies the path of the selected
    file/directory relative to the project root directory and its
    revision number to the system clipboard. If multiple files are
    selected, all paths will be copied, each on a new line.
-   **Copy Relative Path** copies the path of the selected
    file/directory relative to the project root directory to the system
    clipboard. If multiple files are selected, all paths will be copied,
    each on a new line.
-   **Copy URL** copies the repository URL of the selected
    file/directory to the system clipboard. If multiple files are
    selected, all URLs will be copied, each on a new line.
-   **Copy Revision Number** copies the revision number associated with
    the item in the currently active view (e.g. Directory view, Files
    view, Transactions view) to the system clipboard. If multiple items
    are selected, all their revision numbers will be copied, each on a
    new line. For example, if a file in the Files view is selected, this
    command will copy the revision number of the file to the clipboard.
-   **Copy Message** copies the message of the currently selected
    revision in the
    [Transactions](Project-Transactions.md#ProjectTransactions-project-transactions)
    view. If multiple revisions are selected, all messages will be
    copied, each on a new line.
-   **Clear Output** clears the output displayed in the **Output** view.
-   Use **Customize** to customize accelerators, context menus and the
    toolbar.
-   **Preferences** shows the application preferences (see
    [Preferences](Preferences.md#Preferences-preferences)).

## View

-   **Table Columns** lets you specify which file attributes will be
    displayed in the file table, see [File attributes with SVN counterparts](File-Attributes.md#file-attributes-with-svn-counterparts)
    and [File attributes without SVN counterparts](File-Attributes.md#file-attributes-without-svn-counterparts).
    The order of the table columns can also be defined here.
    (Alternatively, you can reorder them directly in the file table by
    dragging the column headers.) Select **Remember as default** to have
    the selected configuration applied to every new project.
-   **Refresh**, see
    [Refresh](Refresh.md#Refresh-commands.refresh).
-   **Files From Subdirectories** enables the recursive view showing not
    only files from the currently selected directory but also those from
    subdirectories.
-   With **Unchanged Files** *unchanged* files are displayed. It is
    often convenient to hide them, as they are of no interest for most
    of the SVN commands.
-   With **Unversioned Files** *unversioned* files (also within
    unversioned directories) are displayed.


#### Note
>
>
>The **Unversioned Files** option does in no way affect the unversioned
>files themselves or their SVN states. Certain operations, which can work
>on unversioned files, will include them anyway. Parent directories of
>unversioned files will continue to display the *Direct/Indirect Local
>Changes* state. To actually ignore such files on the SVN-level you can
>use the [Ignore command](Ignore.md#Ignore-commands.ignore) .
>
>

-   With **Ignored Files** *ignored* files within versioned directories
    will be displayed. Files from ignored directories are never
    displayed.
-   With **Files Assigned to Change Set** selected, files which have
    already been assigned to a [Change Set](Change-Sets.md#ChangeSets-commands.changeset) will be
    displayed. Otherwise, these file will be hidden in order to give a
    better overview of the files not assigned to any Change Sets. This
    option has no effect if the selected directory is a Change Set
    itself or part of a Change Set.
-   With **Remote Changed Files** selected, files will be displayed
    which are remotely changed (see [Remote State Types](Remote-State.md#remote-state-types)).
    Typically, this option has no effect if **Unchanged Files** is
    selected, because these files are shown anyway. An exception here
    are files which only exist remotely, i.e. files which are in
    *Remote* state.

## Modify

-   **Update**, see
    [Update](Update.md#Update-commands.update).
-   **Update More**, see [Update More](Update-More.md#UpdateMore-commands.update-more).
-   **Exclude from Working Copy**, see [Exclude from Working Copy](Exclude-from-Working-Copy.md#ExcludefromWorkingCopy-commands.update-exclude).
-   **Switch**, see
    [Switch](Switch.md#Switch-commands.switch).
-   **Relocate**, see
    [Relocate](Relocate.md#Relocate-commands.relocate).
-   **Merge**, see [Merge](Merge.md#Merge-commands.merge).
-   **Merge from 2 Sources**, see [Merge from 2 Sources](Merge-from-2-Sources.md#Mergefrom2Sources-commands.merge-from-2-sources).
-   **Apply Patch**, see [Apply Patch](Apply-Patch.md#ApplyPatch-commands.apply-patch).
-   **Commit**, see
    [Commit](Commit.md#Commit-commands.commit).
-   **Add**, see [Add](Add.md#Add-commands.add).
-   **Remove**, see
    [Remove](Remove.md#Remove-commands.remove).
-   **Ignore**, see
    [Ignore](Ignore.md#Ignore-commands.ignore).
-   **Delete Physically**, see [Delete Physically](Delete-Physically.md#DeletePhysically-commands.delete).
-   **Create Directory**, see [Create Directory](Create-Directory.md#CreateDirectory-commands.create-directory).
-   **Rename**, see
    [Rename](Rename.md#Rename-commands.rename).
-   **Move**, see [Move](Move.md#Move-commands.move).
-   **Detect Moves**, see [Detect Moves](Detect-Moves.md#DetectMoves-commands.detect-moves).
-   **Copy**, see [Copy](Copy.md#Copy-commands.copy).
-   **Copy From Repository**, see [Copy From Repository](Copy-From-Repository.md#CopyFromRepository-commands.copy-url-wc).
-   **Copy To Repository**, see [Copy To Repository](Copy-To-Repository.md#CopyToRepository-commands.copy-wc-url).
-   **Copy Within Repository**, see [Copy Within Repository](Copy-Within-Repository.md#CopyWithinRepository-commands.copy-url-url).
-   **Revert**, see
    [Revert](Revert.md#Revert-commands.revert).
-   **Mark Resolved**, see [Mark Resolved](Mark-Resolved.md#MarkResolved-commands.mark-resolved).
-   **Mark Replaced**, see [Mark Replaced](Mark-Replaced.md#MarkReplaced-commands.mark-replaced).
-   **Clean Up**, see [Clean Up](Clean-Up.md#CleanUp-commands.clean-up).
-   **Fix**, see [Fix](Fix.md#Fix-commands.fix).

## Change Set

-   **Move to Change Set**, see [Move to Change Set](Change-Sets.md#move-to-change-set).
-   **Move Up**, see [Move Up](Change-Sets.md#move-up).
-   **Move Down**, see [Move Down](Change-Sets.md#move-down).
-   **Delete**, see
    [Delete](Change-Sets.md#delete).
-   **Edit Properties**, see [Edit Properties (Change Set)](Change-Sets.md#edit-properties-change-set).

## Tag+Branch

-   **Add Tag**, see [Add Tag](Add-Tag.md#AddTag-commands.add-tag).
-   **Tag Multiple Project Roots**, see [Tag Multiple Project Roots](Tag-Multiple-Project-Roots.md#TagMultipleProjectRoots-commands.tag-multiple-project-roots).
-   **Add Branch**, see [Add Branch](Add-Branch.md#AddBranch-commands.tags.add-branch).
-   **Tag Browser**, see [Tag Browser](Tag-Browser.md#TagBrowser-commands.tags.browser).
-   **Configure Layout**, see [Configure Layout](Configure-Layout.md#ConfigureLayout-commands.configure-layout).

## Query

-   **Open** opens the selected files/directory. If the file table has
    the focus, the file(s) will be opened in an editor. The editor to be
    used to open a file can be configured in the **External Tools**
    section of the [Preferences](Preferences.md). For files, you can
    specify a limit on the number of files beyond which you will be
    asked before the files are opened at once; for details refer to the
    **Tools** section in the [Preferences](Preferences.md).
-   Use **Open in Repository Browser** to open the selected
    directory/file in the [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser)
    .
-   **Remove Empty Directories** schedules empty directories below the
    selected base directory for removal.
-   **Refresh Remote State**, see [Refresh Remote State](Remote-State.md#refresh-remote-state).
-   **Clear Remote State**, see [Clear Remote State](Remote-State.md#clear-remote-state).
-   For all other commands, see [Queries](Queries.md).

## Properties

-   **Edit Properties**, see [Edit Properties](Edit-Properties.md#EditProperties-commands.properties.edit).
-   **Set or Delete Property**, see [Set or Delete Property](Set-or-Delete-Property.md#SetorDeleteProperty-commands.properties.set-or-delete).
-   **MIME-Type**, see
    [MIME-Type](MIME-Type.md#MIME-Type-commands.mime-type).
-   **EOL-Style**, see
    [EOL-Style](EOL-Style.md#EOL-Style-commands.eol-style).
-   **Keyword Substitution**, see [Keyword Substitution](Keyword-Substitution.md#KeywordSubstitution-commands.keyword-substitution).
-   **Excutable-Property**, see
    [Executable-Property](Executable-Property.md#Executable-Property-commands.executable-property).
-   **Externals**, see
    [Externals](Externals.md#Externals-commands.externals).
-   **Ignore Patterns**, see [Ignore Patterns](Ignore-Patterns.md#IgnorePatterns-commands.ignore-patterns).
-   **Bugtraq-Properties**, see
    [Bugtraq-Properties](Bugtraq-Properties.md#Bugtraq-Properties-commands.bugtraq-properties).
-   **Merge Info**, see [Merge Info](Merge-Info.md#MergeInfo-commands.mergeinfo).

## Locks

-   **Refresh**, see
    [Refresh](Locks.md#refresh).
-   **Lock**, see [Lock](Locks.md#lock).
-   **Unlock**, see
    [Unlock](Locks.md#unlock).
-   **Show Info**, see [Show Info](Locks.md#show-info).
-   **Change 'Needs Lock'**, see [Change 'Needs Lock'](Locks.md#change-needs-lock).

## Changes

-   Use **Reload** to refresh the file contents from the file system and
    recalculate the differences.
-   Use **Previous Change** to navigate to the previous change within
    the currently selected file. If there is no previous change,
    SmartSVN will select the last change of the *previous file* (as
    displayed in the file table).
-   Use **Next Change** to navigate to the next change within the
    currently selected file. If there is no next change, SmartSVN will
    select the first change of the *next file* (as displayed in the file
    table).
-   For **Ignore Whitespace for Line Comparison**, refer to [Compare Settings](File-Compare.md#compare-settings).
-   For **Ignore Case Change for Line Comparison**, refer to [Compare Settings](File-Compare.md#compare-settings).
-   For **Settings**, refer to [Compare Settings](File-Compare.md#compare-settings).

## Transactions

-   **Refresh**, see [Transaction menu](Transactions-Frame.md#TransactionsFrame-transactions-frame.menu-transaction).
-   **Mark as Read**, see [View menu](Transactions-Frame.md#TransactionsFrame-transactions-frame.menu-view).
-   **Mark All as Read**, see [View menu](Transactions-Frame.md#TransactionsFrame-transactions-frame.menu-view).
-   Select **Show Branches and Tags** to display not only the working
    copy revisions but also revisions of the *trunk*, *branches* and
    *tags*. Refer to [Watched URLs](Transactions-Frame.md#watched-urls)
    for details.
-   Select **Show Additional Watched URLs** to display not only the
    working copy revisions but also revisions which have explicitly been
    configured to be watched by **Configure Watched URLs**.
-   **Ungrouped Revisions**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   **Grouped by Days**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   **Grouped by Weeks**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   **Grouped by Date**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   **Grouped by Authors**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   **Grouped by Location**, see [Grouping of revisions](Transactions-Frame.md#grouping-of-revisions).
-   Use **Merge** to merge the selected revision to your local working
    copy. If you want to configure advanced options for the merge, use
    the default [Merge command](Merge.md#Merge-commands.merge).
-   Use **Update** to update your working copy to the selected revision.
-   **Rollback**, see [Modify menu](Log.md#modify-menu).
-   **Change Commit Message**, see [Modify menu](Log.md#modify-menu).
-   **Configure Watched URLs**, see [Watched URLs](Transactions-Frame.md#watched-urls).
-   **Settings**, see
    [Settings](Project-Transactions.md#settings).

## Window

-   **New Project Window** opens a new Project Window for working on
    another project.
-   **New Repository Browser** opens a new [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser)
    .
-   **Show Transactions** shows the standalone [Transactions Frame](Transactions-Frame.md#TransactionsFrame-transactions-frame)
    .
-   **Full Screen** switches the program to full-screen mode. To get
    back to the normal mode, click on this menu entry again.
-   **Maximize** maximizes the program window.
-   **Minimize** minimizes the program window. On most platforms, to
    bring it back you have to click on SmartSVN in the task bar.
-   **Maximize View** maximizes the currently active view. This action
    can also be performed by double-clicking on the tab title area of
    the respective view.
-   **Hide View** hides the currently active view. This is the same as
    clicking on the **Close** button of the view. To bring the hidden
    view back, select the corresponding entry in this menu. For example,
    after hiding the **Directories** view, you can bring it back with
    **Window\|Directories**.
-   **Directories** puts the focus in the [Directory tree](Directory-Tree-and-File-Table.md#DirectoryTreeandFileTable-mainwindow.filetable)
    .
-   **Files** puts the focus in the [File table](Directory-Tree-and-File-Table.md#DirectoryTreeandFileTable-mainwindow.filetable)
    .
-   **Output** puts the focus in the [Output view](Project-Window.md#user-interface) .
-   **Changes** puts the focus in the [Changes view](Project-Window.md#user-interface) .
-   **Transactions** puts the focus in the [Transactions view](Project-Transactions.md#ProjectTransactions-project-transactions)
    .
-   **Main Perspective** switches to the [Main Perspective](Project-Window.md#perspectives)
    .
-   **Review Perspective** switches to the [Review Perspective](Project-Window.md#perspectives)
    .

The subsequent content of the **Window** menu depends on which windows
are currently open. For each window, there is a menu item to switch to
it.

## Help

-   **Help Topics** shows the online version of SmartSVN's help.
-   **Contact Support** opens your email client to send a message to
    *support@smartsvn.com*.
-   **Check for New Version** connects to the SmartSVN website and
    checks, if there is a new version available for download. By
    default, this check is also performed when starting SmartSVN. You
    can configure the checking for new versions within the
    [Preferences](Preferences.md).
-   **Check for Latest Build** connects to the SmartSVN website and
    checks, if there is a latest build available for download.
-   Use **Obfuscate Log Cache** to remove potentially confidential
    information from a Log Cache so it can be sent to SmartSVN GmbH for
    debug purposes. Select the **Cache** to obfuscate, the **Output
    File** where the obfuscated cache should be stored and the **Map
    File** which contains the mapping between between real repository
    paths and obfuscated paths.
-   **Register** switches to the Professional edition.
-   **License Agreement** displays the SmartSVN license agreement.
-   **About SmartSVN** shows information about the SmartSVN version
    you're using and about your SmartSVN license.
