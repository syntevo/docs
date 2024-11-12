# Synchronizing with Remote Repositories

Synchronizing the states of local and remote repositories consists of
pulling from and pushing to the remote repositories. SmartGit also has a
Synchronize command that combines pulling and pushing.

## Pull

The Pull command fetches commits from a remote repository, stores them
in the remote branches, and optionally 'integrates' (i.e. merges or
rebases) them into the local branch.

Use **Remote\|Pull** (or the corresponding toolbar button) to invoke the
Pull command. This will open the Pull dialog, where you can specify what
SmartGit will do after the commits have been fetched: Merge the local
commits with the fetched commits or rebase the local commits onto the
fetched commits. In the latter case, you can merge or rebase by hand, as
explained in [Merge](Merge.md)
and [Rebase](Rebase.md),
respectively. These options are meaningless, if you select to **Fetch
Only**.

The Pull dialog allows you to set your choice as default for the current
repository. More options can be configured in the
**Repository\|Settings**.

If a merge or rebase is performed after pulling, it may fail due to
conflicting changes. In that case SmartGit will leave the repository in
a *merging* or *rebasing* state so you can either resolve the conflicts
and proceed, or abort the operation. See
[Merge](Merge.md) and
[Rebase](Rebase.md) for
details.

When rebasing, SmartGit will detect whether there are local merge
commits which have to be rebased and in this case ask you whether you
want to "preserve" these merge commits during the rebase or flatten the
merge commits.

By default, Git (and hence SmartGit) will only pull new tags, but don't
update possibly changed tags from the remote repository. To have tags
updated as well, select **Update existing and fetch new tags**
from **More Options**.

## Pulled vs. Fetched vs. Remote-Repository-Only Commits

Regarding the presence in your repository/working tree you can
distinguish between three kinds of commits:

-   **Remote-Repository-Only commits**: are not yet present in your
    local repository. SmartGit will denote such kind of "incoming"
    commits by displaying a green arrow for the repository's node in the
    **Repositories** view if **Detect remote changes** has been selected
    in the **Preferences**, section **Background commands**. To detect
    such commits, SmartGit uses a `git ls-remote` which is a
    light-weight operation which only reports remote repository branches
    together with their remote commit SHA. If the SHA is not yet present
    in the local repository for a specific branch, it is considered to
    have "incoming" commits. SmartGit does not have more information on
    these commits, not even the number of "incoming" commits. If you
    want to know more details about these commits and/or investigate
    them, it's usually safe to fetch them using **Remote\|Pull**
    with **Fetch Only** option.
-   **Fetched commits**: are already present in the local repository,
    but not yet part of your HEAD's history. You can see and investigate
    such commits in the **Log** and perform various operations on it,
    especially you can **Merge** or **Rebase** onto such a commit or
    **Reset** your HEAD onto such a commit.
-   **Pulled commits**: are part of your HEAD's history and their
    contents are present in your working tree.

## Push

The various Push commands allow you to push (i.e. send) your local
commits to one or more remote repositories. SmartGit distinguishes
between the following Push commands:

-   **Push** pushes all commits of the current branch (or the selected
    branch in the **Branches** view) to its tracked branch. With this
    Push command you can push to multiple repositories in a single
    invocation. SmartGit will detect automatically whether a *forced
    push* will be necessary.
-   **Push To** pushes all commits in the current branch either to its
    matching branch, or to a *ref* specified by name. With the Push To
    command you can only push to one remote repository at a time. If
    multiple repositories have been set up, the Push To dialog will
    allow you to select the remote repository to push to. Also, the Push
    To command always allows to do a *forced* push, what can be
    convenient. This is necessary when pushing to a *secondary* remote
    repository for which forcing the push may be necessary while it is
    not when pushing to the primary remote repository (i.e. the one
    which is considered by SmartGit's *forced push* detection). You can
    also invoke **Push To** on a remote to push (or *synchronize*) all
    branches from the selected remote to another remote.
-   **Push Commits** pushes the selected range of commits from the
    **Journal** view, rather than all commits, in the current branch to
    its tracked remote branch.

If you try to push commits from a new local branch, you will be asked
whether to set up tracking for the newly created remote branch. In most
cases it is recommended to set up tracking, as it will allow you to
receive changes from the remote repository and make use of Git's branch
synchronization mechanism (see
[Branches](Branches.md)). The preferences
contains an option to avoid this dialog and always configure the
tracking.


#### Info 
> The tracking will **not** be configured if the git option `push.default`
> is set to `matching`.



The Push commands listed above can be invoked from several places:

-   **Menu and toolbar** In the menu, you can invoke the various Pull
    commands with **Remote\|Push**, **Remote\|Push To** and
    **Remote\|Push Commits**. The first two may also be available as
    toolbar buttons, depending on your toolbar configuration. The third
    command is only enabled if the **Journal** view is focused.
-   **Repositories view** You can invoke **Push** in the
    **Repositories** view by selecting the open repository and choosing
    **Push** from the context menu.
-   **Branches view** In the context menu of the **Branches** view, you
    can invoke **Push** and **Push To** on local branches. Additionally,
    you can invoke **Push** on tags.
-   **Journal view** To push a range of commits up to a certain commit,
    select that commit in the **Journal** view and invoke **Push
    Commits** from the context menu.


#### Note
> If a Push fails with error:  
>   
> 
> 
> 
> ``` java
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
> you have tried to push to a non-bare repository (a repository which has
> a working tree). Please either switch the remote to a different branch
> or - better - only push to bare repositories (repositories without a
> working tree).
> 
> To create a **bare repository**, please invoke
> 
> `$ git init --bare path/to/repository`  
  



  

## Synchronize

With the Synchronize command, you can push local commits to a remote
repository and pull commits from that repository at the same time. This
simplifies the common workflow of separately invoking [Push](#push) and
[Pull](#pull) to keep your repository synchronized with the remote
repository.

The Synchronize command can be invoked as follows:

-   from the menu via **Remote\|Synchronize**,
-   with the Synchronize toolbar button,
-   and in the **Repositories** view via **Synchronize** in the
    repository's context menu.

From the toolbar button's *options* menu, you can configure whether to
push or to pull first.

### Push, then Pull

If there are both local and remote commits, the invoked push operation
fails. The pull operation on the other hand is performed even in case of
failure, so that the commits from the remote repository are available in
the tracked branch, ready to be merged or rebased. After the remote
changes have been applied to the local branch, you may invoke the
Synchronize command again.

### Pull, then Push

If there are both local and remote commits, the first triggered pull
will fetch the remote changes, merge your local changes or rebase your
local commits on top of the remote commits and if this was successful,
invokes the push. This has the advantage that if there were no conflicts
all your local changes are pushed. The disadvantage is that it may push
untested changes.
