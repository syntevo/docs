# Obfuscating a repository to report a problem


#### Warning
> This article refers to SmartGit version 7.1.4 which is the last version
> for which "obfuscation" is available. You can download this version from
> <https://www.syntevo.com/smartgit/download/archive/>.



Obfuscating a repository means building another repository which has the
same commit and file system structure as the original repository,
however file contents and file names are replaced by 'dummy' texts. In
this way, possibly confidential information is removed from the
repository.

Obfuscated repositories are helpful to debug *certain* kind of problems.
Following steps are necessary:

#### Preparation

-   Make sure the problem is *reproducible* with your *original*
    repository.
-   Open a terminal and `cd` to your repository root.

#### Obfuscate the repository

-   On Windows: execute
    `<install-dir>\bin\smartgitc.exe --obfuscate <temp-dir>\repo.obfuscated > mapping.txt`.
-   On MacOS: execute
    `<install-dir>/Contents/MacOS/SmartGit --obfuscate <temp-dir>/repo.obfuscated > mapping.txt`.
-   On Linux: execute
    `<install-dir>/bin/smartgit.sh --obfuscate <temp-dir>/repo.obfuscated > mapping.txt`.

This will give you an *obfuscated* repository in
`<temp-dir>/repo.obfuscated` and a `mapping.txt` in your current
repository root, which contains the output of the obfuscation process as
well as a mapping from *original* to *obfuscated* file names.

#### Report Problem

-   Open the *obfuscated* repository in SmartGit and make sure the
    problem is still reproducible: use `mapping.txt` to map file names
    from the *original* repository to the obfuscated repository.
-   Create an *ZIP* or *tar.gz* archive of the obfuscated repository and
    send it to *smartgit@syntevo.com*, together with a description and
    *obfuscated* file names on how to reproduce the problem. Be sure to
    *NOT* include `mapping.txt` in the email, as this file is just for
    you.
