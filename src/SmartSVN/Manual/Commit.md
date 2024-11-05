# Commit

Use **Modify\|Commit** to commit (i.e. send) the changes in the selected files/directory to the repository.

The **Commit** wizard guides you through the commit process, starting with the 'Configuration' page.
Based on the choices on the 'Configuration' page, the working copy will be scanned for changes, which is especially important when performing the **Commit** on a directory.
Subsequent pages allow further 'customization' of the commit.
Their presence depends on the changed files and directories found during the scanning phase.

Before the commit wizard opens, it checks whether you might have forgotten to select some files or directories, and in that case shows a warning.
For details, refer to the [Preferences](Preferences.md).
Also, a warning will be issued if you are going to commit [switched](Switch.md#Switch-commands.switch) files or directories.
Unless this is actually intended, you should switch back the corresponding entries and re-run the commit.

#### Page 'Configuration' (optional)

This page is only present when committing one or more directories and **Show directory configuration page** has been selected in the [Preferences](Preferences.md).

Select **Recurse into subdirectories** to scan not only changes from the selected local directory, but also from subdirectories.
When recursing into subdirectories, select **Descend into externals** to also scan for changes in [external working copies](Externals.md#Externals-commands.externals).

When clicking **Next** the file system of your project will be scanned.
This may take some time.

#### Page 'Repositories'

This page is only displayed if the option **Descend into externals** on the **Configuration** page has been selected and at least one committable entry within an external working copy has been found.
For details on externals, refer to [Externals](Externals.md#Externals-commands.externals).

Every such external working copy is listed with its **Local Path** and its **URL**.
The project's working copy itself is also listed with local path '. '.
Every working copy can be individually selected or deselected for the commit by toggling the respective checkbox in the first table column (either with the mouse or with *\<Space>*-keystroke).

Working copies pointing to the same repository (the **URL** helps in seeing this) can be committed together, hence SmartSVN will have to perform as many commits as different repositories are involved in the overall commit process.


#### Warning
> When committing to multiple repositories, every commit will create its own revision in the corresponding repository.
> Hence, atomicity of such commits cannot be guaranteed.
> This for example means that the commit to one repository can succeed while the other one fails.
> While fixing the failing commit another person might already have updated his or her working copy and only have received the successfully committed revision.
> This might result in (temporary) inconsistencies in his/her overall project.

You can choose whether to commit the selected working copies with **One commit message** or with **Individual commit messages**.
If you are committing multiple working copies with different [Bugtraq-Properties](Bugtraq-Properties.md#Bugtraq-Properties-commands.bugtraq-properties) configurations, it's required to use **Individual commit messages** to have the Bugtraq-Properties functionality available on the **Files** page.

#### Page 'Detect Moves'

This page is only displayed if the option **Detect moved and renamed files** in the [Preferences](Preferences.md) has been selected and at least one moved or renamed file pair was detected. Refer to [Detect Moves](Detect-Moves.md#DetectMoves-commands.detect-moves) for details.
With **Differences** you can toggle the integrated compare view.
This will show the differences for the currently selected file in the lower part of the **Commit** dialog.
The change display behaves similarly to the [Changes view](Changes-View.md#ChangesView-mainwindow.change-preview).

#### Page 'Files'

This pages shows a list of all files and directories which were found to be committable according to the selected options from the **Configuration** page, and from the configuration in the [Preferences](Preferences.md).
To exclude a file/directory from the commit, deselect the corresponding checkbox (either with the mouse or by pressing *\<Space>*-keystroke).


#### Note
> SmartSVN also displays certain kinds of files which are not committable (e.g. conflicted files, refer to [Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states)).
> This is a precaution to not forget to resolve these files' problems and commit them as well (if necessary).

You may review your changes by expanding the dialog with the **Differences** button.
This will show the differences for the currently selected file in the lower part of the **Commit** dialog.
The change display behaves similarly to the [Changes view](Changes-View.md#ChangesView-mainwindow.change-preview).
Alternatively, you can also double-click a file to open a [File Compare](File-Compare.md#FileCompare-file-compare) window.

For the **Commit Message** you can either enter a new message or select an older message from the message popup on the top right of the text field.
The popup menu will show recently entered commit messages, and you can clear this message history with **Clear Message History** or use **Get from Log** to fetch an older commit message from the log.
With *\<Ctrl>+\<Space>*-keystroke you can trigger a file name completion, based on all of the files that have been selected for the commit.

Depending on how [Bugtraq-Properties](Bugtraq-Properties.md#Bugtraq-Properties-commands.bugtraq-properties) are configured for the current working copy, there may be an additional 'issue ID' input field.
The name of this field can vary, depending on the Bugtraq-Properties.
Its content will be appended/prepended to entered commit message afterwards, forming the final commit message.

If the spell check has been configured in the [Preferences](Preferences.md), SmartSVN will check the entered **Commit Message** for basic spelling mistakes. The spell check ignores file
paths, i.e. strings containing a '/', and 'issue IDs' which are part of the commit message and which can be recognized by the Bugtraq-Properties.
For details regarding the spell check's popup menu.


#### Tip
> Commit messages will be displayed in various kinds of logs.
> Hence, a descriptive commit message will help you and your team later on if you need to go through your past changes for some reason, e.g. tracking down a bug.

By default, SmartSVN will warn you in case of an empty commit message.
You can disable this warning in the [Preferences](Preferences.md).


#### Tip
> You may configure a *template message* using the `tsvn:logtemplate` property which has to be set on the project root.

If **Descend into externals** has been selected and multiple working copies on the **Repositories** page have been selected for committing, there will also be a topmost **Path** drop-down list.
All other items on this page are always related to the selected path.
In particular it will be necessary to enter a **Commit Message** for each path.

#### Page 'Locks'

This page will only be displayed if the files/directories selected for the commit have been found (during the scanning) to contain locked files.

Select **Keep locks for committed files** to keep the files locked even after having them committed.
Select **Unlock committed files** to unlock them after the commit.
In the latter case you can additionally select unchanged but locked files which had been detected during the scan and which should be unlocked upon a successful commit as well.


#### Tip
> You can configure whether **Keep locks for committed files** or **Unlock committed files** should be selected by default in the [Project Settings](Project-Settings.md#locks).

Click **Finish** to finally start the commit.

## Client-side pre-commit hooks

SmartSVN supports client-side pre-commit hooks: the hook script must be located in the SmartSVN [settings directory](Installation-and-Files.md) (or the [default directory](Installation-and-Files.md#company-wide-installation)) and must be called `pre-commit` on Mac/Linux and `pre-commit.bat` on Windows.
