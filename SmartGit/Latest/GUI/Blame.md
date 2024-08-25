# Blame

SmartGit's Blame window displays the history information for a single file in a way that helps you to track down the commit in which a certain portion of code was introduced into the repository.
You can open the Blame window by selecting a file in the **Files** view and invoking **Query\|Blame** from the program menu.
The Blame window consists of a **Document** view and a **History of current line** view.

## Document view

The **Document** view is divided into three parts: some controls on top,
a read-only text view on the right, and an *info area* on the left. With
the controls on top, you can do two things: specify the **View Commit**
at which the text view will display the file contents, and set how to
**Highlight** the lines in the text view:

-   **Change Since** The color chosen for a particular line reflects
    whether the line is 'older' or 'newer' than the specified
    **Commit**. More precisely, the color reflects whether the date when
    the line was last modified lies before or after the date of the
    commit.
-   **Age** The color chosen for a particular line lies somewhere
    'between' the two colors used for the oldest and the newest commit
    in which the file was modified, and thus reflects the line's
    relative 'age'. You can choose between two age criteria for
    determining the line color: either **Commit Index** which refers to
    the relative position in the relevant commit range (first commit,
    second commit, etc.) or **Time** which refers to the commit date,
    i.e. the point in time at which the commit was created.
-   **Author** The color chosen for a particular line depends on the
    author who made the most recent modification to that line. Each
    author is mapped to a different color.

The *info area* shows the commit meta data in a compact format for each
line and consists of following columns:

-   **SHA** short SHA of the commit
-   **Status** will display an '\~'-mark if the line has been modified
    (and not added) and/or an 'M' if the line has been introduced in a
    merge commit
-   **Author** the initials or a short name of the author
-   **Date** a compact display of the commit date
-   **Line number** the number of the current line

More detailed information for a specific commit will be displayed in the
tooltip, when hovering over the *info area*. The hyperlinks can be used
to navigate to the specific commit.

## History view

The **History of current line** view displays the 'history' of the
currently selected line from the **Document** view: the 'history'
consists of all detected *past* and *future* versions of the line, as it
is present in the select **View Commit**. The position of the currently
selected line from the **Document** view is denoted by pale borders
surrounding the corresponding line in the **History** view.

The detection of a link between a *past* and a *future* version of a
line depends on the changes which have happened in a commit:

-   If a certain number of lines has been replaced by exactly the same
    number of lines within a commit, this change will be detected as
    *modification* of the corresponding lines and hence they will share
    the same history.
-   If a certain number of lines has been replaced by larger or smaller
    number of lines, the detection of *matching* lines depends on the
    outcome of the internal *compare algorithm*. For the case where a
    line has been detected as *removed* in a commit (instead of
    *replaced* by another line, what might be more appropriate), the
    history contains a leading *commit after line has been removed*
    entry to which you can navigate. For the case where a line has been
    detected as *added* in a commit (instead of *replacing* another
    line, what might be more appropriate), the history contains a
    trailing *commit before line has been added* entry to which you can
    navigate.


#### Note
>
>
>For lines having a '\~'-mark in the **Document** view, the **History**
>view will always show *past* commits.
>
>
