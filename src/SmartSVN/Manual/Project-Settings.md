# Project Settings

The project settings affect the behavior of various SVN commands.
Contrary to the global preferences (see
[Preferences](Preferences.md#Preferences-preferences)), the
project settings only apply to an individual project. You can edit the
settings of the currently opened project via **Project\|Settings**.

The top of the dialog shows the **Root Paths** for the current project.
Use **Change** to modify these paths to, for example, add other root
directories, or to change a root directory after the corresponding SVN
working copy has been moved on your local disk.

## Text File Encoding

The text file encoding affects only the presentation of file contents,
for instance when comparing a file and it will only be used if for the
file itself no *charset* has been specified by its [MIME-Type property](MIME-Type.md#MIME-Type-commands.mime-type) . The
text file encoding settings are not relevant for SVN operations itself,
which generally work only on the *byte*-level.

With **Use system's default encoding**, SmartSVN will automatically use
the system's default encoding when displaying files. When changing the
system encoding later, the project settings are automatically
up-to-date.

Alternatively you can choose a fixed encoding with **Use the following
encoding**.

## Scan

The **Scan** settings specifies whether SmartSVN scans the **Whole
project** or **Only root directory** when opening a project.

We recommend in general to use the **Whole project** option, because
features like searching files in the table, etc. rely on having the
whole project structure in memory. Nevertheless, when you are working
with *large* projects, it can be necessary to scan the file structure
only on demand to avoid high memory consumption.

## Working Copy

The option **(Re)set to Commit-Times after manipulating local files**
tells SmartSVN to always set a local file's time to its internal SVN
property `commit-time`. Especially in case of an updating command (see
[Updating](Updating.md#Updating-commands.updating)), this
option is convenient to get the actual change time of a file and not the
local update time.

**Apply auto-props from SVN 'config' file to added files** tells
SmartSVN to use the *auto-props* from the SVN 'config' file, which is
located in the `Subversion` directory below your home directory. These
auto-props will also override other project defaults, like **Default EOL
Style**, explained below.

### Global Ignores

The Global Ignores define *global ignore patterns* for files/directories
which should in general be ignored within the current project. This is
contrary to local ignores (see [Ignore Patterns](Ignore-Patterns.md#IgnorePatterns-commands.ignore-patterns)),
which are only related to a specific directory.

-   You can completely deactivate Global Ignores by **Deactivated**
-   With **Use from SVN 'config' file**, the same ignore patterns will
    be used as by the command line client.
-   Independently of the command line client, you can enter your own
    patterns via **Use following patterns**. The **Patterns** are file
    name patterns, where '\*' and '?' are wildcard symbols, interpreted
    in the usual way. This will override global ignores from the SVN
    'config' file.

### Binary Files

Choose **Use MIME-type registry from SVN 'config' file** to use the
corresponding file which is also used by the command line client. Choose
**Use the following patterns** to specify custom **Patterns**, for which
matching files will always be [added](Add.md#Add-commands.add)
with *binary*
[MIME-type](MIME-Type.md#MIME-Type-commands.mime-type). The
wildcard symbols '\*' and '?' can be used in the usual way.

### EOL Style

This option specifies the **Default EOL-Style**, which is used when
adding a file ([Add](Add.md#Add-commands.add)). For more
details refer to
[EOL-Style](EOL-Style.md#EOL-Style-commands.eol-style).

### Locks

Use **When adding files, set 'Needs Lock' for** to specify for which
files the [Needs Lock](Locks.md#change-needs-lock) flag should
be set when they are added. With **No file**, the 'Needs Lock' property
will be set on no file. With **Binary files** the property will only be
set on files which have been detected to have binary content. With
**Every file** the property will be set on every file.

When [committing](Commit.md#Commit-commands.commit) files or
directories, SmartSVN will scan for locked files. Choose here whether to
suggest to **Release Locks** or to **Keep Locks** for those files on the
'Locks' page of the commit wizard.

Enable **Automatically scan for locks** and enter the corresponding
interval in **minutes** to repeatedly refresh the files' lock states.
Refer to [Refresh](Locks.md#refresh) for
details.

### Keyword Subst.

This option specifies the Keyword Substitution default, which is used
when adding a file ([Add](Add.md#Add-commands.add)). For more
details refer to [Keyword Substitution](Keyword-Substitution.md#KeywordSubstitution-commands.keyword-substitution).

### Conflicts

By default, conflicting files will receive new extensions like 'mine' or
'.r4711'. Here you can specify extensions which should be preserved in
case of conflicts. Choose either **Use from SVN 'config' file** or **Use
following extensions** and enter the file name **Extensions** which
should be preserved.

## Default Settings

Projects are created by various commands. For reasons of simplicity, in
most of these cases, there is no configuration possibility for the
corresponding project settings. Therefore you can specify default
project settings (template settings), which will be applied to every
newly created project. With **Project\|Default Settings** you can
configure the same properties as for a concrete project.
