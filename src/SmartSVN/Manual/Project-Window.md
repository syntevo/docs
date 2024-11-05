# Project Window

The Project Window is the central place for working with SmartSVN. In
the center of the window, the main **Directories** and **Files** view
show the SVN file system of your currently opened project (working
copy). Various SVN commands on these directories and files are provided
by the menu bar and the toolbar.

## Projects

SmartSVN internally manages your SVN working copies in 'SmartSVN
projects'. A SmartSVN project points to one or more SVN working copies
(local SVN-controlled directories) and has a name and settings ([Project Settings](http://134.119.46.64:8090/doc/display/SUWIP/Project+Settings#ProjectSettings-project.settings))
attached to it. When working with SmartSVN, you are always working with
a project.

## User Interface

In the bottom left area of the Project Window the **Output** view shows
logged output from executed SVN commands. Depending on the command,
there can be several SVN operations available for the logged files and
directories.

In the bottom right the **Transactions** view ([Project Transactions](Project-Transactions.md#ProjectTransactions-project-transactionsx))
collects and displays log information from the repository. The
**Changes** view ([Changes View](Changes-View.md#ChangesView-mainwindow.change-preview))
shows the local modifications of the currently selected file.

Always exactly one of the aforementioned views is 'active', which is
displayed by its highlighted title. We will also refer to the active
view as the view which 'has the focus'. Menu bar actions (as well as
toolbar buttons) are always referring to the currently active view.

At the very bottom of the Project Window is the status bar, displaying
various kinds of information. The first and largest section of the
status bar contains information on operation progress or details for the
currently selected file/directory. The second section displays
information on your current selection from the **Directories** or the
**Files** frame, or no information if neither of these views is active.
The third section displays information on the [Refresh state](Refresh.md#Refresh-commands.refresh) of the project.
The forth section (jack) denotes the Online/Offline state. The fifth
section denotes various notifications which may arise while working with
SmartSVN.

## Perspectives

The layout of the Project Window can be arranged with the mouse by
dragging the splitters between the various views. By dragging their
titles, they can be undocked from one position and docked to another
position. You can maximize a view by double-clicking on its tab title.
Double-click again on the tab title to revert it to the non-maximized
state.

A complete layout configuration is called a *Perspective*. There are two
perspectives available: the **Main Perspective** and the **Review
Perspective**. The **Main Perspective** is primarily intended for giving
you an overview of your project and repository state (Transactions). The
**Review Perspective** is intended for reviewing file content changes,
especially before committing them. Both perspectives can be
re-configured to your needs and you may switch between them in the
**Window** menu.
