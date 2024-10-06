# Cherry-Picking

The `git cherry-pick` command allows you to apply one or more  commits from any other branch in the repository to the HEAD of the current branch.
Cherry-Picking is useful when you do **not** wish to apply **all** commits on a source branch to the current branch. 
If you aim to merge all commits from a source branch into the current branch, you should instead use [`git merge`](Merging.md) or [`git rebase`](Rebasing.md).

In the example below, we want to cherry-pick commit `C` from the branch `a-branch` into the HEAD of the current (target) `main` branch.

```
git checkout main  # Set the current branch as the target branch
git cherry-pick C  #
```

This will append a new commit C', equivalent to C, onto the `main` branch.

``` text
o                          o  C' [> main]
|                          |
o  [> main] A              o  A
|                          |
|   o  [a-branch]          |   o  [a-branch]
|   |                      |   |
o   |  B                   o   |  B
|   |                      |   |
|   o  C (selected)        |   o  C
|   |                      |   |
o   |  D       ===>        o   |  D
|  /     cherry-pick C     |  /
| /                        | /
o                          o
```

**Note**

- Cherry-picking commits should be done carefully. In the above example, after cherry-picking C`, a future attempt to merge `a-branch` into `main` could result in merge-conflicts because `C` and `C'` may conflict.
- If a conflict occurs during cherry-picking, the working tree will enter 'Cherry-Pick` status. You'll either need to resolve the conflict (e.g., using the [SmartGit Conflict Resolver](../GUI/Branching/Conflict-Solver.md)) and complete the cherry-pick or abort the cherry-pick attempt.

**See Also:** [Cherry Pick in SmartGit](../GUI/Branching/Cherry-Pick.md)
