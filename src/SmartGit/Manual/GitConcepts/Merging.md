# Merging

Merging branches is an essential and common operation within any Git repository, allowing changes in two or more branches to be combined.

> [!EXAMPLE]
> Examples of merging include:
> - When changes made in feature branches are complete and ready to be merged into a main branch, such as `main`.
> - When fixes have been made to a previous release and need to be merged back into a feature branch currently under development.

SmartGit supports all Git merge types.
Please refer to [Merging in SmartGit](../GUI/Branch/Merge.md) for further details.

## 'Normal' Merge Commit

A common merging technique is to use the `git merge` command, where two or more parent commits (i.e., the last commit on the current branch being merged into, and the last commit from the target branch being merged from) are combined, by creating a new 'merge' commit.
A merge commit is created when merging with `git merge --no-ff`, or when a fast-forward merge is not possible.

In the following example, we will merge the `a-branch` into the current branch `main`.
Before the merge, `main` points to `B` and `a-branch` points to `A`.
After the merge, a merge commit `M` is created to bring the changes in `a-branch` into `main`.
`M` will have two parent commits, `A` and `B`.

``` bash
git checkout main
git merge a-branch
```

**Before and After the Merge:**

{% include mermaid_compare.html before="merge-before.svg" after="merge-after.svg" before_alt="Before the merge, main points to B and a-branch points to A." after_alt="After the merge, main points to merge commit M and a-branch still points to A." %}

```mermaid {filename="merge-before.svg" hidden="true" branchpointers="true" source_title="Before Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "..."
   branch a-branch
   commit id: "A" tag: "a-branch"
   checkout main
   commit id: "B" tag: "main"
```

```mermaid {filename="merge-after.svg" hidden="true" branchpointers="true" source_title="After Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "..."
   branch a-branch
   commit id: "A" tag: "a-branch"
   checkout main
   commit id: "B"
   merge a-branch id: "M" tag: "main"
```

> [!NOTE]
> - When using merge commits, the full history of the feature branch is retained, which can be visually represented by tools such as SmartGit.
> - If conflicts arise during the merge due to concurrent changes to the current and merged branches, these conflicts must be resolved using a tool such as the [SmartGit Conflict Solver](../GUI/Branch/Conflict-Solver.md) before the merge commit can be completed.

## Fast-forward Merge

If the current branch is fully contained within the branch to be merged (i.e., the latter is simply a few commits ahead), no additional commits are necessary, and a `fast-forward` merge can be performed.

Unless configured otherwise, Git will attempt a fast-forward merge by default when possible.
A fast-forward merge can be forced with the `--ff-only` switch; however, the command will fail if a fast-forward merge is not possible (e.g., if both the current and merge branches contain new commits).

After a successful fast-forward merge, the branch pointer of the current branch is moved forward to match the branch pointer of the merge branch.
In the below, we're fast-forwarding commit B on `a-branch` onto the target `main` branch.
The HEAD of `main` and `a-branch` both now refer to commit `B`.

**Before and After the Fast-Forward Merge:**

{% include mermaid_compare.html before="fast-forward-before.svg" after="fast-forward-after.svg" before_alt="Before the fast-forward merge, main points to A and a-branch points to B." after_alt="After the fast-forward merge, main and a-branch both point to B." %}

```mermaid {filename="fast-forward-before.svg" hidden="true" branchpointers="true" source_title="Before Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "A" tag: "main"
   branch a-branch
   commit id: "B" tag: "a-branch"
```

```mermaid {filename="fast-forward-after.svg" hidden="true" branchpointers="true" source_title="After Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "A"
   branch a-branch
   checkout main
   commit id: "B" tag: "main" tag: "a-branch"
```

> [!NOTE]
> - Unlike merge commits, fast-forward merges create no additional commits in the repository.
> - Commits applied through fast-forward merges appear linearly in the target branch's history (e.g., in the above example, once `a-branch` is deleted, it will appear that commit `B` was committed directly onto `main` when viewing the `git log`).

## Squash Merge

A **squash merge** works like a normal merge, except that all the new commits on the merge branch are combined into a single new commit representing all changes.
A squash merge helps to keep a remote repository clean by producing a single commit representing all the changes made on a feature branch, which is then merged into the trunk branch.
A squash merge creates a new commit `S` on `main`, while `a-branch` remains on `C`.

**Before and After the Squash Merge:**

{% include mermaid_compare.html before="squash-merge-before.svg" after="squash-merge-after.svg" before_alt="Before the squash merge, a-branch contains commits A, B, and C while main points to D." after_alt="After the squash merge, main points to S while a-branch still points to C." %}

```mermaid {filename="squash-merge-before.svg" hidden="true" branchpointers="true" source_title="Before Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "..."
   branch a-branch
   commit id: "A"
   commit id: "B"
   commit id: "C" tag: "a-branch"
   checkout main
   commit id: "D" tag: "main"
```

```mermaid {filename="squash-merge-after.svg" hidden="true" branchpointers="true" source_title="After Mermaid source"}
%%{init: { 'gitGraph': {'showBranches': true, 'showCommitLabel': true, 'useMaxWidth': false}} }%%
gitGraph BT:
   commit id: "..."
   branch a-branch
   commit id: "A"
   commit id: "B"
   commit id: "C" tag: "a-branch"
   checkout main
   commit id: "D"
   commit id: "S" tag: "main"
```

> [!NOTE]
> - Squash merges help reduce commit history 'noise' when multiple commits are made to complete a feature (e.g., bug fixes or code review feedback has resulted in multiple commits on a feature branch before merging into a trunk branch such as `main`).
> - Squash merges may lose historical information about who made specific changes and when those changes were made on the feature branch.

## Merge versus Rebase

A Git-specific alternative to merging is **rebasing** (see *[Rebase](Rebasing.md)*), which can be used to keep a branch's history linear.
Interactive rebasing is an advanced feature that allows any number of commits in a branch's commit history to be modified, including:

- **Picking:** Including the commit in the rewritten commit history.
- **Squashing:** As with a squash commit, multiple commits are rewritten as one single commit.
- **Editing:** Changing the content of a previous commit.
- **Dropping:** Removing a commit from the history.
- **Rewording:** Modifying a commit message.

In addition to rebasing, SmartGit offers advanced branch cleanup features, such as:

- **Splitting** a commit into multiple commits.
- **Reordering** commits easily.

Please refer to [SmartGit's Interactive Rebase features](../GUI/Branch/Rebase-Interactive.md) for more details.

> [!EXAMPLE]
> If a user has added new commits on a local branch which tracks a remote repository branch which subsequently also has new commits, the user can either perform:
>
> - a **pull with merge**, which will create a merge commit with **two parent** commits:
>     1. The user's last commit on the local branch.
>     2. The last commit from the remote tracked branch.
> - Or, if using **rebase** instead of merge, Git applies the local commits on top of the commits from the tracked branch, avoiding a merge commit.
>   A new commit will represent the user's changes on the local branch.
