# System Properties

Most of the system properties can be edited directly in the **Preferences**, section **Low-Level Properties**.
This will adjust the `smartgit.properties` file which is located in [SmartGit's Settings Directory](Installation-and-Files.md#default-path-of-smartgits-settings-directory).
Only some specific properties may require to edit `smartgit.properties` directly.

Each of the settings in `smartgit.properties` is specified on a separate line, according to the following syntax:

`key=value`

If a line starts with`#`, the entire line is treated as a comment and ignored by SmartGit.
The file encoding is `UTF-8`.

#### Note
> The file `smartgit.properties` contains only settings for SmartGit itself.
> If you want to configure your Git repositories, have a look at the various Git configuration files instead, such as `.git/config` for the configuration of individual Git repositories, and `~\.gitconfig` (in your HOME directory) for global configuration options.

## Networking

### java.net.preferIPv4Stack

By default, SmartGit prefers to connect via IPv4.
To connect via IPv6 instead, set this option to `false`.

### http.nonProxyHosts

Use these properties to specify servers to connect directly to, bypassing the configured proxy, for example: `*.foo.com|localhost`.
Note, that only internal code of SmartGit is honoring `http.nonProxyHosts`.
*This does not include Git itself.*

## Company-wide configuration

### smartgit.setupFinishedUrl

This setting specifies the URL to open after SmartGit has been started for the first time and the setup wizard was completed.

### smartgit.preferences.\<category>.visible

You can use this system property to hide certain **Preferences** pages.
Available categories are:

-   `executables`
-   `externalTools`
-   `compareTools`
-   `conflictSolver`
-   `spellCheck`
-   `proxy`
-   `updateCheck`
-   `bugReports`

To hide a specific page, set the corresponding property to `false`.



#### Example
> To hide the **Tools** page, set:
> ``` text
> smartgit.preferences.externalTools.visible=false
> ```

### smartgit.contactSupportEnabled

Set this option to `false` to hide the menu item **Help\|Contact Support**.

### smartgit.registerEnabled

Set this option to `false` to hide the menu item **Help\|Register**.

## Update Check

### smartgit.updateCheck.enabled

Set to `false` to disable the automatic checking and disallow the manual checking for new program versions by hiding the corresponding menu items **Help\|Check for New Version** and **Help\|Check for Latest Build**.
You should only turn this check off for network installations where SmartGit users may not be able to perform the update themselves.
When settings this option, you will probably also want to hide the corresponding page from the **Preferences**, using [smartgit.preferences.updateCheck.visible](#smartgitpreferencescategoryvisible).

Note that this will also disable notifications of new bugfix releases which you can upgrade to for free and which improve the stability or reliability of SmartGit.

If you just want to switch off automatic checking, use `smartgit.updateCheck.automatic=false` instead.

### smartgit.updateCheck.automatic

Set to `false` to disable the **automatic** check for new versions on a global level which can be convenient e.g. for network installations.
To disable the check for an individual installation/user, better do that in the **Preferences**, section **SmartGit Updates**.

### smartgit.updateCheck.alwaysUpgradeToLatestBuild

Set to `true` to make SmartGit check for the availability of a new *latest build* on start up.
*Latest Builds* are the "bleeding edge" builds between subsequent (minor) *release* builds, like between version 8.0.1 and 8.0.2 or 8.1 preview 3 and 8.1 preview 4.
They will contain the latest improvements and bugfixes.
Usually we will ask you to manually fetch the latest build using **Help\|Check for Latest Builds**.

### smartgit.updateCheck.checkForLatestBuildVisible

Set to `false` to hide **Help\|Check for Latest Build**.

### smartgit.installation.update.workingArea

Use this property to customize the [program updater](Installation-and-Files.md)'s temporary directory, which is by default located in your home directory/profile.
This should only be necessary if updating is not possible due to (file system) restrictions in this default directory, e.g. if execution of files is prevented by the system.
On Windows, paths have to be specified using forward-slashes, like `c:/temp`.

## Bug Reporting

### smartgit.disableBugReporting

Set to `true` to disable sending of [crash footprints](Bug-Reports.md) (even if configured in the **Preferences**) and skip the option to send bug reports to us.
When setting this option, you will probably also want to hide the corresponding page from the **Preferences**, see [smartgit.preferences.bugReports.visible](#smartgitpreferencescategoryvisible).


#### Warning
> When using this option, be sure to provide an alternative way for your users to report SmartGit bugs to you, otherwise they will go unnoticed.


### smartgit.license.defaultPath

By default, SmartGit will look for a "default" license file in the [installation default directory](Company-wide-installation.md).
You can use this system property to specify a different **file system path** for the default license to look for.


#### Example
> To have SmartGit take the default license from `\\license-server\smartgit\license`, set:
>`smartgit.license.defaultPath=\\\\license-server\\smartgit\\license`

### smartgit.license.alwaysCheckForNewerDefaultLicense

By default, SmartGit will only look for a default license, if there is **no** or **no valid** existing license.
Sometimes, it may be desirable to replace even **valid** licenses by newer default licenses.
To do so, set:

#### Example
>`smartgit.license.alwaysCheckForNewerDefaultLicense=true`


## Debug Properties

### logging.\[category\]

Use this property to enable debug logging for certain SmartGit modules; `[category]` has to be replaced by the appropriate module identifier.


#### Example
>To enable debug logging for the Refreshing modules, set following properties:
> ``` text
> logging.smartgit.refresh=DEBUG
> logging.sc.vcs.model.refresh=DEBUG
> ```
