# Submodules in SmartGit

Submodules offer a way to link one or more embedded repositories into a parent repository.
Please refer to [Submodule Concepts](../../GitConcepts/Submodules.md) for background information.

## Topics

- [Submodules in the UI](#submodules-in-the-ui)
- [Cloning Repositories with Submodules](#cloning-repositories-with-submodules)
- [Adding, Removing and Synchronizing Submodules](#adding-removing-and-synchronizing-submodules)
- [Updating Submodules](#updating-submodules)
- [Working within Submodules](#working-within-submodules)
- [Submodule States and Transitions](#submodule-states-and-transitions)

## Submodules in the UI

### Standard window
For a repository with submodules, a *Submodule* toolbar button appears.
This lets you quickly open submodule repositories (as separate tabs).

In the parent repository the submodule's pointer is displayed in the *Files* view.

### Working Tree window
Submodules show up in the [*Repositories View*](../Repositories-View.md) at their configured directory location.
Their files are shown, even recursively, just like normal files of the parent repository in the **Files** view.

Available Operations on the main menu will depend on whether the **Repositories** view or the **Files** is focused:

- The **Repositories** view offers operations in the submodule repository itself:
  e.g. you can invoke a **Log** here to see the history of the submodule repository or you can invoke **Remote \| Submodule \| Initialize** to initialize all sub-submodules contained in the selected submodule.
- The **Files** view offers operations on the submodule pointer from perspective of the parent repository:
  e.g. you can invoke a **Log** here to see how the submodule-pointer has changed over time or you can invoke **Remote \| Submodule \| Initialize** to initialize the selected submodule itself (if it is not yet initialized).

### Log window
Submodules show up in the [*Repositories View*](../Repositories-View.md) and are handled like other repositories (only one can be opened at the same time).

## Cloning Repositories with Submodules

If you clone an existing repository containing one or more submodules via **Repository \| Clone**, make sure the option **Include Submodules** is selected, so that all first-level submodules are automatically initialized and updated.
Without this option, you may initialize the submodules later by hand via **Remote \| Submodule \| Initialize**.
Only performing the initialization will leave the submodule directory empty.
For a fully functional submodule, you'll also need to do a pull on it, as described in [Updating Submodules](#updating-submodules).

## Adding, Removing and Synchronizing Submodules

> [!NOTE]
> Submodules will show up in the **Repositories** view, as well as the **Files** view.
> Submodule operations (from the parent repository perspective) will be performed in the **Files** view.
> 'Normal' Git operations on the submodule repository itself will be performed in the **Repositories** view.

To "ignore" a not-yet initialized submodule which you are not interested in, invoke **Remote \| Submodule \| Deactivate**.
This will hide the submodule from the **Files** view, unless **View \| Show Ignored Files** is selected.
(Technically, SmartGit will set `submodule.<name>.active=false` in the parent repository `.git/config`.)

To remove a submodule from the working tree, select the submodule in the **Files** view, invoke **Remote \| Submodule \| Deinit**.
After *deiniting* you will probably want to **Deactivate** it, too.

To add a new submodule to a repository, invoke **Remote \| Submodule \| Add** on the repository in the **Repositories** view and follow the dialog instructions.
The wizard asks for the **Relative Path** of the submodule inside the outer repository.
It also lets you select the remote **Branch** to check out.
If **HEAD** is selected there, SmartGit does not force a named branch for the submodule.

If SmartGit can derive more than one useful URL for the `.gitmodules` entry, the wizard also shows **URL for .gitmodules**.
This matters when the URL stored in `.gitmodules` should differ from the URL that was used to inspect the remote repository.
Typical examples are relative URLs or internal mirror URLs.

To remove a submodule from the repository, select the submodule in the **Files** view, invoke **Remote \| Submodule \| Unregister**, and then commit your changes.
After the submodule is unregistered, you may delete the entire submodule directory.

If the URL of a submodule's remote repository has changed, you need to modify the URL in the `.gitmodules` file and then *synchronize* the submodule, via **Remote \| Submodule \| Synchronize**, so that the new URL is written into Git's configuration.

If you initialize a single submodule, SmartGit shows a dialog with the configured **URL**.
You may adjust this before continuing.
If the submodule URL in `.gitmodules` is relative, SmartGit expands it against the outer repository's `origin` URL for convenience.
Use **Initialize & Pull** if you want to populate the submodule working tree immediately.
Plain **Initialize** only prepares the Git metadata.

If you initialize all submodules at once, the dialog offers **Pull submodule repositories**.
Enable this if initialization should immediately be followed by a pull for every selected submodule.

If SmartGit detects a nested Git repository that is not yet registered as a submodule, it offers **Register Submodule**.
The dialog asks for the submodule **URL** or local path that should be written to `.gitmodules`.

During **Synchronize**, SmartGit can also offer **Pull submodule repository** or **Pull submodule repositories**.
Enable this if the new URL should be synchronized and fetched in one step.

## Updating Submodules

After a submodule has been set up, the usual workflow is that some files in the submodule repository are modified externally, and you perform an *update* on the submodule, i.e. you pull the new changes into your local submodule repository.
You can perform an update either by doing a pull on the submodule itself, or, if the outer repository is connected to a remote repository, by configuring SmartGit to automatically update all submodules when you do a pull on the outer repository.
These two cases will be described in the following subsections.
Note that in either case, pulling will fetch new commits without changing the submodule if it has a *detached HEAD*.
See [Working within Submodules](#working-within-submodules) for more information on the latter.

### Pulling on the Submodule

Select the submodule in the **Repositories** view and invoke **Remote \| Pull**.
After the pull, the submodule will have a different appearance in the **Repositories** view if new commits have been fetched and a rebase or merge has been performed.
This different appearance indicates that the submodule has changed and that you need to [commit](../Local-Operations-on-the-Working-Tree.md#commit) the change in the outer repository.

### Pulling on the Outer Repository

Open the repository settings via **Repository \| Settings**, and in the **Pull** section, enable **Update registered submodules**, so that SmartGit automatically updates all registered submodules when pulling on the outer repository.
Additionally, you may also enable **And initialize new submodules**; with this, SmartGit will update not only registered submodules when pulling, but also uninitialized submodules, after having initialized them.
The aforementioned **Update** option will only fetch commits as needed, i.e. when a commit is referenced by the outer repository as the current state of the submodule.
If you want to fetch all new commits instead, enable the option **Always fetch new commits, tags and branches from submodule**.
Note that when you do a pull on the outer repository, you need to pull with subsequent rebase or merge, otherwise new submodule commits will only be fetched, without changing the submodule state (i.e. the commit the submodule is currently pointing at).

## Working within Submodules

You can view the history of a submodule repository by opening its [Log](../Log.md).
To do so, select the submodule in the **Repositories** view and invoke **Log** from the submodule's context menu.
You can also restrict the Log to a certain branch within the submodule:

- Select the submodule in the **Repositories** view
- then select the submodule branch in the **Branches** view
- and then invoke **Log** from the context menu of the branch.

In the submodule Log, you can switch the submodule to another commit by selecting the commit in the Log graph and invoking **Check Out** from the commit's context menu.
If you want to switch to the tip of a certain branch, you can also just double-click on the branch in the **Branches** view.

After switching the submodule to another commit, the submodule will be shown as 'changed' in the **Files** view.
That means you can either commit the change in the outer repository, or roll back the change.
To roll back the change, select the submodule in the **Files** view and invoke **Reset** from its context menu.

If you modify and commit files within the submodule (as part of the outer repository, not externally), the submodule will also show up as 'changed'.
Then, after committing the changes, you can push them back to the remote submodule repository via **Push** from the context menu of the **Branches** view.
Note that you may lose your work in the submodule if you make changes on a *detached HEAD*.
To avoid this, check out a submodule branch before making the changes.

## Submodule States and Transitions

<table>
  <thead>
    <tr>
      <th>Icon</th>
      <th>State</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="../../images/submodule/uninitialized.png" alt="Uninitialized"></td>
      <td>Uninitialized</td>
      <td>
        <p>The submodule has not yet been initialized.</p>
        <ul>
          <li>Use <strong>Initialize</strong> or <strong>Pull</strong> to initialize/fetch this submodule.</li>
          <li>Use <strong>Deactivate</strong> to get the submodule rid from the <strong>Files</strong> view. It will only show up if <strong>View | Show</strong> Ignored Files is selected.</li>
          <li>Use <strong>Unregister</strong> to remove the submodule from the repository.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/unchanged.png" alt="Inactive"></td>
      <td>Inactive</td>
      <td>
        <p>The submodule has been <strong>Deactivated</strong>.</p>
        <ul>
          <li>Use <strong>Initialize</strong> or <strong>Pull</strong> to initialize/fetch this submodule.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/empty.png" alt="Empty"></td>
      <td>Empty</td>
      <td>
        <p>The submodule has been initialized, but contents have not been fetched yet.</p>
        <ul>
          <li>Use <strong>Pull</strong> to fetch this submodule.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/unchanged.png" alt="As Index"></td>
      <td>As Index</td>
      <td>The submodule is correctly initialized and pointing to the same commit as registered in the parent repository's HEAD and Index.</td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/added.png" alt="Added"></td>
      <td>Added</td>
      <td>
        <p>The submodule has been scheduled for addition in the parent repository.</p>
        <ul>
          <li>Use <strong>Commit</strong> to confirm the addition.</li>
          <li>Use <strong>Discard</strong> to unscheduled the addition.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/removed.png" alt="Removed"></td>
      <td>Removed</td>
      <td>
        <p>The submodule has been scheduled for removal in the parent repository.</p>
        <ul>
          <li>Use <strong>Commit</strong> to confirm the removal.</li>
          <li>Use <strong>Discard</strong> to unscheduled the removal and (if necessary) reset to the submodule commit registered in the parent repository.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>
        <img src="../../images/submodule/modified.png" alt="Modified">
        <img src="../../images/submodule/modified-staged.png" alt="Modified, staged">
        <img src="../../images/submodule/modified-added.png" alt="Modified, added">
      </td>
      <td>Modified</td>
      <td>
        <p>The submodule points to a different commit than registered in the parent repository's Index. This is usually the result after e.g. you've done a commit in the submodule repository.</p>
        <ul>
          <li>Use <strong>Stage</strong> to stage the change in the parent repository's Index.</li>
          <li>Use <strong>Commit</strong> to update the submodule link in the parent repository.</li>
          <li>Use <strong>Discard</strong> to reset the submodule to the commit recorded in the parent repository's Index.</li>
          <li>Use <strong>Reset</strong> to reset the submodule to the commit recorded in the parent repository's HEAD.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/conflict.png" alt="Conflict"></td>
      <td>Conflict</td>
      <td>
        <p>The submodule is in conflicting state where it's unclear to which commit it should point.</p>
        <ul>
          <li>Check the <strong>Log</strong> and make sure to <strong>Check Out</strong> the appropriate commit in the submodule repository, then confirm with <strong>Stage</strong>.</li>
          <li>Use <strong>Discard</strong> to reset the submodule to the commit recorded in the parent repository's Index.</li>
          <li>Use <strong>Reset</strong> to reset the submodule to the commit recorded in the parent repository's HEAD.</li>
        </ul>
        <p><strong>Note</strong> Submodule conflicts are usually complex to resolve and may require additional commits in the submodule itself. Hence, if you are unsure, better contact the other authors of the conflicting submodule.</p>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/nested-root.png" alt="Nested root"></td>
      <td>Nested root</td>
      <td>
        <p>The nested Git repository is not properly linked as submodule.</p>
        <ul>
          <li>Use <strong>Stage</strong> to schedule the Git repository as submodule in the parent repository.</li>
          <li>Otherwise, if this Git repository should not be a submodule, use <strong>Ignore</strong> or completely get rid of the sub-directory.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><img src="../../images/submodule/missing.png" alt="Missing"></td>
      <td>Missing</td>
      <td>Might happen if initializing a submodule has failed, e.g. after cancelling the credentials dialog. Use <strong>Initialize</strong> to initialize/fetch again.</td>
    </tr>
  </tbody>
</table>
