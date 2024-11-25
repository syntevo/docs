# The Changes View

The **Changes View** is available on all 3 SmartGit [Main Windows](Main-Windows.md), showing the changes made to the file selected in the **Files View**.

The layout of the **Changes View** depends on whether the selected file has been staged or not:

- When an unstaged file is selected in the **Files View**, the **Changes View** shows the difference between the **Working Tree** and **Index**.
- When a staged file is selected in the **Files View**, the **Changes View** shows the difference between the **Index** and the **HEAD** commit in the repository.

Use the `<<` and `>>` arrow buttons to move changed *Hunks* between panes, or use the `x` button to revert the *Hunk*.

#### Note
> - If you need to stage only specific lines within a *Hunk*, use the **Index Editor**.
> - You can't move staged changes directly into **HEAD**, as that will require a new commit.
> - The **Changes View** has only 2 panes, and as a result, the **HEAD** (repository) file version does NOT appear in the **Changes View** unless the file has been staged.
>   To view the 3 panes at once, please use the [**Index Editor**](Stage-Unstage-IndexEditor.md#the-index-editor).
> - **Changes View** won't automatically compare files larger than the configured *maximum file size* setting.
>   The value can be changed in the [*Low Level Properties* preferences](AdvancedSettings/Low-Level-Properties.md#changesmaximumfilesize)

There are several options to customize the layout of the **Changes View**:
- Select between *Unified* and *Side by Side* mode to view the Index and Working Tree versions either as separate panes, or as a unified change.
- *Compact mode* hides sections of the file which are unchanged.
- *Ignore WS* will hide whitespace changes such as space, tab and newline characters
- Use the *Up* and *Down* arrows to move to the previous, and next hunk of changes, respectively.
- Additionally, the hamburger icon (☰) at the top right provides further customization:
  - Ignore case changes during line comparisons
  - Ignore line ending changes during line comparisons
  - Changing the Syntax Highlighting language
  - Further settings, such as tab sizing and whitespace visualization.
