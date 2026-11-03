# Cherry-Picking

The `git cherry-pick` command allows you to apply one or more commits from any other branch in the repository to the HEAD of the current branch.
Cherry-picking is useful when you do **not** wish to apply **all** commits on a source branch to the current branch.
If you aim to merge all commits from a source branch into the current branch, you should instead use [Merge](Merging.md) or [Rebase](Rebasing.md).

In the example below, we want to cherry-pick commit `C` from the branch `a-branch` into the HEAD of the current (target) `main` branch.

This will append a new commit `C'`, equivalent to `C`, onto the `main` branch.

{% capture cherry_pick_before_setup %}
```bash
git init -b main
echo Example repository > README.md
git add README.md
git commit -m "..."
git switch -c a-branch
echo C > c.txt
git add c.txt
git commit -m "C"
git tag selected
echo More work on a-branch > continuation.txt
git add continuation.txt
git commit -m "..."
git switch main
echo A > a.txt
git add a.txt
git commit -m "A"
echo B > b.txt
git add b.txt
git commit -m "B"
echo D > d.txt
git add d.txt
git commit -m "D"
```
{% endcapture %}

{% capture cherry_pick_after_commands %}
```bash
git cherry-pick selected
```
{% endcapture %}

{% include git_example.html
  title="Cherry-pick C onto main"
  before="images/cherry-pick-before.png"
  before_alt="main points to D; C lies on a-branch."
  before_caption="main points to D; C lies on a-branch."
  before_width=209
  before_height=124
  after="images/cherry-pick-after.png"
  after_alt="main has a new copy of C after D; a-branch retains the original C."
  after_caption="main has a new copy of C after D; a-branch retains the original C."
  after_width=189
  after_height=144
  setup=cherry_pick_before_setup
  commands=cherry_pick_after_commands
%}

> [!NOTE]
> Cherry-picking commits should be done carefully.
> In the above example, after cherry-picking `C`, a future attempt to merge `a-branch` into `main` could result in merge-conflicts because `C` and `C'` may conflict.
> If a conflict occurs during cherry-picking, the working tree will enter 'Cherry-Picking' status.
> You'll either need to resolve the conflict (e.g., using the [SmartGit Conflict Resolver](../GUI/Branch/Conflict-Solver.md)) and complete the cherry-pick or abort the cherry-pick attempt.

### See also

[Cherry Pick in SmartGit](../GUI/Branch/Cherry-Pick.md)