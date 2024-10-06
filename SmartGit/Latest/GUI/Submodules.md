# Submodules

Often, software projects are not completely self-contained, but share
common parts with other software projects. Git offers a feature called
*submodules*, which allows you to embed one Git repository into another.

A submodule is a nested repository that is embedded in a dedicated
subdirectory of the working tree (which belongs to the parent
repository). The submodule is always pointing at a particular commit of
the embedded repository. The definition of the submodule is stored as a
separate entry in the parent repository's git object database.

The link between working tree entry and foreign repository is stored in
the `.gitmodules` file of the parent repository. The `.gitmodules` file
is usually versioned, so it can be maintained by all users and/or
changes are propagated to all users.

Setting submodule repositories involves an initialization process, in
which the required entries are added to the `.git/config` file. The user
may later adjust it, for example to fix SSH login names.

## Submodules in the UI

A submodule usually shows up in SmartGit's UI at the same time in the
**Repositories** view and in the **Files** view. Operations from the
main menu depend on whether the **Repositories** view or the **Files**
is focussed:

-   The **Repositories** view offers operations in the submodule
    repository itself: e.g. you can invoke a **Log** here to see the
    history of the submodule repository or you can invoke
    **Remote\|Submodule\|Initialize** to initialize all sub-submodules
    contained in the selected submodule.
-   The **Files** view offers operations on the submodule pointer from
    perspective of the parent repository: e.g. you can invoke a **Log**
    here to see how the submodule-pointer has changed over time or you
    can invoke **Remote\|Submodule\|Initialize** to initialize the
    selected submodule itself (if it is not yet initialized).

## Cloning Repositories with Submodules

If you clone an existing repository containing one or more submodules
via **Repository\|Clone**, make sure the option **Include Submodules**
is selected, so that all first-level submodules are automatically
initialized and updated. Without this option, you may initialize the
submodules later by hand via **Remote\|Submodule\|Initialize**. Only
performing the initialization will leave the submodule directory empty.
For a fully functional submodule, you'll also need to do a pull on it,
as described in [Updating Submodules](#updating-submodules).

## Adding, Removing and Synchronizing Submodules


#### Note
>
>
>Submodules are showing up in the **Repositories** as well as the
>**Files** view. Submodule operations (from the parent repository
>perspective) will be performed in the **Files** view. 'Normal' Git
>operations on the submodule repository itself will be performed in the
>**Repositories** view.
>
>

To "ignore" a not-yet initialized submodule which you are not interested
in, invoke **Remote\|Submodule\|Deactivate**. This will make the
submodule vanish from the **Files** view unless **View\|Show Ignored
Files** is selected. Technically, `submodule.<name>.active=false` will
be set in the parent repository `.git/config`.

To remove a submodule from the working tree, select the submodule in the
**Files** view, invoke **Remote\|Submodule\|Deinit**. After *deiniting*
you will probably want to **Deactivate** it, too.

To add a new submodule to a repository, invoke
**Remote\|Submodule\|Add** on the repository in the **Repositories**
view and follow the dialog instructions.

To remove a submodule from the repository, select the submodule in the
**Files** view, invoke **Remote\|Submodule\|Unregister**, and then
commit your changes. After the submodule is unregistered, you may delete
the submodule directory.

If the URL of a submodule's remote repository has changed, you need to
modify the URL in the `.gitmodules` file and then *synchronize* the
submodule, via **Remote\|Submodule\|Synchronize**, so that the new URL
is written into Git's configuration.

## Updating Submodules

After a submodule has been set up, the usual workflow is that some files
in the submodule repository are modified externally, and you perform an
*update* on the submodule, i.e. you pull the new changes into your local
submodule repository. You can perform an update either by doing a pull
on the submodule itself, or, if the outer repository is connected to a
remote repository, by configuring SmartGit to automatically update all
submodules when you do a pull on the outer repository. These two cases
will be described in the following subsections. Note that in either
case, pulling will fetch new commits without changing the submodule if
it has a *detached HEAD*. See [Working within Submodules](#working-within-submodules) for more information on the
latter.

### Pulling on the Submodule

Select the submodule in the **Repositories** view and invoke
**Remote\|Pull**. After the pull, the submodule will have a different
appearance in the **Repositories** view if new commits have been fetched
and a rebase or merge has been performed. This different appearance
indicates that the submodule has changed and that you need to
[commit](Local-Operations-on-the-Working-Tree.md#commit) the
change in the outer repository.

### Pulling on the Outer Repository

Open the repository settings via **Repository\|Settings**, and in the
**Pull** section, enable **Update registered submodules**, so that
SmartGit automatically updates all registered submodules when pulling on
the outer repository. Additionally, you may also enable **And initialize
new submodules**; with this, SmartGit will update not only registered
submodules when pulling, but also uninitialized submodules, after having
initialized them. The aforementioned **Update** option will only fetch
commits as needed, i.e. when a commit is referenced by the outer
repository as the current state of the submodule. If you want to fetch
all new commits instead, enable the option **Always fetch new commits,
tags and branches from submodule**. Note that when you do a pull on the
outer repository, you need to pull with subsequent rebase or merge,
otherwise new submodule commits will only be fetched, without changing
the submodule state (i.e. the commit the submodule is currently pointing
at).

## Working within Submodules

You can view the history of a submodule repository by opening its
[Log](Log.md). To do so, select the submodule in the
**Repositories** view and invoke **Log** from the submodule's context
menu. You can also restrict the Log to a certain branch within the
submodule: Select the submodule in the **Repositories** view, then
select the submodule branch in the **Branches** view, and then invoke
**Log** from the context menu of the branch.

In the submodule Log, you can switch the submodule to another commit by
selecting the commit in the Log graph and invoking **Check Out** from
the commit's context menu. If you want to switch to the tip of a certain
branch, you can also just double-click on the branch in the **Branches**
view.

After switching the submodule to another commit, the submodule will be
shown as 'changed' in the **Files** view. That means you can either
commit the change in the outer repository or roll back the change. For
the latter, select the submodule in the **Files** view and invoke
**Reset** from its context menu.

If you modify and commit files within the submodule (as part of the
outer repository, not externally), the submodule will also show up as
'changed'. Then, after committing the changes, you can push them back to
the remote submodule repository via **Push** from the context menu of
the **Branches** view. Note that you may lose your work in the submodule
if you make changes on a *detached HEAD*. To avoid this, check out a
submodule branch before making the changes.

## Submodule States and Transitions

Icon | State | Description
-------- | -------- | --------
![](attachments/submodule-icons/uninitialized.png)| Uninitialized   | The submodule has not yet been initialized. <ul><li> Use **Initialize** or **Pull** to initialize/fetch this submodule.</li><li>Use **Deactivate** to get the submodule rid from the **Files** view. It will only show up if **View\|Show** Ignored Files is selected.</li><li>Use **Unregister** to remove the submodule from the repository.</li></ul>
![](attachments/submodule-icons/unchanged.png)| Inactive   | The submodule has been **Deactivated**. <ul><li>Use **Initialize** or **Pull** to initialize/fetch this submodule.</li></ul>
![](attachments/submodule-icons/empty.png)| Empty   | The submodule has been initialized, but contents have not been fetched yet. <ul><li>Use **Pull** to fetch this submodule.
![](attachments/submodule-icons/unchanged.png)| As Index   | The submodule is correctly initialized and pointing to the same commit as registered in the parent repository's HEAD and Index.
![](attachments/submodule-icons/added.png)| Added   | The submodule has been scheduled for addition in the parent repository.<ul><li>Use **Commit** to confirm the addition.</li><li>Use **Discard** to unscheduled the addition.</li></ul>
![](attachments/submodule-icons/removed.png)| Removed   | The submodule has been scheduled for removal in the parent repository.<ul><li>Use **Commit** to confirm the removal.</li><li>Use **Discard** to unscheduled the removal and (if necessary) reset to the submodule commit registered in the parent repository.</li></ul>
![](attachments/submodule-icons/modified.png) ![](attachments/submodule-icons/modified-staged.png) ![](attachments/submodule-icons/modified-added.png)| Modified   | The submodule points to a different commit than registered in the parent repository's Index. This is usually the result after e.g. you've done a commit in the submodule repository.<ul><li>Use **Stage** to stage the change in the parent repository's Index.</li><li>Use **Commit** to update the submodule link in the parent repository.</li><li>Use **Discard** to reset the submodule to the commit recorded in the parent repository's Index.</li><li>Use **Reset** to reset the submodule to the commit recorded in the parent repository's HEAD.</li></ul>
![](attachments/submodule-icons/conflict.png)| Conflict   | The submodule is in conflicting state where it's unclear to which commit it should point.<ul><li>Check the **Log** and make sure to **Check Out** the appropriate commit in the submodule repository, then confirm with **Stage**.</li><li>Use **Discard** to reset the submodule to the commit recorded in the parent repository's Index.</li><li>Use **Reset** to reset the submodule to the commit recorded in the parent repository's HEAD.</ul></li> **Note** <blockquote> Submodule conflicts are usually complex to resolve and may require additional commits in the submodule itself. Hence, if you are unsure, better contact the other authors of the conflicting submodule conflicts. </blockquote>
![](attachments/submodule-icons/nested-root.png)| Nested root   | The nested Git repository is not properly linked as submodule.<ul><li>Use **Stage** to scheduled the Git repository as submodule in the parent repository</li><li>Otherwise, if this Git repository should not be a submodule, use **Ignore** or completely get rid of the sub-directory.</ul></li>
![](attachments/submodule-icons/missing.png)| Missing   | Might happen if initializing a submodule has failed, e.g. after cancelling the credentials dialog. Use **Initialize** to initialize/fetch again.