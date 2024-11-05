# Add

Use **Modify\|Add** to schedule files or directories for addition to SVN
control.

In case of directories you have the option to **Recurse into
subdirectories**, which, when selected, causes all subdirectories and
files from subdirectories to be added as well.

When a file is added, SmartSVN automatically applies certain properties
to the file. Most important is the automatic detection of the file's
[MIME-Type](MIME-Type.md#MIME-Type-commands.mime-type), which
can basically be *text* or *binary*. Further property defaults can be
specified in the [project settings](Project-Settings.md#ProjectSettings-project.settings)
.


#### Tip
>
>
>Automatic detection can be overridden by the **Binary Files** project
>settings (see [Binary Files](Project-Settings.md#binary-files)).
>
>
