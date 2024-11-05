# Check Out

Use **Project\|Check Out** to create a working copy from a project which
is already under SVN control.

#### Page 'Repository'

The first step is to enter the **URL** of the repository you want to
check out from. On the subsequent pages you will be able to specify a
subdirectory within the repository, so you don't have to append the
subdirectory to the repository URL on this page.

Click **Next** to continue.

#### Page 'Location'

After switching to this page, the repository will be scanned. A few
moments later you'll see the root content of the repository. Expand the
tree nodes to scan into the repository structure. For details refer to
[Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser).

Use **Show Revision** to define the revision of your selected directory
that you want to check out. Please note that the repository contents
might change when changing the revision.

Select the repository directory you want to check out and click
**Next**.

When working with *trunk*, *tags* and *branches* it's not recommended to
check out the whole project, because due to the increasing number of
tags the working copy (not the repository) would be growing quickly,
over time accumulating a lot of unneeded files on your disk. Instead you
should check out only *trunk* or a certain tag or branch and if
necessary [switch](Switch.md#Switch-commands.switch) to
another location. SmartSVN tries to detect whether you are going to
check out a whole project instead of a single trunk/branch and will warn
you accordingly.

Sometimes you won't need to check out the complete trunk/branch of a
project, but only a certain sub-directory. Certain features (such as
tags) won't work on sub-directories, hence SmartSVN will ask you whether
to check out necessary parent directory non-recursively. Such
non-recursive check outs (also called 'sparse checkouts') are efficient
and recommended in a situation like this.

#### Page 'Local Directory'

On this page you can select the local directory into which the working
copy should be checked out. Use the options to define how the directory
name should be created. The **Checkout Directory** depends on these
options and always shows the final directory into which the checkout
will occur (i.e. where the root `.svn`- directory will be created).

When deselecting **Check out recursively**, you will only check out the
selected repository directory itself, but no subdirectories. Later you
may choose to check out certain subdirectories with [Update More](Update-More.md#UpdateMore-commands.update-more) .
Non-recusive checkouts can be useful if you wish to skip certain
*modules* of a project.

Click **Next** to proceed.

#### Page 'Project'

On this page you can select whether to check out a working copy, i.e. to
create the necessary `.svn/` structure, or to simply **Export** the
files from the repository.

With **Check out a working copy**, SmartSVN will create a working copy
for your checkout source. In this case you may select **Add a new
project** for this working copy, specify the project's name and specify
an optional group ([Project Manager](Project-Manager.md#ProjectManager-project.manager) )
to which the project will be added. You may select **Add to current
project** to add the working copy to the currently open project (if
present). Or you may select **Don't manage as project** to just create a
temporary project for this working copy.

With **Export only**, SmartSVN will just export the files from
repository without creating the `.svn/` subdirectory, meaning you won't
be able to perform the usual SVN commands on these exported directories
and files.

Click **Next** to proceed.
