# Copy Within Repository

With **Modify\|Copy Within Repository** you can perform copy operations
that take place entirely within a repository. This is for instance a
convenient and fast way to create repository tags/branches.

Select the **Repository** within which the copy should be performed.
**Copy From** and the **Source Revision** specify the copy source. For
**Copy** you can either select to copy **To** or to copy **Contents
Into**. In case of copy **To**, the source will be copied into
**Directory** with its name set to **With Name** (last component of the
path). For copy **Contents Into**, the contents (files and directories)
of the source will be copied directly into the **Directory** with their
corresponding names. Because the copy is directly performed in the
repository, you have to specify a **Commit Message**.


#### Note
>
>
>This copy operation is in fact no local operation, as it requires no
>working copy. Due to its close relationship with the other copy
>operations we have nevertheless put it into the chapter 'Local
>Modifications'.
>
>
