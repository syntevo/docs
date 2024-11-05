# Setting up submodules

Git's submodules allow you to embed one Git repository within another.
This page explains how to set up submodules using SmartGit.

## Adding Submodules

New submodules can be added to an existing Git repository as follows: In
the *Repositories* view of the main window, select the folder into which
the new submodule should be inserted. Then, from the program menu select
**Remote\|Submodule\|Add**. In the wizard that shows up, specify a
folder name for the new submodule and a URL pointing to the submodule's
repository. On pressing the Finish button on the wizard's last page,
SmartGit will start checking out the submodule's contents from its
repository.

## Initializing and Updating Submodules

Submodules will be updated and initialized by **Pull**, according to
following options which can be configured in **Repository\|Settings**:

-   **Update registered submodules**
-   **Initialize new submodules**

See the Git documentation on the commands `git submodule update` and
`git submodule init` for more information about these two operations.
