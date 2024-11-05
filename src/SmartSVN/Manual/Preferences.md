# Preferences

The application preferences define the global behavior of SmartSVN,
regarding UI, SVN commands, etc. Contrary to the project settings (see
[Project Settings](Project-Settings.md#ProjectSettings-project.settings)),
these preferences apply to all projects.


#### Tip
>
>
>Most preferences are stored in the `settings.xml` file in SmartSVN's
>settings directory. Refer to [Installation and Files](Installation-and-Files.md#InstallationandFiles-installation)
>for details.
>
>

The following sections will give details on notable configuration
options.

## Authentication

The **Authentication** page shows all credentials which SmartSVN has
collected. Credentials can be selectively removed to force SmartSVN
requesting new credentials when connecting to the repository again.

All passwords needed to access repositories can optionally be stored in
SmartSVN's password store. This password store is located in the
`password` file, which can be found in SmartSVN's settings directory
(see [Installation and Files](https://www.syntevo.com/doc/display/SUWIP/Installation+and+Files#InstallationandFiles-installation)).

The password store can be protected by a *master password*, and each
time you start SmartSVN, this master password has to be entered as soon
as SmartSVN tries to access the password store for the first time. The
entered password is kept in memory while the program runs, so you don't
have to enter it again for the rest of the current session. You may
choose **Don't use a master password** if you don't want the password
store to be protected with a master password. However, this option is
only recommended if you can make sure the master password file itself is
protected against unauthorized access.

### Master Password

By clicking on the **Change Master Password** button on the
**Authentication** page in the preferences, you can set, reset or change
the master password. Use **Change master password** to *change* the
current password; this will preserve the stored passwords, but requires
that you supply the **Current Master Password**. Note that you don't
need to enter the **Current Master Password** if you are currently
working without a master password.

If you have forgotten the master password, select **Set new master
password**. In that case all previously stored passwords will be
discarded. Enter the **New Master Password** and **Retype New Master
Password**. When leaving both fields blank, you will continue to work
without a master password, i.e. as if having selected the option **Don't
use a master password** when you were asked to set the master password.

## SSH

You can either use SmartSVN's built-in SSH client or your existing
**System SSH** configuration.


System SSH on Windows


Using the **System SSH** configuration on Windows is known to work well
with [Putty/Pageant](https://www.putty.org/). This requires a tunnel
definition in Subversion's `config` file, which might look like:



``` java
"C:\\Program Files (x86)\\PuTTY\\plink.exe" -v -P 22 -l user
```



Note that Pageant only works well with *private key* authentication. For
troubleshooting purposes, it can sometimes be useful to temporarily
switch to *password* authentication. In this case, the password has to
be specified as part of the tunnel configuration:



``` java
"C:\\Program Files (x86)\\PuTTY\\plink.exe" -v -P 22 -l user -pw passwd
```





When using such a configuration, only use **test** passwords and only
store the password temporarily!





  

## URL Aliases

You can configure aliases for frequently used URLs. These aliases can be
used in all input fields where SmartSVN expects an URL. You can also
append a path to an alias.



#### Example
>
>When having alias `subversion` configured as
>`http://svn.apache.org/repos/asf/subversion`[,](http://svn.apache.org/repos/asf/subversion)
>you can use `subversion/trunk` instead of
>`http://svn.apache.org/repos/asf/subversion/trunk.`
>
>

## User Interface


With the option **Use background color in file table to indicate certain
states** you can control whether the file table on the [Project Window](https://www.syntevo.com/doc/display/SUWIP/Project+Window#ProjectWindow-project-window)
may change its background color to indicate certain table states. For
example, the table may take on a yellow background to indicate that it
currently doesn't show the files it would show 'normally', but the files
that match the filter pattern entered into the filter text field on the
top right of the file table.

For **File Name Matches** you can configure the filename search and
filter features in SmartSVN:

-   **Exact case** Requires the search pattern and file name to match in
    case.
-   **Ignore case** Ignores the case for matching search pattern and
    file name.
-   **Smart upper case** Lower case characters in the search pattern can
    match upper- and lower-case characters in the file name. But
    upper-case characters in the search pattern match only upper-case
    characters in the file name. Examples: `SMF` will match
    `SuMainFrame`, but not `SuMainContentFrame`. `fileS` will match
    `FileSignature`, but not `Files`.

## Tools


The configured external tools will be present in the **Tools** menu of
the project window and in files' and directories' context menus.

A tool is defined by the operating system **Command** to be executed and
its **Arguments**. Following variables will be substituted when used as
parts of **Arguments**:

-   `${filePath}`: the file's or directorie's absolute path (including
    name)
-   `${fileUri}`: the file's or directorie's URI
-   `${encoding}`: the file's encoding, derived from `svn:mime-type`
    and `svn:charset`

Alternatively, if the tool can be invoked on a multi-selection,
`${selectionFile}` will be substituted by the path of a temporary file
which contains the paths of all selected files. If `${selectionFile}`
has been specified, `${filePath}`, `${fileUri}` and `${encoding}` will
not be populated.

A tool has a **Menu Item Name** and an optional **Accelerator**. You can
link a specific **Pattern** to an external tool and specify whether
it **Handles** only **Files**, only **Directories** or **Both** of them.
Depending on this configuration it will be present/available on files
and/or directories.

When selecting **Can be used by the Open command**, it will be invoked
on **Open** if the name of the selected file (or directory) is matching
the specified **Pattern**.

If `${filePath}` is used, the working directory of the external tool
will be the file's parent directory, otherwise the working directory
will be the current working directory of SmartSVN.

  


