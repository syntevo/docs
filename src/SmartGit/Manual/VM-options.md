# VM options

Certain configuration of SmartGit has to be done by *VM options*, in files called `smartgit.vmoptions`.
Usually you will want to specify VM options just for your account (current user):

-   **Windows:** `%APPDATA%\syntevo\SmartGit\smartgit.vmoptions` (`%APPDATA%` is the path defined in the environment variable `APPDATA`)
-   **Linux:** `~/.config/smartgit/smartgit.vmoptions`
-   **MacOS:** `~/Library/Preferences/SmartGit/smartgit.vmoptions`

Alternatively (but **not recommended**), VM options can also be specified system-wide in following files:

-   **Windows:** the global file is `bin\smartgit.vmoptions` in SmartGit's installation directory
-   **Linux:** the global file is `bin/smartgit.vmoptions` in SmartGit's installation directory
-   **MacOS:** the global file is `Contents/MacOS/smartgit.vmoptions` in SmartGit's installation directory `SmartGit.app`

The `smartgit.vmoptions` file contains a list of additional VM options which should be passed to the Java VM.
VM options are basically arguments to Java and every argument must be declared on a separate line.

#### Example
> ```java
> -Xmx2048M
> -Xms1024M
> ```

## Location of the Settings Directory

See [Installation and Files](Installation-and-Files.md) for information about the default location and contents of the settings directory.
On Windows and Linux, you can change its location by modifying the VM option `-Dsmartgit.settings`.


#### Note
> Changing the settings directory's location is *not* supported on MacOS

Within the value of `smartgit.settings`, certain Java system properties are allowed, such as `user.home`.
Another accepted value is the special `smartgit.installation` property, which refers to the SmartGit installation directory.


#### Example
> To tell SmartGit to store its settings in the subdirectory `.settings` of the SmartGit installation directory, add follow line to `smartgit.vmoptions`:
>
>`-Dsmartgit.settings=${smartgit.installation}\.settings` (Windows)
>
>`-Dsmartgit.settings=${smartgit.installation}/.settings` (Linux)

## Location of the Updates Directory

The *Updates* directory contains downloaded program updates.
See [Installation and Files](Installation-and-Files.md) for information about the default location and contents of the *Updates* directory.
On Windows and Linux, you can change its location by modifying the VM option `-Dsmartboot.sourceDirectory`.


#### Example
>To tell SmartGit to store its program updates in the subdirectory `.updates` of the SmartGit installation directory, add follow line to `smartgit.vmoptions`:
>
>`-Dsmartgit.settings=.updates`


## Memory Limit

The memory limit (also known as maximum heap size) specifies how much RAM the SmartGit process is allowed to use.
The memory limit can be configured by the VM option `-Xmx`.

#### Example
> To change the maximum memory limit to 1GB, add following line to `smartgit.vmoptions`:
>
>`-Xmx1024m`

If the set value is too low, SmartGit may run out of memory during memory-intensive operations.


## Extended PATH

On Linux and MacOS, you can extend the PATH used by SmartGit (and all processes invoked by SmartGit, especially Git itself) by adding `path=/additional/path` to `smartgit.vmoptions`.
This `path=` lines can be used multiple times and will be **appended** to the PATH in the order of occurrence.

#### Example
> To make the file `/usr/local/bin/git-lfs` accessible without full path specification, add following line to `smartgit.vmoptions`:
>
>`path=/usr/local/bin`

#### Warning
> Do not specify the Git-LFS file path, but its parent directory's path - as for all usual path modifications!


