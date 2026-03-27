# Worktrees

Git worktrees let you use the same repository in multiple working directories.
This is useful when you need to work on different branches at the same time without constantly switching the current working tree.

## Topics

- [Worktree state in the UI](#worktree-state-in-the-ui)
- [Adding a worktree](#adding-a-worktree)
- [Opening existing worktrees](#opening-existing-worktrees)
- [Switching to an existing worktree](#switching-to-an-existing-worktree)
- [Removing a worktree](#removing-a-worktree)
- [Pruning obsolete worktrees](#pruning-obsolete-worktrees)

## Worktree state in the UI

SmartGit marks local branches which belong to another worktree.
In the **Branches** view (and in the **Standard window**, also in **My History** and **Refs**) these branches are shown with a `(worktree)` suffix.
This marker is only shown for other worktrees.
The current branch of the current worktree is not marked as a separate worktree entry.

If SmartGit already knows the state of the related worktree, it also shows a colored dot before the `(worktree)` suffix (green for clean and orange for modified).

In the **Graph**, worktree-related refs are indicated directly on the ref itself.
The tooltip of such a ref also shows the path of the related worktree.

When multiple related worktrees are open in SmartGit, these indicators are refreshed automatically as branch assignments or working tree modifications change.

### Graph interactions

In the **Graph**, a ref that belongs to another worktree can only be dragged if that worktree is clean.
If the related worktree has local modifications, SmartGit keeps the ref non-draggable.

## Adding a worktree

Use **Add Worktree** to create another working tree for the current repository.

The dialog contains two basic fields:

- **Branch** selects the local branch that should be checked out in the new worktree.
- **Directory** selects the target directory for the new working tree.

Only existing local branches which do not already have an associated worktree are offered.
It does not create a new branch.
This also means that the current branch of the current worktree is not offered.
If no eligible branch remains, SmartGit will tell you so instead of opening the dialog.

SmartGit suggests a directory name automatically.
The suggestion is based on the current worktree directory and the selected branch.
If the current directory name already ends with the current branch name segment, SmartGit replaces that suffix.
Otherwise, it appends the selected branch name segment.
You can adjust it if necessary.

The target **Directory** must meet all of the following conditions:

- It must not be inside the current worktree.
- It must either not exist yet or be completely empty.

After the worktree has been created, SmartGit adds it as a repository and opens it.

## Opening existing worktrees

When you open the main working tree of a repository in SmartGit, SmartGit also creates repository entries for already existing linked worktrees.
This is useful if the worktrees were created outside SmartGit or already existed before you opened the repository.

In the **Standard window**, these worktrees can then be opened as sibling repository tabs.

## Switching to an existing worktree

For branch-based checkout actions, such as checking out a branch from the **Branches** view or the **Graph**, SmartGit checks whether that local branch is already attached to another worktree.
If it is, SmartGit does not try to check out that branch in the current working tree, but it switches to the existing worktree for that branch.
Depending on your confirmation settings, SmartGit may first ask whether it should switch to that worktree.
If you have disabled that confirmation before, SmartGit opens the worktree directly.

The target worktree does not need to be open already.
SmartGit can open it from the worktree path stored by Git.

If that stored path is no longer a valid worktree, SmartGit shows an error instead of switching.
In that case, fix the broken worktree or use **Prune Obsolete Worktrees**.

## Removing a worktree

Use **Remove Worktree** from the linked worktree that you want to remove.
This command is for linked worktrees only.
It does not remove the main working tree of the repository.

If the worktree is still open in another SmartGit window, SmartGit asks you to close it there first.
If Git reports an invalid worktree state, SmartGit aborts and shows the error details instead of trying to remove anything.

After a successful removal, SmartGit closes that repository and removes its repository entry.
Other open worktrees of the same repository are refreshed so that branch markers and worktree information are updated immediately.

## Pruning obsolete worktrees

Use **Prune Obsolete Worktrees** when Git still lists worktrees whose directories no longer exist.

If obsolete worktrees are found, SmartGit shows a confirmation dialog with every prune candidate as `path (branch)`.
Only after you confirm this list will SmartGit perform the actual prune.

After pruning, SmartGit removes repository entries for pruned worktrees that are no longer open.
If Git reports an invalid worktree state, SmartGit stops and shows the error instead.
