# Repository-Related

SmartGit remembers opened repositories and (primarily) GUI-related
settings. To open a repository, double-click it. If it already is open
in another window when double-clicking, the window with the opened
repository will become focused. The repository will open in a new window
if the current window is currently executing commands or **Open in New
Window** from the repository's context menu has been selected. To open
multiple repositories at once, use multiple selection (e.g.
Ctrl/Cmd+click) and **Open** from the context menu.

Repositories can be arranged in groups. Right-click the repositories and
select the target group or **New Group** from the **Move To** submenu.
Alternatively, you can use drag-and-drop - either onto the target group
or a repository inside the target group (see
[autoscroll](Tips-and-Tricks.md#autoscrolling-while-drag-and-drop)).

Repositories can be marked as favorite using the **Mark as Favorite**
(**Unmark as Favorite**). Favorite repositories are indicated with an
asterisk after the name and are sorted before groups which are sorted
before non-favorite repositories. Beside that a couple of background
refresh operations are performed on favorite repositories.

## Opening a Repository

Use **Repository\|Add or Create** to either open an existing local
repository (e.g. initialized or cloned with the Git or Hg command line
client) or to initialize a new repository.

You need to specify which local directory you want to open. If the
specified directory is not a Git or Mercurial repository yet, you have
the option to initialize it.

## Settings

Use **Repository\|Settings** to configure certain repository-specific
settings.

On the first page you find options related to the [Pull command](Synchronizing-with-Remote-Repositories.md#pull) .

On the second page you can configure your name and email address that
will be used when
[committing](Local-Operations-on-the-Working-Tree.md#commit)
for this repository. To change the global settings (for all
repositories, in your `.gitconfig`), select **Remember as default**.

On the third page you can configure which text encoding SmartGit should
assume when showing text files in the **Changes** view or **Compare**
window. A lot of UTF-8 encoded text files, with or without byte order
mark (BOM), can be detected automatically.
