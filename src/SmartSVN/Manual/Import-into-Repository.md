# Import into Repository

Use **Project\|Import into Repository** to add an unversioned local
directory to the repository and to create the corresponding SmartSVN
project. Only the specified directory will be put under version control
using this command. Use the [Add](Add.md#Add-commands.add) and
[Commit](Commit.md#Commit-commands.commit) commands to import
other files and directories of the project individually into the
repository.

#### Page 'Local Directory'

Select the unversioned **Directory** which you want to import into the
repository.

#### Page 'Repository'

Choose the **Repository** into which you want to import.

#### Page 'Location'

After switching to this page, it takes a few moments until the first
level of the repository is scanned. If you look into deeper levels of
the repository by expanding the directory nodes, these levels will be
scanned also. For more details refer to [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser).
Use the **Create Directory** tool button to create new directories in
the repository.


#### Note
>
>
>You can create directories recursively in one go, by specifying the
>directories separated by `/`. This helps to avoid cluttering up the Log,
>as only one revision for creating all of these nested directories will
>show up.
>
>

After you've created the necessary directory structure in the
repository, select the directory that should be linked with the root of
your local project and click **Next**.

#### Page 'Project'

On this page you can configure to which project the imported working
copy will be added. You may select **Add a new project** for this
working copy, specify the project's name and specify an optional group
(see [Project Manager](Project-Manager.md#ProjectManager-project.manager) )
to which the project will be added. You may select **Add to current
project** to add the working copy to the currently open project (if
present). Or you may select **Don't manage as project** to just create a
temporary project for this working copy.

#### Configuring the project and doing the final import

The result of this command will be a new project, for which only the
local root directory is under SVN control. This gives you many
possibilities to configure which files/directories of your local file
system should actually be versioned in the repository. From the **Edit**
menu you can use **Add** and **Ignore** on files and directories.
Furthermore, for files you can adjust properties using the respective
commands from the **Properties** menu. After the project has been fully
configured, use **Modify\|Commit** to do the final import into the
repository.
