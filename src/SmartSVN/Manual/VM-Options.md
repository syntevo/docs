# VM Options

Certain configuration of SmartSVN has to be done by *VM options*, in
files called `smartsvn.vmoptions`: there is a global file which affects
the entire installation, i.e. is applied to all users and a
user-specific file which only affects the current user and overrides
options from the global file. The location of both files depends on your
operating system:

-   **Windows:** the global file is `bin\smartsvn.vmoptions` in
    SmartSVN's installation directory; the local file is
    `%APPDATA%\syntevo\SmartSVN\smartsvn.vmoptions` (`%APPDATA%` is the
    path defined in the environment variable `APPDATA`)
-   **Linux:** the global file is `bin/smartsvn.vmoptions` in SmartSVN's
    installation directory; the local file is
    `~/.smartsvn/smartsvn.vmoptions`
-   **Mac:** the global file is `Contents/MacOS/smartsvn.vmoptions` in
    SmartSVN's installation directory `SmartSVN.app`; the local file is
    `~/Library/Preferences/SmartSVN/smartsvn.vmoptions`

Following VM options can be specified in either of these two files:

## Location of the Settings Directory

The *settings* contains SmartSVN's settings. See [Installation and Files](Installation-and-Files.md#InstallationandFiles-installation)
for information about the default location and contents of the settings
directory. On Windows and Linux, you can change its location by
modifying the VM option `-Dsmartsvn.settings`.


#### Note
>
>
>Changing the settings directory's location is *not* supported on Mac OS
>X.
>
>

Within the value of `smartsvn.settings`, certain Java system properties
are allowed, such as `user.home`. Another accepted value is the special
`smartsvn.installation` property, which refers to the SmartSVN
installation directory.



#### Example
>
>
>
>To tell SmartSVN to store its settings in the subdirectory `.settings`
>of the SmartSVN installation directory, add follow line to
>`smartsvn.vmoptions`:
>
>`-Dsmartsvn.settings=${smartsvn.installation}\.settings` (Windows)
>
>`-Dsmartsvn.settings=${smartsvn.installation}/.settings` (Linux)
>
>

## Location of the Updates Directory

The *Updates* directory contains downloaded program updates. See
[Installation and Files](Installation-and-Files.md#InstallationandFiles-installation)
for information about the default location and contents of the *Updates*
directory. On Windows and Linux, you can change its location by
modifying the VM option `-Dsmartboot.sourceDirectory`.



#### Example
>
>
>
>To tell SmartSVN to store its program updates in the subdirectory
>`.updates` of the SmartSVN installation directory, add follow line to
>`smartsvn.vmoptions`:
>
>`-Dsmartsvn.settings=.updates`
>
>

## Used Java Runtime Environment

### Windows

Use the Windows environment variable `SMARTSVN_JAVA_HOME` to tell
SmartSVN which JRE to use.



#### Example
>
>
>
>To switch to a JRE located at in `C:\Program Files (x86)\Java\jre8`, set
>the environment variable
>`SMARTSVN_JAVA_HOME=C:\Program Files (x86)\Java\jre8`.
>
>

### Linux

On Linux, you can configure the JRE to be used by adding
`jre=/path/to/jre` to `smartsvn.vmoptions`.



#### Example
>
>
>
>To tell SmartSVN to use the JRE located in `/opt/jre/jre32/jre1.7.0`,
>add following line to `smartsvn.vmoptions`:
>
>`jre=/opt/jre/jre32/jre1.7.0`
>
>

## Memory Limit

The memory limit (also known as maximum heap size) specifies how much
RAM the SmartSVN process is allowed to use. The memory limit can be
configured by the VM option `-Xmx`.



#### Example
>
>
>
>To change the maximum memory limit to 1GB, add following line to
>`smartsvn.vmoptions`:
>
>`-Xmx1024m`
>
>

If the set value is too low, SmartSVN may run out of memory during
memory-intensive operations.


#### Note
>
>
>32-Bit Java VMs only allow to configure a maximum memory limit of
>roughly `1200M`. For almost all setups and repository sizes, this should
>be sufficient. If not, this usually indicates a problem, thus please
>contact us at support@smartsvn.com.
>
>
