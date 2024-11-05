# Fix

Use **Modify\|Fix** to fix (or 'repair') the selected directory/files.
This option is only applicable for certain, unusual working copy states:

#### Case-changed files

SVN repositories and working copies are in general case-sensitive. This
can cause problems when working on a case-insensitive operating system,
like Microsoft Windows or certain file systems on Apple Mac OS, and
changing the file name's case (upper-case to lower-case, etc.). Because
of SVN's working copy format and the *pristine* copies, it's technically
not possible to handle such a file name case change.

One solution is to avoid this situation by either only performing file
name case changes on an operating system which supports case-sensitive
file names, or directly in the repository by using the [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser)
.

At any rate, a file name case change may happen on a case-insensitive
operating system, e.g. because of defect software tools, etc. SmartSVN
detects such invalid changes and puts the file into *case-changed* file
state, see [Rare Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states2).
**Fix** will now change back the file name case to its original form as
found within the pristine copy, resolving this problem.

#### Nested Roots

A *nested root* (see [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states))
is a working copy within another working copy which is not related to
this parent working copy. SVN commands ignore such nested roots; they
are simply treated as *unversioned* directories.

Nested roots typically result from moving a directory from one location
to another without using the proper SVN commands, like
[Move](Move.md#Move-commands.move). This leaves a *missing*
directory at its original location and introduces a *nested root* at its
current location.

**Fix** offers the following solutions for *nested roots*, depending on
their origin:

-   **Mark as Copied** will convert the nested root to a *copied*
    directory, with its copy location being the original repository
    location. This option is only available if the current location is
    part of the same repository as the original location.
-   **Convert to Unversioned** strips off the working copy metadata
    (.svn directories) for this directory and all of its children. This
    will make the directory *unversioned*, so it can be added and
    committed afterwards. This option is always available but in general
    should only be used if **Mark as Copied** is not available, as
    *unversioned* directories can be added afterwards, but their history
    will be lost.

#### Added-missing directories

If a directory has been scheduled for addition (see
[Add](Add.md#Add-commands.add)) and has been locally deleted
afterwards (i.e. the directory and its `.svn` subdirectory are missing),
the directory is in *Added-missing* state (see [Primary Directory States](Directory-Tree-and-File-Table.md#primary-directory-states)).

Such directories are actually only a leftover entry in the parent
directory's metadata directory (.svn). The resolution is to
[Revert](Revert.md#Revert-commands.revert) them, which is what
this command will do.
