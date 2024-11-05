# MIME-Type

Use **Properties\|MIME-Type** to change the *SVN MIME-type* of the
selected files. The MIME-type can be either a default **Text**, a
default **Binary** or a **Custom** type. In case of a **Custom** type,
you have to specify the corresponding MIME-type here. E.g. 'text/html',
'application/pdf' or 'image/jpeg'.

MIME-types can't be arbitrary strings but must be *well-formed*. For
instance, a MIME-type must contain a '/'. By default, SmartSVN checks
whether MIME-types are well-formed. Use **Force** to disable this check.

The MIME-types are relevant for some SVN operations, for instance
updating, where in case of *text* types the line endings, etc. can be
replaced. By default, when adding files (see
[Add](Add.md#Add-commands.add)), the coarse MIME-type (either
*text* or *binary*) is automatically determined by SmartSVN. In general
this detection is correct, but in certain cases you may want to
explicitly change the MIME-type of the file with this command.

Within the [project settings](Project-Settings.md#binary-files)
you can define file name patterns which should always be treated as
*binary*.
