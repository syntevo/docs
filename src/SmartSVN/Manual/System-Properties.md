# System Properties

The vast majority of SmartSVN's system properties can be configured by
editing the file `smartsvn.properties` in the settings directory.


#### Note
>
>
>The file `smartsvn.properties` contains only settings for SmartSVN
>itself. If you want to configure your Subversion working copies, have a
>look at the Subversion configuration files instead.
>
>

First, open the settings directory. Its default location is described in
[Default Location of SmartSVN's Settings Directory](Installation-and-Files.md#InstallationandFiles-settings-dir.default-location).
In the settings directory, you will find the `smartsvn.properties` file.
Open it with a text editor, such as Windows Notepad.

Each of the settings in `smartsvn.properties` is specified on a separate
line, according to the following syntax: `key=value`. If a line starts
with`     #` , the entire line is treated as a comment and ignored by
the program.

The following list shows the available system property keys:

## Networking

### java.net.preferIPv4Stack

By default, SmartSVN prefers to connect via IPv4. To connect via IPv6
instead, set this option to `false`.

### http.nonProxyHosts

Use these properties to specify servers to connect directly to,
bypassing the configured proxy, for example: `*.foo.com|localhost`.
Note, that only internal code of SmartSVN is honoring
`http.nonProxyHosts`. *This does not include Subversion itself*.

## Update Check

### smartsvn.updateCheck.enabled 

Set to `false` to disable the automatic checking and disallow the manual
checking for new program versions by hiding the corresponding menu items
**Help\|Check for New Version** and **Help\|Check for Latest Build**.
You should only turn this check off for network installations where
SmartSVN users may not be able to perform the update themselves.

If you just want to switch off automatic checking,
use `smartsvn.updateCheck.automatic=false` instead.

### smartsvn.updateCheck.automatic

Set to `false` to disable the **automatic** check for new versions on a
global level which can be convenient e.g. for network installations. To
disable the check for an individual installation/user, better do that in
the **Preferences**, section **SmartSVN Updates**.

### smartsvn.updateCheck.alwaysUpgradeToLatestBuild

Set to `true` to make SmartSVN check for the availability of a
new *latest build* on start up. *Latest Builds* are the "bleeding edge"
builds between subsequent (minor) *release* builds, like between version
8.0.1 and 8.0.2 or 8.1 preview 3 and 8.1 preview 4. They will contain
the latest improvements and bugfixes. Usually we will ask you to
manually fetch the latest build using **Help\|Check for Latest Builds**.

## Debug Properties

### log4j.\[category\]

Use this property to enable debug logging for certain SmartSVN modules;
`[category]` has to be replaced by the appropriate module identifier.



#### Example
>
>
>
>To enable debug logging for the Refreshing modules, set following
>properties:
>
>
>
>``` text
>log4j.smartsvn.refresh=DEBUG
>log4j.sc.vcs.model.refresh=DEBUG
>                    
>```
>
>
>
>
