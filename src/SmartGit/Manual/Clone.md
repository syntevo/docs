# Clone

Use **Repository\|Clone** to create a clone of another Git repository.

Specify the repository to clone either as a remote URL (e.g.
[ssh://user@server:port/path](ssh://user@serverport.md)), or, if the
repository is locally available on your file system, as a file path. In
the **Selection** step you can configure whether submodules should be
fetched as well: usually you will have this option selected, because
submodules are an integral part of the main repository you are cloning.
You should deselect **Include Submodules** only, if you do not wish to
receive certain submodules. For details, refer to
[Submodules](Submodules.md).
Similarly, you will want to fetch the entire repository usually,
including all heads and tags. If you are only interested in a specific
head (branch) or tag, deselect **Fetch all Heads and Tags**. This allows
you to specify a single branch to fetch and optionally to not **Fetch
all commits** but **Fetch Only the Latest x commits.** Note that a few
Git commands do not work properly for such partial repositories (e.g.
Pull with Rebase). In the subsequent steps you have to provide the path
to the local directory where the clone should be created and a few clone
options.

If your server supports "partial clones", you may select **Skip large
files** and specify the maximum size of files (blobs) which will be
fetched for the initial clone (see below).

# Partial Clones


#### Note
> Partial Clones are an optimization to limit the size of local clones and
> by definition give non-complete local clones. SmartGit may require a
> connection to the repository when performing operations related to the
> omitted files.



Partial Clones are a great way to reduce the amount of space your clone
will require and thus the required time to perform the clone. Partial
Clones are especially helpful if your repository contains large (binary)
files which are not of significant interest to you. Only certain recent
Git servers support partial clones. When trying **Skip large files** on
a server which does not support partial clones, (Smart)Git will simply
error out.

Once the clone has finished, (Smart)Git will fetch all required blobs
(regardless of which size) to perform any subsequent Git operation on
this clone. For example, let's assume that your repository contains a
large file `large`:

-   For the initial clone `(git clone`) will not fetch any blobs related
    to `large`
-   Immediately after the clone, SmartGit will scan the working tree
    (`git status`) and therefore will fetch the blob which
    represents `large` in the HEAD commit
-   When selecting a different commit in the Log **Graph** for which
    which `large` has changed, SmartGit will fetch those two blobs
    representing `large` before and after the change
-   When invoking a **File Log** on `large`, SmartGit will fetch *all*
    blobs related to `large`
