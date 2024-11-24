# Excluding files in the Working Tree from inclusion in Staging

## Ignore

The **Local \| Ignore** command marks selected untracked files as `ignored`, which is useful for preventing files like compiled output, binary, debugging, and runtime log files from being added to the repository. Ignored files will no longer be indicated as 'untracked', so this reduces visual clutter and the risk of unintentionally adding these files.
If the option **Show Ignored Files** is selected, ignored files will still be displayed.

#### Note:

> SmartGit only displays ignored files in versioned directories.
> Ignored files or sub-directories within ignored directories are not shown for performance reasons.

When a file is marked as ignored in SmartGit, an entry is added to the `.gitignore` file in the same directory. 
The `.gitignore` file will be added to the repository if it isn't present.
To use more advanced Git ignore options, you may need to edit the `.gitignore` file(s) by hand, which will allow advanced patterns, 
such as entire folders, and files matching wild card patterns to be ignored.

#### Tip

> To view a list of ignored files or to understand why a specific file is *ignored*, use **Local\|Edit Ignore File**.

## Assume Unchanged

Invoke **Local \| Toggle 'Assume Unchanged'** (`assume-unchanged`) on selected modified files in the *Working Tree* to tell git that a file should not be checked for modifications, e.g. the file won't show up in a `git status` operation, even if the local file has changed.
This can be used on large files and slow O/S or I/O devices, where it is expensive to determine whether the file has been modified or not.

`Assume unchanged` files will no longer appear as modified and will not be included in the next commit.

To reverse this, toggle **Assume Unchanged** command again.

#### Note
> By default, SmartGit will hide files tagged with *Assume Unchanged* in the files view.
> *Assume Unchanged* files can be displayed by enabling **Show Assume-Unchanged Files** in the hamburger `☰` menu on the **Files View**.

## Skipped

The **Local \| Toggle 'Skip Worktree'** (`--skip-worktree`) command prevents changes to the selected tracked files from being added to the *Index*, and bypasses the check for local *Working Tree* modifications to the file.

This is similar to [Assume Unchanged](#assume-unchanged) but is more persistent, especially for commands like **Reset**.

Use the toggle command again to bring a file back into the *Index*.

#### Note
> By default, SmartGit will hide files tagged with *Skip Worktree* in the files view.
> *Skipped* files can be displayed by enabling **Show Skipped Files** in the hamburger `☰` menu on the **Files View**.
