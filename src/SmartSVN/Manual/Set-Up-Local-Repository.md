# Set Up Local Repository

Use **Project\|Set Up Local Repository** to set up a new local SVN
repository and optionally *svnserve* to access this repository.

To use this command you need to have a local installation of the
*Subversion command line binaries*. You can download them from
<http://subversion.tigris.org>. It's recommended to have these binaries
and the necessary libraries on your operating system *path*. Enter the
full path to **svnadmin** and **svnserve**.


#### Note
>
>
>When proceeding with **Next** SmartSVN will perform some basic
>correctness checks on the chosen files by executing `svnadmin --version`
>and `svnserve --version`, respectively. Later on SmartSVN needs to be
>able to execute `svnadmin create [repository]` and
>`svnserve -d -r [repository-root]`, respectively.
>
>

On the **Repository** page, enter the **New Repository Location** where
the repository will be created.

On the **Username** page, enter a **Username** and **Password**; the
associated user which will have *write*-access to the newly created
repository. Anonymous access will be restricted to *read-only*.


#### Note
>
>
>SmartSVN will configure the file `conf/svnserve.conf` (in the selected
>repository directory) to use the password file `conf/passwd`. Later on
>you can add users and change usernames and passwords in this file.
>
>

Select **Proceed with importing files into the repository** to continue
with the [Import into Repository wizard](Import-into-Repository.md#ImportintoRepository-commands.create-module).
