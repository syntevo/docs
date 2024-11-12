# Git Concepts

This section helps you to get started with Git and gives you an
understanding of the fundamental Git concepts.

## Repository, Working Tree, Commit

First, we need to introduce some Git-specific terms which may have
different meanings in other version control systems such as Subversion.

Classical centralized version control systems such as Subversion (SVN)
have so-called \`working copies', each of which corresponds to exactly
one repository. SVN working copies can correspond to the entire
repository or just to parts of it. In Git, on the other hand, you always
deal with (local) repositories. Git's *working tree* is the directory
where you can edit files and it is part of a repository. So-called *bare
repositories*, used on servers as central repositories, don't have a
working tree.



#### Example
>
>
>
>Let's assume you have all your project-related files in a directory
>`D:\my-project`. Then this directory represents the repository, which
>consists of the working tree (containing all files to edit) and the
>attached repository meta data which is located in the
>`D:\my-project\.git` directory.
>
>

## Typical Project Life Cycle

As with all version control systems, there typically exists a central
repository containing the project files. To create a local repository,
you need to *clone* the *remote* central repository. Then the local
repository is connected to the remote repository, which, from the local
repository's point of view, is referred to as *origin*. The cloning step
is analogous to the initial SVN checkout for getting a local working
copy.

Having created the local repository containing all project files from
*origin*, you can now make changes to the files in the working tree and
*commit* these changes. They will be stored in your local repository
only, so you don't even need access to a remote repository when
committing. Later on, after you have committed a couple of changes, you
can [push them to the remote repository](Synchronizing-with-Remote-Repositories.md#push).
Other users who have their own clones of the origin repository can [pull from the remote repository](Synchronizing-with-Remote-Repositories.md#pull)
to get your pushed changes.
