# Update

Use **Modify\|Update** to get the latest changes or a specific revision
from the repository for the selected files/directory.

Select **HEAD** to get the latest changes. To get a revision, select
**Revision** and enter the revision number. Select **Recurse into
subdirectories** to perform the update command not only for the current
selected directory, but also for all subdirectories.

#### Advanced options

For *sparse working copies*, the Update will not pull in
files/directories of repository subtrees that haven't been checked out
yet. Select **Set depth to working copy** to get new subtrees as well
(according to the selected **Depth** option).

When selecting **Allow unversioned obstructions**, SmartSVN will
continue to update new files from the repository for which locally
unversioned files already exist. Otherwise the update will be cancelled
in such situations, giving you the chance to cleanup these locally
unversioned files beforehand.

Use **Include Externals** to descend into
[externals](Externals.md#Externals-commands.externals).
