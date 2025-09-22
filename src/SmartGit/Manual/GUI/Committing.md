# Committing Changes

The **Commit** command creates a new [commit](../GitConcepts/Commits.md) from [staged changes](Stage-Unstage-IndexEditor.md) in the local repository.

- Using the [**Commit View**](Commit-View.md) to create commits in most instances is recommended, as this allows new commits to be easily managed.
- Alternatively, the **Local \| Commit** command adds a dialog with additional functionality, such as selecting a commit message from a recent previous commit.

## Commit Basics

The following changes will be included in a commit:
- **All staged changes**: If all modified files in the *Working Tree* are [staged in the Index](Stage-Unstage-IndexEditor.md), the **Commit** will consist of these staged changes.
- **Staged changes only**: If there is a mix of staged and unstaged changes in the *Working Tree*, only the staged changes will be committed. The remaining changes will stay as modified files in the *Working Tree*.
- **No staged changes**: If the *Working Tree* contains modified files, but no changes are staged, the **Commit** command will prompt you to automatically stage all visible modified files before creating the commit. This produces the same result as manually staging and committing all modified files.

After the commit:
- Newly staged files will be added to the repository.
- Modified files will be updated in the repository.
- Previously tracked files were deleted in the *Working Tree* and staged and will be removed from the repository.

## Commit Messages

While entering the commit message, use the *\<Ctrl>+\<Space>*-keystroke to auto-complete file names or paths.
SmartGit will display a shortlist of files eligible for the commit, and when selecting a file, it will paste its name into the commit message.

- Use **Select from Log** to choose a commit message or SHA ID from the Log.

> [!TIP]
> As commit messages are often displayed alongside a commit hash, keep them short and to the point, allowing other users to understand the changes in a commit quickly.
> By default, SmartGit 'guides' the writing of commit messages in a standardized format with limited line lengths.
> You can disable this line length guide under **Edit \| Preferences**.

## Amending Commits

If **Amend last commit** is selected, you can combine the current changes with the previous commit, such as adding a modified file excluded from the previous commit.
By default, this option is only available for commits that have not been pushed. You can enable it for already pushed commits in **Preferences** under the **Commands** section.

When amending a commit, you have the option to replace, or reuse the commit message on the previous commit.

> [!NOTE]
> Amending a commit replaces the previous commit with a new one that combines changes from both commits.
> Amending a pushed commit is not recommended because it effectively rewrites the commit history and may cause issues for other users.

If you commit while the Working Tree is *merging*, you can create either a merge or a normal commit. See **[Merge](Branch/Merge.md)** for details.

> [!NOTE]
> If the Working Tree is in a *merging* or *rebasing* state (see [Merge](Branch/Merge.md) and [Rebase](Branch/Rebase.md)), you can only commit the entire working tree.
> If the commit fails because Git complains "unable to auto-detect email address", you should set your name and email address in the [Repository Settings](Repository/Repository-Settings.md).

## Altering Local Commits

SmartGit provides several options for altering local commits:

- **Undo Last Commit**: Moves the content of the last commit to the [Index](../GitConcepts/The-Index.md) without losing any changes.
- **Edit Commit Message**: Modify the commit message of the last commit or any local commit. Select the commit and invoke **Edit Commit Message** from its context menu in the **Journal** view of the **Working Tree window** or the **Graph** view of the **Log window** or the **Standard window**.
- **Squash Commits**: Combine multiple local commits into a single commit by selecting the range of commits in the **Journal** view (of the **Working Tree Window**) or the **Graph** view (of the **Log Window** or **Standard Window**), then invoking **Squash Commits** from the context menu.
- **Reorder Commits**: Drag and drop a commit to a different location in the **Journal** or **Graph** view to change its position.

> [!WARNING]
> Avoid undoing a commit already pushed to a remote repository unless you understand the implications.
> Undoing such commits may require a force-push, which could discard other users' commits in the remote repository.
