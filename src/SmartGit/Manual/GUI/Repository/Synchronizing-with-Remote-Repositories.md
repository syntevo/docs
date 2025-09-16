# Synchronizing with Remote Repositories

Synchronizing the states of local and remote repositories involves **Pull**ing from, and **Push**ing to, a remote repository(ies).
SmartGit also has a **Synchronize** command that combines pulling and pushing.

## Pull

The Pull command fetches commits from a remote repository, stores them in the remote branches, and optionally 'integrates' these commits (i.e. by fast-forwarding, or by adding merge or rebase commits) into the local branch, depending on the nature of divergence of the branches, and the [configured preference](Repository-Settings.md#fetch-and-pull) for merge types.

Use **Remote \| Pull** (or the corresponding toolbar button) to invoke the Pull command.

This will open the Pull dialog, where you can specify what SmartGit will do after the commits have been fetched:

- If there is one remote configured for the repository, SmartGit will show the URL of the remote.
  However, if multiple remotes are currently tracked, SmartGit will allow you to select a remote to pull or fetch from.
- You can click **More Options** to customize the Pull (Note: These are only relevant if you select **Pull**. The options below are ignored with **Fetch Only**):
    - If a fast-forward is not possible, you have the choice whether to [Merge](../Branch/Merge.md) the local commits with the fetched commits, or [Rebase](../Branch/Rebase.md) the local commits onto the fetched commits.
    - **Update existing and fetch new tags** will also integrate any tag changes detected in the remote.
      By default, Git (and hence SmartGit) will only pull new tags, but won't update any changed tags in the remote repository.
    - **Remember as default for repository** will update the **Repository \| Settings** with the above new preferences. Additional options are available when working with the remote, which can be configured in the [Repository Settings](Repository-Settings.md).

The Pull Dialog has 3 buttons:

- **Pull** - will perform the pull in accordance with the above preferences.
- **Fetch Only** - will only fetch the latest commits from the selected remote.
- **Cancel** - closes the dialog without changes.

If a merge or rebase is performed after pulling, it may fail due to conflicting changes.
In that case SmartGit will leave the repository in a *merging* or *rebasing* state so you can either resolve the conflicts and proceed, or abort the operation.
See [Merge](../Branch/Merge.md), [Rebase](../Branch/Rebase.md), and the SmartGit [Conflict Solver](../Branch/Conflict-Solver.md) for details.

When rebasing, SmartGit will detect whether there are local merge commits which have to be rebased and in this case ask you whether you want to "preserve" these merge commits during the rebase or flatten the merge commits.

## Pulled vs. Fetched vs. Remote-Repository-Only Commits

Depending on the relative state of the local repository/working tree and the remote, three kinds of commits can be distinguished:

- **Remote-Repository-Only commits**: These are commits not yet present in your local repository.
  SmartGit will denote such kind of "incoming" commits by displaying a green arrow for the repository's node in the **Repositories** view if **Detect remote changes** has been selected in the [**Preferences \| Background commands**](../Preferences/Commands.md#background-commands) setting.
  To detect such commits, SmartGit uses a `git ls-remote` which is a light-weight operation which only reports remote repository branches together with their remote commit SHA.
  If the SHA is not yet present in the local repository for a specific branch, it is considered to have "incoming" commits.
  SmartGit does not have more information on these commits, not even the number of "incoming" commits.
  If you want to know more details about these commits and/or investigate them, it's usually safe to fetch them using **Remote \| Pull** with **Fetch Only** option.
- **Fetched commits**: are already present in the local repository, but not yet part of your HEAD's history.
  You can see and investigate these commits in the **Log** and perform various operations on them, e.g., **Merge**, **Rebase** onto a commit, or **Reset** your HEAD onto such a commit.
- **Pulled commits**: are part of your HEAD's history and their contents are present in your working tree.

## Push

The various Push commands allow you to push (i.e. send) your local commits to one or more remote repositories.
SmartGit distinguishes between the following Push commands:

- **Push** pushes all commits of the current branch (or the selected branch in the **Branches** view) to its tracked branch(es) on the remote(s).
  With this Push command you can push to multiple remotes repositories in a single action.
  SmartGit will detect automatically whether a *forced push* will be necessary.
  **Push** is available from any SmartGit Window (Working Tree, Standard, and Log).
- **Push To** pushes all commits in the current branch either to its matching branch, or to a *ref* specified by name.
  With the *Push To* command you can only push to one remote repository at a time.
  If multiple remote repositories have been tracked by your local repository, the *Push To* dialog will allow you to select the remote repository to push to.
  Also, the *Push To* command always allows to do a *forced* push, which can be convenient if you have changed the commit history on the branch, e.g. through use of **Rebase**.
  This is necessary when pushing to a *secondary* remote repository for which forcing the push may be necessary while it is not when pushing to the primary remote repository (i.e. the one which is considered by SmartGit's *forced push* detection).
  You can also invoke **Push To** on a remote to push (or *synchronize*) all branches from the selected remote to another remote.
- **Push Up To** (in the [Graph](../Graph-View.md) or [Journal](../Journal-View.md) Views) pushes all new commits up to, and including, the selected commit, rather than all commits, in the current branch to its tracked remote branch.

If you try to push commits from a new local branch, you will be asked whether to set up tracking for the newly created remote branch.
In most cases it is recommended to set up tracking, as it will allow you to receive changes from the remote repository and make use of Git's branch synchronization mechanism (see [Branches](../Branch/index.md)).
The preferences contains an option to avoid this dialog and always configure the tracking.

> [!NOTE]
> The tracking will **not** be configured if the git option `push.default` is set to `matching`.

The Push commands listed above can be invoked from several places:

- **Menu and toolbar** In the menu, you can invoke the various Pull and Push commands with **Remote \| Pull**, **Remote \| Push**, **Remote \| Push To**, and **Remote \| Push Commits**.
  **Remote \| Push** and **Remote \| Push To** may also be available as toolbar buttons, depending on your toolbar configuration.
  **Remote \| Push Commits** is only enabled if the **Journal** view is focused.
- **Repositories view** You can invoke **Push** in the **Repositories** view by selecting the open repository and choosing **Push** from the context menu.
- **Branches view** In the context menu of the **Branches** view, you can invoke **Push** and **Push To** on local branches.
  Additionally, you can invoke **Push** on tags.
- **Journal view** To push a range of commits up to a certain commit, select that commit in the **Journal** view and invoke **Push Commits** from the context menu.

> [!NOTE]
> If a Push fails with error:
>
>
>
>
> ``` text
> remote: error: refusing to update checked out branch: refs/heads/master
> remote: error: By default, updating the current branch in a non-bare repository
> remote: is denied, because it will make the index and work tree inconsistent
> remote: with what you pushed, and will require 'git reset --hard' to match
> remote: the work tree to HEAD.
> remote:
> remote: You can set the 'receive.denyCurrentBranch' configuration variable
> remote: to 'ignore' or 'warn' in the remote repository to allow pushing into
> remote: its current branch; however, this is not recommended unless you
> remote: arranged to update its work tree to match what you pushed in some
> remote: other way.
> remote:
> remote: To squelch this message and still keep the default behaviour, set
> remote: 'receive.denyCurrentBranch' configuration variable to 'refuse'.
> ```
>
>
>
> you have tried to push to a non-bare repository (a repository which has a working tree).
> Please either switch the remote to a different branch or -- better -- only push to bare repositories (repositories without a working tree).
>
> To create a **bare repository**, please invoke
>
> `$ git init --bare path/to/repository`

## Synchronize

With the Synchronize command, you can push local commits to a remote repository and pull commits from that repository at the same time.
This simplifies the common workflow of separately invoking [Push](#push) and [Pull](#pull) to keep your repository synchronized with the remote repository.

The Synchronize command can be invoked as follows:

- from the menu via **Remote \| Synchronize**, 
- with the Synchronize toolbar button, 
- and in the **Repositories** view via **Synchronize** in the repository's context menu.

From the toolbar button's options menu, you can configure whether to push or to pull first.

### Push, then Pull

If there are both local and remote commits, the invoked push operation fails.
The pull operation on the other hand is performed even in case of failure, so that the commits from the remote repository are available in the tracked branch, ready to be merged or rebased.
After the remote changes have been applied to the local branch, you may invoke the Synchronize command again.

### Pull, then Push

If there are both local and remote commits, the first triggered pull will fetch the remote changes, merge your local changes or rebase your local commits on top of the remote commits and, if this was successful, invokes the push.
This has the advantage that if there were no conflicts all your local changes are pushed.
The disadvantage is that it may push untested changes.
