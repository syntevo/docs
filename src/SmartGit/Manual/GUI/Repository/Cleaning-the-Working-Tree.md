# Cleaning the Working Tree

Use **Clean Working Tree** to delete unversioned content from the working tree.
This command only affects files and directories that are not tracked by Git.

## Clean dialog

The dialog has two independent choices.

First, choose what should be deleted:

- **Untracked**
- **Ignored**
- **Untracked and ignored**

Then choose whether only files or also directories should be removed:

- **Files**
- **Files and Directories**

## Safety checks

Before deleting anything, SmartGit performs a dry run and shows the exact files and directories that would be removed.
Only after you confirm that list does SmartGit perform the actual deletion.

If nothing matches the selected options, SmartGit reports that no files were found to be deleted.
Tracked files are not affected by this command.
