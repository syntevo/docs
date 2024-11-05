# Copy To Repository

With **Modify\|Copy To Repository** you can copy the selected local
file/directory to the repository. This operation can be used to create
tags, although SmartSVN provides more convenient commands for this task
(see [Tags and Branches](Tags-and-Branches.md#TagsandBranches-commands.tags)).

**Repository** is the repository of your local working copy, it can't be
changed as copies can only be performed within the same repository. The
local file/directory **Copy Local** will be copied to the project's
**Repository**. The target directory is **Into Directory**. **With
Name** will be the name (i.e. last component of the path) of the
resulting file/directory. Because the copy is directly performed into
the repository, you have to specify a **Commit Message**.

Use **Externals Revisions** to specify how to handle [externals revisions](Externals.md#Externals-commands.externals) . This
option is only relevant for externals which have their revisions set to
**HEAD**. By default, **Leave as is** will not modify any externals
revisions. Choose **Fix all** to have all revisions set to their current
values, as present in the working copy. Choose **Fix except below** to
have all revisions set to their current values except externals pointing
to the specified location or some subdirectory of this location.

Only when fixing externals you can make sure that later checkouts of the
copied location will produce exactly the same working copy. Otherwise,
externals which have been left at **HEAD** will continue to bring the
latest revisions of that externals which are in general not equal to
that at the time of creating the copy.
