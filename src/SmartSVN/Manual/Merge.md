# Merge

Use **Modify\|Merge** to merge changes from another source branch to the
selected file/directory.

Select **Trunk** to merge from the main trunk. Select **Branch** or
**Tag** and enter the branch or tag name to merge changes from a branch
or tag. Select **Other Location** to merge from an arbitrary location,
specifying the corresponding repository and path.

Alternatively, you may select a merge source from the **History**
button. It shows a list of previous merge sources you have used, as well
as merge sources extracted from the
[svn:mergeinfo](Merge-Info.md#MergeInfo-commands.mergeinfo)
property of your merge target.

Use **All Revisions** to merge all the revisions which have not yet been
merged from the selected location. SmartSVN will detect them based on
the present *merge tracking* information.


#### Warning
>
>
>**All Revisions** does not work with *pre-1.5* servers (e.g. 1.4
>servers).
>
>

Use **Revision Range** to manually specify multiple (ranges of)
revisions to be merged from the selected location. SmartSVN will detect
whether certain revisions of the specified ranges have already been
merged and avoid to repeatedly merge them. Single revisions are just
specified by their revision number while ranges starting at `start`
(inclusive) and ending at `end` (inclusive) are specified by
`start-end`. Multiple revisions (ranges) can be specified with a
separating colon (`,`). Certain revisions may be excluded by prefixing
them with an exclamation mark (`!`).

Instead of entering the revisions manually, you can choose them from the
[revision browser](Common-Features.md#revision-input-fields)
. The revision browser will indicate with a green arrow ('merge
candidates') which revisions have not been merged. From the
**Options**-button you can select **Show only mergable revision** to
restrict the revision list to those merge candidates. By default, **Show
all revisions** will include also revisions which have already been
merged.

Select **Reverse merge** to reverse the changes between the selected
revisions. Internally, this is achieved by swapping the start and end
revisions.

#### Advanced options

By default, merging takes the ancestry into account, meaning that
merging does not simply calculate (and merge) the difference between two
files which have the same path, but also checks if both files are
actually related. For the typical merging use cases, this behavior leads
to the expected results and it is also required for the merge tracking
to work. You can switch this behavior off by selecting **Ignore
ancestry**, however this option is not recommended unless you have a
good reason to use it.

Regarding **Ignore changes in EOL-style** and **For Whitespaces**
handling, refer to **Create Patch** ([Queries](Queries.md)).

Deselect **Recurse into subdirectories** to merge only changes to the
selected directory/file itself but not it's contained files, etc. In
general it's recommended to keep **Recurse into subdirectories**
selected.

With **Record only** no files will be touched during the merge, and only
the [Mergeinfo](Merge-Info.md#MergeInfo-commands.mergeinfo),
will be adjusted accordingly, so that the core merge tracking mechanisms
consider the revisions as merged. This option can be useful to 'block'
certain revisions from being actually merged.

By default merging will stop when it's required to delete locally
modified files, because they have been removed in the merge source. You
can switch off this safety check by selecting **Force deletion of
locally modified files, if necessary**.

Select **Allow operation on mixed-revision working copy** to disable
SmartSVN's check for mixed-revision. This option is not recommended
because it will usually result in more complex *svn:mergeinfo*.

Close the dialog with **Merge** to immediately perform the merge to the
selected directory/file of the current working copy. Alternatively you
may choose to **Preview** the changes that would result from the merge.
Refer to the [Merge Preview](Merge-Preview.md#MergePreview-merge-preview) for
details.
