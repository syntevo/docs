# Transactions Frame

The Transactions frame can be invoked from within the [Project Window](Project-Window.md#ProjectWindow-project-window) or
from within the [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser)
by **Window\|Show Transactions**. If a [tray icon](Shell-Integration.md#tray-icon)
is present the Transactions frame can be invoked by **Show
Transactions**.

The Transactions frame can be used to observe multiple repositories at
the same time. Every revision of every repository is represented by one
line in the transactions tree, which can be expanded to see which
files/directories have been affected by the corresponding revision.


#### Note
>
>
>For repositories in an older format than Subversion 1.6, the received
>log data does not contain information on whether a changed entry is of
>file or directory type. Hence, all entries modified in a revision will
>be displayed using file icons (even if there are directories).
>
>

A revision line primarily shows the commit message of the corresponding
revision and has a prefix which shows various properties of that
revision:

-   **Root** displays to which repository the revision belongs. This
    column is only present if multiple repositories are observed, refer
    to [Watched URLs](#watched-urls) for
    details. The column may also contain the 'project name', appended
    after a colon (':'). The 'project name' is the last path component
    of the project root of the corresponding Tag-Branch-Layout.
-   **Revision Number** Displays the revision number.
-   **Time** Displays date and time of the revision. The used format can
    be changed in the  [Preferences](Preferences.md).
-   **Trunk/Branch/Tag** displays the corresponding *trunk*, *branch* or
    *tag* to which the revision belongs, refer to Tag-Branch-Layout for
    details. This column is only present if at least one of the
    displayed revisions actually belongs to a *trunk*, *branch* or
    *tag*.
-   **Author** Displays the revision's author.
-   **File count** Displays the number of modified files/directories the
    revision contains.

The changed files/directories for a revision are displayed relative to
the corresponding **Trunk/Branch/Tag** of the revision, or relative to
the **Root**'s URL in case no Tag-Branch-Layout is used. If a
Tag-Branch-Layout is used, but a file path does not fit into the
Tag-Branch-Layout, it will be prefixed by a '/' to denote that it is
given relative to the **Root**.

## Grouping of revisions

Use the **View** to group the revisions by different categories:

-   Ungrouped
-   Days
-   Weeks
-   Date
-   Authors
-   Location (repository)

## Watched URLs

Use **Edit\|Configure Watched URLs** to configure the observed URLs
(i.e. repositories). Every entry must have a **Name** which will be
displayed in the 'Root' column of the revision line prefix to
distinguish revisions from different repositories. All revisions below
the **Root URL** will be observed.

With the **Display revisions for the last** and **But at most** options
you can put limits on how far into the past the Transactions view will
display revisions.


#### Note
>
>
>For large and/or highly active projects, using a large value for
>**Display revisions for the last** without a reasonable **But at most**
>restriction can require significant memory usage and computational
>resources.
>
>

The watched URLs can be refreshed manually with **Transaction\|Refresh**
and they will be refreshed recurrently for the interval specified in the
 [Preferences](Preferences.md).

## Revision states


|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |                |                                                                                                         |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|---------------------------------------------------------------------------------------------------------|
| ![](attachments/2327436/2327438.png) | Default (read) | A (*read*) revision.                                                                                    |
| ![](attachments/2327436/2327439.png)     | Unread         | An *unread* revision.                                                                                   |
| ![](attachments/2327436/2327437.png)  | Remote         | A working copy revision which contains at least one file which will be updated when updating to *HEAD*. |


## Read/Unread revisions

SmartSVN internally manages for every repository a list of which
revisions are *Unread* and which revisions have already been *Read*.
This mechanism is similar to how email clients work: Newly fetched
revisions are considered as *Unread* and hence are displayed with a blue
color. In addition to that, they will have a different icon. For details
refer to [Revision states](#revision-states). Use
**View\|Mark as Unread** or **View\|Mark All as Read** to mark revisions
as *unread* or *read*.

The read/unread state of revisions is not related to a single
Transactions view, but shared by all views. For instance, multiple
[Project Window transactions](Project-Transactions.md#ProjectTransactions-project-transactions)
and the Transactions frame itself may show the same repositories.
Marking a revision as read/unread will change their state in all of
these views.

## Display Settings

The layout of the revision line prefix can be configured in the display
settings, via **View\|Settings**. Choose whether to show **Time**,
**Author**, **File/directory count** and/or **Trunk/Branch/Tag**.

 


