# Commit View

The **Commit View** in SmartGit's [Working Tree](Working-Tree-Window.md) and [Log](Log-Window.md) Windows will change, depending on which node is selected in the **Graph**:
- If the Working Tree node is selected, the view is used to [create a new commit](#create-new-commit) on the currently checked out branch or HEAD.
- If an existing commit node is selected, the view will show important commit audit and metadata [information about this commit](#view-existing-commit).

#### Note
> The **Commit View** in the **Standard Window** is slightly different. Please refer to the [Standard Window](Standard-Window.md) documentation.

The layout of the **Commit View** depends on the **Graph** selection:

## Create New Commit

If the *working tree* node is selected, it shows:

- a text input field to compose the **Message** for the next commit.
- options available in the current context.
- a **Commit** button to actually perform the commit, with the option to instead **Amend** the previous commit.

### Options

The hamburger icon at the top-right of the **Commit View** provides additional functionality:
- Toggles the **More Options** setting. When **More Options** is enabled, the following additional options appear:
  - **Add `Signed Off By` signature** (i.e. the `--signoff` flag). Use this option to declare that changes in this commit does not infringe on copyrights held by other parties.
  - **Bypass commit hook**. This option prevents any configured [commit hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) from being invoked during the commit (`--no-verify` switch).
  - **{Recent commit messages}** -- A list of recent commit messages may appear in this menu. If you select a previous message, it will copy it into the commit message input.
  - **Clear History** -- Selecting this will clear the recent commit messages from the menu.
  - **Reset to default** -- Selecting this will reset any text in the commit message input.

### AI Assisted Commenting (experimental)

SmartGit is able to integrate with popular LLM services, which allows optional AI-generated assistance when adding commit messages.

The ![AI](../images/AI-Commit-Button.png) button allows:
- Automatical AI inference of a suitable commit message from the staged diff.
- Processing of `@ai` and `WIP` placeholders in a user provided commit message.

Please consult [AI Commit Messages](AI-Commit-Messages.md) for details on how to get started.

#### Note
>
> AI features are **opt-in** and must be enabled.

## View Existing Commit

However, if an existing commit is selected, it shows details for the selected commit:

- **branches** and **tags** shows all branch/tag-refs which are displayed in the **Graph** for the selected commit.
- **same state tags** (only File Logs) shows those tags which contain the file with exactly the same content as for the selected commit; this category will only be present if **Tag-Grouping** has been configured in the **Repository Settings** (for details refer there).
- **closest tags** shows those tags for a commit:
    - from which the commit is reachable; and
    - from which there is no other tag reachable from which the commit is reachable, too. In addition, more relevant tags will be added if **Tag-Grouping** has been configured in the [Repository Settings](Repository/Repository-Settings.md).
- **on branches** shows all branch-refs for which the selected commit is an ancestor reachable by following only "primary" parents, i.e. is part of the branch's "natural" history.
- **merged to branches** shows all branch-refs for which the selected commit is an ancestor, but only reachable by following at least one merge parent (2nd or higher parent of a commit).

#### Tip

> You can select 2 commits for viewing side by side -- the **Commit View** will show both commits.

## Variations of the Commit View

- When using the [Standard Window](Standard-Window.md), the **Commit View** will also show a recent commit history beneath the view (similar to an abbreviated **Journal View**), however, the **More Options** selection is not available in the **Standard Window**.
- When using the [Working Tree Window](Working-Tree-Window.md), the **Commit View** will toggle between [Create New Commit](#create-new-commit) and [View Existing Commit](#view-existing-commit) by selecting between the **Local Files** and **History** perspective buttons in the **Working Tree Window**.
- When using the [Working Tree Window](Working-Tree-Window.md), the **Commit View** has an additional **Select from Log** option in the hamburger menu, which allows a commit to be selected from the Log graph, and the commit message will be defaulted to the commit message for the selected commit.
- When using the [Log Window](Log-Window.md), the option to **Select from Log** is not available.
