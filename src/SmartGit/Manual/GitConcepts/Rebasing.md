# Rebasing

The Git `rebase` command allows you to apply commits from a source branch to another target branch *WITHOUT* creating a merge commit, resulting in a linear commit history on the target branch.
Rebase can be viewed as more powerful version of [Cherry-Pick](Cherry-Picking.md), optimized to apply multiple commits from one branch to another.

Since rebasing can be difficult to visualize, it is recommended that you use SmartGit when rebasing, where rebase operations can be performed in the UI, e.g., by simply selecting commits and dragging them to the required parent.
See [Rebasing in SmartGit](../GUI/Branch/Rebase.md).

Depending on the state of the source and target branches, rebase may result in:

- **Fast Forward** of new commits -- if there are no new commits on the target branch which are not present in the source branch, the target branch can simply be updated to 'point' at HEAD of the source branch without creating new commits.
- **Rewritten Commits** -- if there are new commits in both source and target branches, Git will need to rewrite commits in the target branch (assigning new SHA hashes).

In addition, `rebase` allows for advanced history rewriting and cleanup operations, such as squashing, deleting and modification of existing commits.

When rebase is used with the `onto` parameter, additional precision can be specified as to controlling which commits are to be rewritten, as well as to change the parent commit from which a branch is created.

After a successful rebase, the HEAD of the current branch will point to the rewritten fork containing the changes.

After branching at `A`, `main` has advanced with `B` and `C`, while `feature` has advanced with `D` and `E`.
Apply the rebase while `feature` is checked out to replay its commits on top of `main`.

{% capture rebase_before_setup %}
```bash
git init -b main
echo A > a.txt
git add a.txt
git commit -m "A"
git branch feature
echo B > b.txt
git add b.txt
git commit -m "B"
echo C > c.txt
git add c.txt
git commit -m "C"
git switch feature
echo D > d.txt
git add d.txt
git commit -m "D"
echo E > e.txt
git add e.txt
git commit -m "E"
```
{% endcapture %}

{% capture rebase_after_commands %}
```bash
git rebase main
```
{% endcapture %}

{% include git_example.html
  title="Rebase feature onto main"
  before="images/rebase-before.png"
  before_alt="main points to C and feature points to E; both branches start at A."
  before_caption="main points to C and feature points to E; both branches start at A."
  before_width=192
  before_height=104
  after="images/rebase-after.png"
  after_alt="feature contains rewritten D and E on top of C; main stays at C."
  after_caption="feature contains rewritten D and E on top of C; main stays at C."
  after_width=192
  after_height=104
  setup=rebase_before_setup
  commands=rebase_after_commands
%}

The rewritten commits keep the messages `D` and `E` in the screenshots.
The notation `D'` and `E'` below refers to their new commit IDs.

> [!NOTE]
> - Commits `D` and `E` are rewritten to `D'` and `E'` such that the parent of `D'` is now `C` (i.e. the HEAD of `main`).
>   In this rebase scenario, Git determines the common parent commit between the branches (`A`) and rewrites `D` and `E` on top of `main`.
> - Branch `main` (including commits `A`, `B`, and `C`) is not modified by the rebase.
> - After the above rebase, it is now possible to [Fast Forward](Merging.md#fast-forward-merge) `main` up to commit `E'`.
> - As can be seen, the effect is to create a linear commit history.

## Rebase onto

Rebase with the `--onto` switch allows for more advanced scenarios.
In the below example, since forking at commit `A`, `main` has 3 commits (`D`, `E`, and `F`) ahead, and `feature` has 2 commits (`B` and `C`) ahead.
We now wish to include commit `B` (currently on branch `feature`) into the `main` branch, but not to include commit `C`.
Additionally, we would like to specify that commit `B` is to be included before commits `D`, `E`, and `F`.

{% capture rebase_onto_before_setup %}
```bash
git init -b main
echo A > a.txt
git add a.txt
git commit -m "A"
git switch -c feature
echo B > b.txt
git add b.txt
git commit -m "B"
echo C > c.txt
git add c.txt
git commit -m "C"
git switch main
echo D > d.txt
git add d.txt
git commit -m "D"
echo E > e.txt
git add e.txt
git commit -m "E"
echo F > f.txt
git add f.txt
git commit -m "F"
```
{% endcapture %}

{% capture rebase_onto_after_commands %}
```bash
git rebase --onto feature~1 main~3
```
{% endcapture %}

{% include git_example.html
  title="Include B before the commits on main"
  before="images/rebase-onto-before.png"
  before_alt="main points to F while feature contains B and C after A."
  before_caption="main points to F while feature contains B and C after A."
  before_width=191
  before_height=124
  after="images/rebase-onto-after.png"
  after_alt="main includes B followed by rewritten D, E, and F; feature still points to C."
  after_caption="main includes B followed by rewritten D, E, and F; feature still points to C."
  after_width=191
  after_height=124
  setup=rebase_onto_before_setup
  commands=rebase_onto_after_commands
%}

The rewritten commits keep the messages `D`, `E`, and `F`.
The notation `D'`, `E'`, and `F'` below refers to their new commit IDs.

> [!NOTE]
> - The commit history of `main` will be rewritten -- although the commits `D'`, `E'`, and `F'` have the same changes as the original commits `D`, `E`, and `F` respectively, a new SHA hash will be assigned for each commit rewritten after the rebase is completed.
> - The commit history of `feature` is unchanged in this scenario -- commits `B` and `C` aren't modified by the above rebase.

## Interactive Rebase

Rebase with the `--interactive` switch allows a specified range of commits to be rewritten, and then, interactively, you will then need to specify how each commit in the range will be handled, with options such as:
- **pick** -- i.e., to include the commit.
- **reword** -- i.e., to include the commit but to change the commit message.
- **edit** -- i.e., to amend the contents of the commit.
- **squash** -- i.e., to combine the contents of the commit into the previous commit, i.e., reducing the number of commits.
  Squash can be applied successively, so that any number of commits are combined into one commit.
- **drop** -- i.e., remove the commit.

Additionally, the order of the commits can be changed during an interactive rebase.

See also: [Interactive Rebasing in SmartGit](../GUI/Branch/Rebase-Interactive.md).
