# Detect Moves

Use **Modify\|Detect Moves** to convert already performed 'manual' moves
(including renamings) of files to 'SVN' moves. Typically, you will not
perform moves within SmartSVN itself, but with system commands, through
an IDE, etc. One such external move results in a missing and a new
unversioned file. Both files could then be added or removed, and
committed, which will result in a correct repository content, but will
not preserve the relationship between both files (which is actually one
moved file). This especially affects the log of the added file: It will
start at the committed revision and won't include the revisions of the
removed file. To preserve the relation (and hence history/log), a
'post-move' on both files has to be performed. **Detect Moves** can
detect such already performed 'manual' moves based on the file content
and displays the corresponding suggestions of which files could be
'post-moved'.

Invoke **Detect Moves** on a set of missing and unversioned files for
which 'post-move' should be detected. Depending on the number of
selected files, the operation might take a while. The results will be
displayed in terms of a list of possible 'post-moved' files pairs.

**Suggestion** displays the detected move in a descriptive manner. If
you agree that the corresponding file pair actually represents a move
that has happened, keep it selected so the corresponding 'post-move'
will be performed. **Similarity** can be helpful for this decision. It
is entirely based on the comparison of the file contents and denotes the
calculated likelihood for the file pair to be an actual move.

For more details, **Target** displays the name of the unversioned (i.e.
new) file. **Source** displays the name of the missing (i.e. old) file.
If the name of the file has not changed, i.e. **Target** would be equal
to **Source**, **Source** is omitted. In the same manner **Target Path**
displays the path of the new file and **Source Path** displays the path
of the old file. Again, **Source Path** will be omitted if it would be
equal to **Target Path**.

There can also be more than one possible **Source** for a specific
**Target**. In this case SmartSVN always suggests the best matching
**Source**, i.e. the file for which the highest **Similarity** value was
calculated, and **Alternatives** shows the number of possible
alternative sources. Use **Compare** to compare the currently selected
**Source** and **Target** file with the [File Compare](File-Compare.md#FileCompare-file-compare) . Use
**Alternatives** to select an alternative source to be used instead of
the original suggestion. Finally, if you consider a particular
suggestion and all available **Alternatives** incorrect, you may
deselect the suggestion so that no 'post-move' will be performed for the
respective **target**.

Click **OK** to perform the selected 'post-moves'.
