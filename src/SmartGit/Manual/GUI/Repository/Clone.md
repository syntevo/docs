# Cloning Repositories

Use the **Repository \| Clone** option to create a clone of an existing Git repository on your local computer.

In the **Repository** tab, specify the repository to clone by either:
- Providing a remote URL, for example:
  - `ssh://user@server:port/path` if using SSH.
  - `https://user@server:port/path` if using HTTPS.
- If the repository is locally available on your file system, by specifying the file path.
- If one or more [Hosting Provider integrations](../../Integrations/Integrated-Cloning.md) have been configured, click on the connected Hosting Provider icon and use the navigation to select an available repository.

Clicking **Next** will display the **Selection** step, where you can configure whether the repository's submodules should also be cloned.
Typically, this option should be selected, as submodules are an integral part of the main repository you are cloning.

**Include Submodules** should be deselected only when you do not need to clone specific submodules.
For more details, refer to the [Submodules documentation](../../GitConcepts/Submodules.md).

Usually, you will want to fetch the entire commit history of the repository, including all branches (heads) and tags.
However, deselect **Fetch all Heads and Tags** if you are only interested in a specific branch (head) or tag for very large repositories.
This allows you to control which branch to fetch and optionally choose not to **Fetch all commits** but instead **Fetch Only the Latest x commits** for a shallow clone to a depth of **x** commits.

#### Note

- Some Git commands do not work correctly with partial repositories (e.g., Pull with Rebase), and tools like GitVersion may not work correctly with partial clones.

In the subsequent steps, you must provide the path to the local directory where the clone should be created and configure a few options.

If your server supports [partial clones](https://git-scm.com/docs/partial-clone), you can select **Skip large files** to specify the maximum file size of binary files (blobs) to be fetched during the initial clone (see below).

## Partial Clones

Partial Clones are an effective way to reduce the amount of space required by your clone and the time needed to perform the clone.
They are beneficial if your repository contains large (binary) files that are not interesting.

#### Note

- Partial Clones provide an optimization to reduce the size of local clones, and by definition, they will not clone the entire repository to the local file system.
  SmartGit will require a connection to the remote repository when any operation relating to the omitted files is attempted.
- Not all Git servers support partial clones.
  If you try to **Skip large files** on a server that does not support partial clones, SmartGit will report an error.

Once the clone is complete, SmartGit will fetch all required blobs (regardless of size) to perform subsequent Git operations on this clone.
For example, let's assume that your repository contains a large file named `large`:

- The initial clone (`git clone`) will not fetch any blobs related to `large`.
- Immediately after the clone, SmartGit will scan the working tree (`git status`) and fetch the blob representing `large` in the `HEAD` commit.
- SmartGit will fetch the two blobs representing `large` before and after the change when selecting a different commit in the Log **Graph** where `large` has changed.
- When invoking a **File Log** on `large`, SmartGit will fetch *all* blobs related to `large`.
