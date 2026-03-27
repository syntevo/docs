# Worktrees

Git worktrees let you use the same repository in multiple working directories.
This is useful when you want to work on different branches at the same time without constantly switching the current working tree.

## Adding a worktree

Use **Add Worktree** to create another working tree for the current repository.

The dialog contains two basic fields:

- **Branch** selects the local branch that should be checked out in the new worktree.
- **Directory** selects the target directory for the new working tree.

Only local branches which do not already have an associated worktree are offered.
If no eligible branch remains, SmartGit will tell you so instead of opening the dialog.

SmartGit suggests a directory name automatically.
The suggestion is based on the current worktree directory and the selected branch.
You can adjust it if necessary.

The target **Directory** must meet all of the following conditions:

- It must not be inside the current worktree.
- It must either not exist yet or be completely empty.

After the worktree has been created, SmartGit adds it as a repository and opens it.
