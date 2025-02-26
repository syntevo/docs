# Git Large File Storage (LFS)

[Git Large File Storage (LFS)](https://git-lfs.com/) is an optional extension to standard Git, allowing specific types of files (typically large or binary files) 
to be stored on a designated LFS Server, instead of within the Git repository. 
Once a file has been marked for LFS tracking, the committed file will be replaced by a 'pointer' file in the repository.

When working locally, if a Git-LFS aware client has been installed, files stored in LFS will be downloaded and will replace the pointer files 
in the [Working Tree](), providing a seamless user experience.

LFS files are stored using a **Content-Addressable Storage** schema, which computes the SHA-256 hash of the uploaded file to identify the file's content uniquely.

Git LFS functions by applying Git's `smudge` and `clean` filter command hooks on files that have been marked for LFS tracking in the `.gitattributes` configuration file.
- when cloning or fetching, the `smudge` filter retrieves the actual LFS file and replaces the file pointer in your working directory.
- conversely, when committing a file that is tracked by LFS, Git applies the `clean` filter, which replaces the file with a SHA-based pointer file.

When working with LFS, a `.gitattributes` file is created to track which files are managed by LFS.
This file should also be added to the repository so that all collaborators can work with LFS-tracked files consistently.

Git LFS also offers a `lock` option on files, which provides a pessimistic (or reserved) checkout mechanism.  This allows a user to exclusively modify an LFS-tracked file.
When such a file is committed, it receives a new SHA-based file location, and the pointer file is updated accordingly.

## Benefits
- The main Git repository remains leaner without large binary files, so operations like cloning are faster and consume less disk space.
- Collaborators who do not need to work with LFS files can choose to ignore them when cloning. In that case, they will see only the pointer files in their local working tree.
- Users or CI/CD pipelines that do not require the actual LFS files avoid using additional disk space.

**Additional Considerations:**
- If your repository already contains large files you wish to move to LFS, you may need to use tools like `git-filter-repo` to permanently remove them from a repository,
  by rewriting the commit history.
- Collaborators without the Git LFS client will only see pointer files instead of the actual binary files when they clone the repository.
- It is advisable to define your Git LFS strategy when the repsitory is first created, especially if large binary files are expected to be used in the project.

## Common LFS commands

The following command line options may be useful if you prefer manual interaction or want to understand the equivalent behavior in SmartGit:

#### Tip 
> If you are new to Git-LFS, there's a [GitHub tutorial](https://github.com/git-lfs/git-lfs/wiki/Tutorial) on how to use Git LFS from the command line. 
> However, we recommend using **[SmartGit's LFS features ](../Integrations/Git-LFS.md)** to handle much of the complexity involved in installing and managing LFS.

### Installing the LFS client on a local computer

`git lfs install`

*SmartGit command*: **Local \| LFS \| Install**

### Add specific file types to LFS

The following command will track existing and new `.png` files in LFS, replacing them with pointer files on commit:
 
 `git lfs track "*.png"`

 **SmartGit command**: 
 Select an untracked file in the *Files View* and invoke `Local | LFS | Track`. SmartGit will detect and suggest a matching pattern , 
 which you can adjust if needed.

### The .gitattributes File

As soon as any files are tracked by LFS, a `.gitattribute` file is created in the root of the working tree.
Be sure to add it to the repository:

`git add .gitattributes`

#### Note:
> Is is recommended not to manually edit the `.gitattributes` file.
> Instead, use SmartGit's File View or the `git lfs track` command to manage file tracking.

## Git LFS File Locking
LFS file locking enables exclusive modification rights for a file, preventing others from editing it while it's locked.

### Enforcing Reserved Checkout on a File or Pattern
Use the --lockable flag when tracking files to make them read-only until explicitly locked::

`git lfs track "*.png" --lockable`

This marks all matching files as read-only until locked. Lockable file information is stored in .gitattributes.

### Locking a LFS file for exclusive access

To lock a file for editing in the local working tree, use the `git-lfs lock` command to allow it to be edited in the local Working Tree.

`git lfs lock myfile.png`

To release the lock, use the `unlock` command.

`git lfs unlock myfile.png`

#### Tip

> If a file is locked by another user, use the `--force` flag to attempt to override the lock (requires appropriate permissions on the LFS server).
> `git lfs unlock myfile.png --force`

