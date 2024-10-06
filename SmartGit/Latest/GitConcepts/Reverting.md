# Revert

The `git revert` command allows you to 'undo' the effect of unwanted commits by appending a new commit into the current branch.
The commit(s) identfied to be reverted do not need to be contiguous or the most recent commits in the tree. They can even be commits from another branch (e.g., if an unwanted commit has been squashed into the current branch, but there's another branch with the unsquashed commit). 
SmartGit provides powerful UI tooling to allow you to [select and revert](../GUI/Branching/Revert.md) commits from a branch.

**Note:** 

`git revert` creates a new commit to undo the effects of "unwanted" commits. It does **not** reset the *HEAD* of the affected branch back to a previous commit.

`git revert` is often required when a bad commit has slipped into a remote branch (e.g., has already been pushed to `origin\main`), and auditing policies on the remote repository do not allow the commit history on important branches on the remote to be overwritten. With Revert, the commit history will contain both the unwanted and the revert commits (unless further rewriting, such as a rebase or squash, is performed).

In some instances, such as undoing the most recent commit on a local branch that has not yet been pushed to a remote, it may be preferable to consider one of the following alternatives to `revert` to erase work in progress or commits from the local repository:

- `git checkout *commit*`: Create a new branch from when the unwanted commits were not present.
- `git cherry-pick *commits*`: Bring only specific commits from another branch into the current branch.
- `git rebase --onto`: Rewrite a range of commits onto a target branch.
- `git reset`: Undo changes in the local Repository, Index and/or Working Tree to return to a previous consistent state.

## Revert Example

In the example below, we want to "undo" the effects of unwanted commit `B` on the current branch `main` by running the following command:

`git revert B`

This will append a new commit onto `main`, representing the changes needed to undo the effects of commit `B`:

``` text
                         o  reverted-B  [> main]
                         |
o  [> main] C            o  C
|                        |
o B (selected)           o  B
|                        |
o A                      o  A
```
