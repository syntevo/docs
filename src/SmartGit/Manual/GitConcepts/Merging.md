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

{% capture merge_before_setup %}
```bash
git init -b main
echo Example repository > README.md
git add README.md
git commit -m "..."
git switch -c a-branch
echo A > a.txt
git add a.txt
git commit -m "A"
git switch main
echo B > b.txt
git add b.txt
git commit -m "B"
```
{% endcapture %}

{% capture merge_after_commands %}
```bash
git merge --no-ff a-branch -m M
```
{% endcapture %}

{% include git_example.html
  title="Merge a-branch into main"
  before="images/merge-before.png"
  before_alt="main points to B and a-branch points to A."
  before_caption="main points to B and a-branch points to A."
  before_width=202
  before_height=64
  after="images/merge-after.png"
  after_alt="main points to merge commit M, with B and A as its parents."
  after_caption="main points to merge commit M, with B and A as its parents."
  after_width=202
  after_height=84
  setup=merge_before_setup
  commands=merge_after_commands
%}

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

{% capture fast_forward_before_setup %}
```bash
git init -b main
echo A > a.txt
git add a.txt
git commit -m "A"
git switch -c a-branch
echo B > b.txt
git add b.txt
git commit -m "B"
git switch main
```
{% endcapture %}

{% capture fast_forward_after_commands %}
```bash
git merge --ff-only a-branch
```
{% endcapture %}

{% include git_example.html
  title="Fast-forward main to a-branch"
  before="images/fast-forward-before.png"
  before_alt="main points to A; a-branch is one commit ahead at B."
  before_caption="main points to A; a-branch is one commit ahead at B."
  before_width=182
  before_height=44
  after="images/fast-forward-after.png"
  after_alt="main and a-branch both point to B; no merge commit was created."
  after_caption="main and a-branch both point to B; no merge commit was created."
  after_width=240
  after_height=44
  setup=fast_forward_before_setup
  commands=fast_forward_after_commands
%}

> [!NOTE]
> - Unlike merge commits, fast-forward merges create no additional commits in the repository.
> - Commits applied through fast-forward merges appear linearly in the target branch's history (e.g., in the above example, once `a-branch` is deleted, it will appear that commit `B` was committed directly onto `main` when viewing the `git log`).

## Squash Merge

A **squash merge** works like a normal merge, except that all the new commits on the merge branch are combined into a single new commit representing all changes.
A squash merge helps to keep a remote repository clean by producing a single commit representing all the changes made on a feature branch, which is then merged into the trunk branch.
A squash merge creates a new commit `S` on `main`, while `a-branch` remains on `C`.

{% capture squash_merge_before_setup %}
```bash
git init -b main
echo Example repository > README.md
git add README.md
git commit -m "..."
git switch -c a-branch
echo Change A > feature.txt
git add feature.txt
git commit -m A
echo Change B >> feature.txt
git commit -am B
echo Change C >> feature.txt
git commit -am C
git switch main
echo D > d.txt
git add d.txt
git commit -m "D"
```
{% endcapture %}

{% capture squash_merge_after_commands %}
```bash
git merge --squash a-branch
git commit -m S
```
{% endcapture %}

{% include git_example.html
  title="Squash a-branch into main"
  before="images/squash-merge-before.png"
  before_alt="a-branch contains A, B, and C; main points to D."
  before_caption="a-branch contains A, B, and C; main points to D."
  before_width=202
  before_height=104
  after="images/squash-merge-after.png"
  after_alt="S combines the changes from a-branch and has only D as its parent."
  after_caption="S combines the changes from a-branch and has only D as its parent."
  after_width=202
  after_height=124
  setup=squash_merge_before_setup
  commands=squash_merge_after_commands
%}

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
