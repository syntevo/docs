# Annotate

The **Annotate** window shows the contents of a file with each line
prefixed by the line number and by information about the *last* revision
in which this line has been introduced or changed. The **Annotate**
window is typically opened via **Query\|Annotate** from the [Project Window](Project-Window.md#ProjectWindow-project-window) , but
there are other ways and windows to open an **Annotate** window in
SmartSVN.

## Configuration dialog

On the **Configuration** tab, you can specifiy the date range over which
to run the Annnotate operation.

On the **Advanced** tab, select **Treat even binary revisions as text
("force")** to continue the Annotate operation even when it encounters
one or more binary revisions of the file. This option can be necessary
if the
[MIME-Type](https://www.syntevo.com/doc/display/SUWIP/MIME-Type#MIME-Type-commands.mime-type)
of a file was changed, e.g. from *binary* to *text* in some earlier
revision, and the file had *text* content throughout. In case the file
actually had binary content in some earlier revision, parts of the
annotate output might contain junk.

Use **Annotate contents of all revisions** to query the repository for
contents of all revisions of the file, not just the latest revision: by
default, `svn annotate` will show you details for the latest state of
your file; i.e. you can trace the history for all lines of the latest
state of your file, however you can't see what the content of the lines
has been before. Also, you can't see deleted lines. Using this option
will take *all* states of the file into account and hence provide you
access to every line which has ever been present in the file.

## Annotate window

The **View Revision** drop-down list displays all available revisions of
the file, and allows navigating through them. It will only be present if
**Annotate contents of all revisions** had been selected for the
configuration.

With the **Highlight** drop-down list you can select one of the
following line coloring schemes:

-   Choose **Changes Since** to have two colors and a threshold revision
    **Newer Or Equal**. Lines which have been introduced before this
    threshold revision will receive the default background color, while
    lines introduced at or after the threshold revision will receive
    another background color.
-   Choose **Age** to change the coloring scheme so that the colors of
    the lines reflect their 'Age': The youngest and oldest line will be
    determined, receiving two distinct colors. For all other lines, the
    color will be linearly interpolated based on their relative age
    compared to the youngest and oldest line. The interpolation itself
    can either be based on the **Revision** number or on the revision's
    commit **Time**.
-   Choose **Author** to have lines of the same author displayed with
    the same background color, and lines of different authors displayed
    with different background colors.

## Revision menu

This menu will only provide functionality if **Annotate contents of all
revisions** had been selected for the configuration.

-   Use **Show File Changes** to invoke a [File Compare](File-Compare.md#FileCompare-file-compare) between
    the currently selected **View Revision** and the previous revision.
-   Use **Show Revision Changes** to invoke a [Revision Compare](Revision-Compare.md#RevisionCompare-revision-compare)
    containing all changed files between the currently selected **View
    Revision** and the previous revision.
-   Use **Go To First Revision** to select the first **View Revision**.
-   Use **Go To Last Revision** to select the last **View Revision**.
-   Use **Go To Next Revision** to select the next **View Revision**.
-   Use **Go To Previous Revision** to select the previous **View
    Revision**.
-   Use **Go To Preceding Revision** to select the preceding **View
    Revision** for the currently selected line -- to see what the
    content of the line has been before.
