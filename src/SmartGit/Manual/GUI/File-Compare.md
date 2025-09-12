# File Compare

The **File Compare** window is SmartGit's native, editable two-pane diff viewer.
It opens in its own window and is optimized for reviewing changes and making small fixes while comparing two file revisions or Working Tree content.

## Opening File Compare

Open **File Compare** from the [Changes View](Changes-View.md) by selecting a file and invoking **Compare**.
You can also double-click a changed file in the [Commit View](Commit-View.md) to open it.
From the [Log](Log.md), compare commits or branches and then select a file from the file list to view the diff in **File Compare**.

## Layout and Viewing

Choose a layout that suits your screen and preferences.
Use **View \| Left Beside Right** for a classic side-by-side comparison, or **View \| Left Above Right** for stacked panes.
Toggle helpful visuals with **View \| Show Line Numbers**, **View \| Synchronize Scrolling**, and **View \| Show Long Current Lines**.
When automatic language detection is not ideal, select **View \| Syntax Language...**.
Open **View \| Settings...** to fine-tune visualization options, and select **View \| Remember as Default** to persist your preferences.

## Editing and Applying Changes

Editor panes are editable depending on the compare scenario.
Apply focused changes per hunk using **Edit \| Take Left Block** or **Edit \| Take Right Block** to move changes between sides.
Standard editing commands are available, including **Edit \| Undo**, **Edit \| Redo**, **Edit \| Cut**, **Edit \| Copy**, and **Edit \| Paste**.
Persist changes with **File \| Save**, or share and archive the diff with **File \| Export as HTML-File...**.

## Navigation

Use **Go To \| Next Change** and **Go To \| Previous Change** to jump between changes.
Go directly to a line with **Go To \| Go to Line...**.
Search within the current pane using **Edit \| Find...**, **Find Next**, **Find Previous**, or **Find and Replace...**.
After external edits, refresh the comparison with **View \| Reload**.

## Whitespace, Case and Syntax

Reduce noise by hiding whitespace-only differences using **View \| Ignore Whitespace**.
Relax case sensitivity for line comparison with **Edit \| Ignore Case Change for Line Comparison**.
For correct decoding in compare and editors, configure per-repository encoding in [Repository Settings](Repository/Repository-Settings.md).

## Performance and Very Large Files

For very large files, SmartGit may limit comparisons for performance reasons.
In the [Changes View](Changes-View.md), files above the size limit offer a Force Compare option.
Global sizing thresholds can be tuned via low-level properties; see [Low-Level Properties](AdvancedSettings/Low-Level-Properties.md#changesmaximumfilesize).

## Related

- For in-place diff previews inside the main window, see [Changes View](Changes-View.md).
- For comparing commits and navigating history, see [Log](Log.md).
- Configure external diff tools for Compare in [Preferences \| Tools](Preferences/Tools.md).
- For staging specific lines or partial commits, use [Stage, Unstage and Index Editor](Stage-Unstage-IndexEditor.md).
- For three-way merges and conflict resolution, use the [Conflict Solver](Branch/Conflict-Solver.md).

