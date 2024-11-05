# Conflict Solver

The Conflict Solver is a kind of *Three-Way-Merge*. The content of the
current file (which contains the conflicts) is displayed in the center
text area ('merge view'). The left and right text areas show the
contents of the two files, which have been forked from the common base.
The common base itself is not displayed, but regarded by the UI for
highlighting changes and conflicts. All file contents are directly taken
from the files, which SVN produces in case of conflicting changes. The
Conflict Solver is invoked by **Tools\|Conflict Solver** from the
[Project Window](Project-Window.md#ProjectWindow-project-window) .


#### Note
>
>
>Depending on your configuration in the Preferences, performing a
>conflict solver can also invoke an external three-way-merge tool. This
>section refers only to the built-in *Conflict Solver* of SmartSVN.
>
>

The Conflict Solver works similar to the [File Compare](File-Compare.md#FileCompare-file-compare) , see also
[Comparison](File-Compare.md#comparison)
for details.
