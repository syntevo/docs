# Project Transactions

The *Project Transactions* are displayed in the **Transaction** view
which is by default located in the lower right area of the [Project Window](Project-Window.md#ProjectWindow-project-window) . The
Project Transactions view provides virtually all features of the
stand-alone [Transactions Frame](Transactions-Frame.md#TransactionsFrame-transactions-frame)
and extends some of them.

Many commands available in the Project Transactions view are integrated
into the various [Project Window commands](Project-Window.md#ProjectWindow-project-window), for
instance Log transparently works on the the project files and
directories as well as on Transaction revisions or files. The
Transactions-specific commands can be found in the **Transactions**
menu, see
[Transactions](Menus.md#transactions).

The main difference compared to the Transactions frame is that those
revisions which are related to the current working copy (called *working
copy revisions*) are implicitly displayed; similar to the Transactions
frame further 'watched URLs' can be configured by
**Transactions\|Configure Watched URLs**.

For working copy revisions, their
[read/unread](Transactions-Frame.md#readunread-revisions)
state is tracked but not displayed in the Project Transactions. Instead,
based on the local working copy state, the 'remote state' for every
revision is evaluated and displayed accordingly: If a revision has
already been updated, it's simply displayed as *read*. If there is at
least one file part of the revision which will be updated when
[updating](Update.md#Update-commands.update) to *HEAD* the
revision is displayed as *read*, containing a *green arrow*, see
[Revision states](Transactions-Frame.md#revision-states).

## Settings

Select **Transactions\|Settings** to configure the Project Transactions.

Select **Repeatedly refresh transactions** to refresh the working copy
transactions recurrently, with the same interval as for the Transactions
frame. Select **Refresh after loading project** to automatically refresh
the working copy transactions after a project has been loaded. Select
**Refresh after a command changed the working copy** to automatically
refresh after Updates, Commits, etc.

Regarding the basic **Display** options, refer to [Display Settings](Transactions-Frame.md#display-settings).
**Display revisions for the last** and **But at most** refer to the
working copy revisions; the meaning of these options is identical to the
additionally watched URLs, for details refer to [Watched URLs](Transactions-Frame.md#watched-urls).
