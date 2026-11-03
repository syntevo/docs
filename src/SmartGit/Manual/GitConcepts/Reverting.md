# Revert

The `git revert` command allows you to 'undo' the effect of unwanted commits by appending a new commit into the current branch.
The commit(s) identified to be reverted do not need to be contiguous or the most recent commits in the tree.
They can even be commits from another branch (e.g., if an unwanted commit has been squashed into the current branch, but there's another branch with the unsquashed commit).
SmartGit provides powerful UI tooling to allow you to [select and revert](../GUI/Branch/Revert.md) commits from a branch.

> [!NOTE]
> `git revert` creates a new commit to undo the effects of "unwanted" commits.
> It does **not** reset the *HEAD* of the affected branch back to a previous commit.
>
> `git revert` is often required when a bad commit has slipped into a remote branch (e.g., has already been pushed to `origin/main`), and auditing policies on the remote repository do not allow the commit history on important branches on the remote to be overwritten.
> With `revert`, the commit history will contain both the unwanted and the revert commits (unless further rewriting, such as a rebase or squash, is performed).

In some instances, such as undoing the most recent commit on a local branch that has not yet been pushed to a remote, it may be preferable to consider one of the following alternatives to `revert` to erase work in progress or commits from the local repository:

- `git checkout *commit*`: Create a new branch from when the unwanted commits were not present.
- `git cherry-pick *commits*`: Bring only specific commits from another branch into the current branch.
- `git rebase --onto`: Rewrite a range of commits onto a target branch.
- `git reset`: Undo changes in the local Repository, Index and/or Working Tree to return to a previous consistent state.

## Revert example

The example starts on `main` at commit `C`.
We want to undo the changes introduced by commit `B`.
Reverting appends `reverted-B` after `C` and keeps the earlier commits in the history.

{% capture revert_before_setup %}
```bash
git init -b main
echo A > a.txt
git add a.txt
git commit -m "A"
echo Change introduced by B > feature.txt
git add feature.txt
git commit -m B
git tag selected
echo C > c.txt
git add c.txt
git commit -m "C"
```
{% endcapture %}

{% capture revert_after_commands %}
```bash
# The following two commands are required 
# instead of the usual 
# git revert selected 
# when the default revert message
# Revert "B"
# shall not be used.
git revert --no-commit selected
git commit -m reverted-B
```
{% endcapture %}

{% include git_example.html
  title="Revert commit B"
  before="images/revert-before.png"
  before_alt="main points to C, with B as its parent."
  before_caption="main points to C, with B as its parent."
  before_width=189
  before_height=64
  after="images/revert-after.png"
  after_alt="main points to reverted-B, a new commit that undoes B."
  after_caption="main points to reverted-B, a new commit that undoes B."
  after_width=249
  after_height=84
  setup=revert_before_setup
  commands=revert_after_commands
%}
