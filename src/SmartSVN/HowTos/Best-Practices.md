# Best Practices

# Setup a Repository

The SVN standard layout looks for a single-project repository:

    [-] root
     +-- [-] branches
     |    +-- [+] branchA
     |    +-- [+] branchB
     |    ...
     +-- [-] tags
     |    +-- [+] tagA
     |    +-- [+] tagB
     |    ...
     +-- [+] trunk

or for multi-project repositories:

    [-] root
     +-- [-] project1
     |    +-- [-] branches
     |    |    +-- [+] branchA
     |    |    +-- [+] branchB
     |    |    ...
     |    +-- [-] tags
     |    |    +-- [+] tagA
     |    |    +-- [+] tagB
     |    |    ...
     |    +-- [+] trunk
     +-- [-] project2
     |    +-- [-] branches
     |    |    +-- [+] branchA
     |    |    +-- [+] branchB
     |    |    ...
     |    +-- [-] tags
     |    |    +-- [+] tagA
     |    |    +-- [+] tagB
     |    |    ...
     |    +-- [+] trunk
     ...

Each of the directories `branchA`, `branchB`, ..., `tagA`, `tagB`, ...
and `trunk` contain the full set of project files, not just
sub-directories!



It is very recommended to follow this standard layout.



# Checkout a Branch

You should neither checkout the repository root nor the project root
from the repository, but **just one of the directories** `branchA`,
`branchB`, ..., `tagA`, `tagB`, ... or `trunk`.

The reason is simple: if you would have checked out the whole repository
or the whole project, including tags and branches, it would be a
complete waste of hard disk space because each of the branches is a more
or less different duplicate of the project content. Usually, branches
and tags are created often and this would cause your full-repository or
full-project working copy to quickly become very large and slow to
handle.

After having checked out a branch from a project the first time, you can
tell SmartSVN about the directory names for tags, branches by using
**Tag+Branch \| Configure Layout**.

# Merge Changes

Before merging, it is highly recommended to have a **clean working
copy** (no uncommitted local modifications or untracked files) and all
files and directories of the working copy should have the **same
revision** (no mixed-revision working copy).

To merge changes from a branch A to a branch B, first switch your
working copy to the branch B using **Modify \| Switch** (if branch B
already is checked out, then you don't need to switch, of course). Then
invoke the Merge command (**Modify \| Merge**) and select branch A as
"Merge from". If you don't want to merge all changes from the branch A,
but just a few ones, you may select "Revision Range" and select the
commits by clicking the periods-button. You actually *pull* changes from
the source branch into your current working copy state. If necessary,
fix some conflicts (using the Conflict Solver or **Modify \| Mark
Resolved**) and then commit the changes from the root directory of the
working copy (so the information of what has been merged - which is
stored in the `svn:mergeinfo` property of the project's root directory)
is actually committed with the other changes to your current branch B.
