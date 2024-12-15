# SmartGit Installation File Locations

SmartGit stores its internal settings files independently for each user. 
Each major SmartGit version has its own default settings directory, so you can use multiple major versions of SmartGit without impacting other versions.
The location of the settings directory depends on the operating system.

## Default Path of SmartGit's Settings Directory

Below are the locations of SmartGit's settings files, depending on the OS:

- **Windows** `%APPDATA%\syntevo\SmartGit\<major-smartgit-version>`
  (`%APPDATA%` is the path defined in the environment variable `APPDATA`)
- **MacOS** `~/Library/Preferences/SmartGit/<major-smartgit-version>`
  (the Finder might not show the `~/Libraries` directory by default, but you can invoke `open ~/Library` from a terminal)
- **Linux** `${XDG_CONFIG_HOME}/smartgit/<major-smartgit-version>`
  (if the environment variable `XDG_CONFIG_HOME` is not defined, `~/.config` is used instead)

#### Tip

>
>You can change the directory where the settings files are stored by changing the property
> [smartgit.settings](../GUI/AdvancedSettings/VM-options.md#location-of-the-settings-directory).
> This is used by the portable bundle for Windows.
>

## Notable Files in the Settings Directory

- `license` stores your SmartGit *license key*.
- `logs/*` contains debug log information, for example, `logs/log.txt.0` contains the most recent logging. It can be configured via `logger.properties`. If you delete or move this file, SmartGit will return to its default logging settings.
- `passwords` is an encrypted file and stores the *passwords* used throughout SmartGit. If you delete or move this file, all passwords will be lost (e.g. you will need to re-authenticate with remotes).
- `repository-cache` stores all cached information about repository states, e.g. what local branch is checked out, whether there are incoming or outgoing changes.
- `accelerators.yml` stores the *accelerators* (keyboard shortcuts) configuration. If you remove this file, all accelerators will be reset to their defaults.
- `bugtracker.yml` stores configuration information for JIRA integration (if applicable).
- `credentials.yml` stores authentication information (but does not include corresponding passwords). You probably do not want to remove this file, as doing so will lose all credentials (user names, private keys, certificates).
- `hosting-providers.yml` stores information about configured hosting provider accounts (not including the corresponding passwords). You probably do not want to remove this file, as this will lose all connect details for all hosting provides.
- `notifications.yml` stores information about the state of notifications which show up in the status bar in various cases. If you remove this file, SmartGit will default to showing all notifications (as per initial installation).
- `preferences.yml` stores the application-wide settings (preferences) of SmartGit. You should not remove this file, unless you want to completely reset SmartGit.
- `repositories.yml` stores information about known repositories and submodules, e.g. recently used commit messages.
- `repository-grouping.yml` stores information about added repositories, their names and repository groups.
- `tools.yml` stores *external* tools which have been configured in [Preferences](../GUI/Preferences/index.md). You probably do not want to remove this file, as all external tools configurations will be lost. However, if you've set up all tool configurations you believe your team needs, you can then share this file with your team mates.
- `ui-config.yml` stores UI related, more stable settings, e.g. the toolbar configurations. Removing this file will reset affected aspects of the UI back to defaults.
- `ui-state.yml` stores UI related, volatile settings, e.g. window sizes and positions or column widths. Removing this file will reset affected aspects of the UI back to defaults.

### Resetting certain parts of the configuration to defaults

To reset certain parts of SmartGit's configuration ("settings") back to installation defaults:

1. Locate the appropriate configuration file (`*.yml`)
2. Exit SmartGit, using **Repository\|Exit**
3. Move or delete the file(s)
4. Restart SmartGit

### Synchronizing settings when running multiple SmartGit versions in parallel

A common case where you might be running two SmartGit versions in parallel is when having the latest release installed ("*older version*", e.g. 18.2) and you are giving the current preview version a try ("*newer version*", e.g. 19.1). Once you are first installing/starting the *newer version* it will copy over settings from the *older version*. From that point of time, settings will diverge. You may synchronize the settings of the *newer version* from the *older version* at any time by the following procedure:

1. Start the *older version*, invoke **Help\|About** and from **Information** page and write down the **Settings Path** ("*old settings directory*")
2. Shutdown the *older version*
3. Start the *newer version,* invoke **Help\|About** and from **Information** page and write down the **Settings Path** ("*new settings directory*")
4. Shutdown the *newer version*
5. From the command line or file manager, make a backup of all files from the *new settings directory*, then delete all files to finally have an empty directory
6. Copy over all files from the *old settings directory* to the *new settings directory*
7. Restart the *newer version*

#### Note

> It is not possible to synchronize settings from a *newer version* to an *older version*, as the newer version may have new settings which are incompatible with the older version.

## Program Updates

SmartGit stores program updates which have been downloaded automatically through SmartGit itself by default in your home directory/profile. This allows "light weight", *patch-like* updates which do not require write access to the actual SmartGit installation directory. As a consequence, your SmartGit installation directory is usually not up-to-date, but it will detect and launch the downloaded updates from the `updates` directory. Occasionally, SmartGit will detect that an upgrade of the installation directory itself is necessary ("installation update"). Depending on your operating system, the *updates cache* can be found at:

- **Windows**: `%APPDATA%\syntevo\SmartGit\updates`
- **MacOS**: `~/Library/Application Support/SmartGit/updates`
- **Linux**: `${XDG_DATA_HOME}/.local/share/smartgit/updates`

#### Tip

>
>
>You can manually trigger the update of the installation directory from the **About** dialog, section **Information**, **...**-button right
> beside **Version**.
>
>If you prefer to keep your SmartGit installation *always* up-to-date, you can select **Update SmartGit application in place** in the
> Preferences, section **SmartGit Updates**. Note, that updating with this option selected may require administrator privileges.
>

### Technical Details

The root directory of the *Updates* directory contains sub-directories for every major version. Each *major version* directory contains a `control` file for the latest downloaded build and a `current`-file which points to the currently used build. Usually, this will be the highest build which shows up in this directory. The `control`-file only *configures* which binaries are part of the build by linking to the actual binaries which are stored in the `repo`-subdirectory and which are shared among all builds.

Each new build has a corresponding, digitally-signed control file which contains information about all required application files with their download location and the expected file content hash. To reduce bandwidth, application files only will be downloaded if they are not yet locally available. After download, the content will be verified with the hash from the control file.

When starting SmartGit, the `bootloader.jar` from the installation directory is launched. This uses the `control` file from the *Updates* directory to determine which updated SmartGit files to launch that contain the actual application code.

#### Warning

>
>
>Modifying the `control` file or any other contents within the *Updates* directory, may easily break your SmartGit installation, causing unexpected behaviour.
> Do not touch files in the *Updates* directory unless you have good reasons to do so.
>
>

#### Tip

> 
> On Windows, if you encounter file system access issues during an installation update, it might be related to Windows itself or the Attack Surface Reduction (ASR) feature in Windows Security. In such cases, you can try excluding the `SmartGit` and `SmartGit.new` directories from this feature. For example, if SmartGit is installed at `C:\Program Files\SmartGit`, execute the following command in an elevated PowerShell (Administrator mode):
> ```
> Add-MpPreference -AttackSurfaceReductionOnlyExclusions "C:\Program Files\SmartGit"
> Add-MpPreference -AttackSurfaceReductionOnlyExclusions "C:\Program Files\SmartGit.new"
> ```

## JRE Search Order (Windows)

On Windows, the `smartgit.exe` launcher will search for a suitable Java Runtime Environment on your computer in the following order (from top to bottom):

- Environment variable SMARTGIT_JAVA_HOME
- Subdirectory `jre` within SmartGit's installation directory
- Environment variable JAVA_HOME
- Environment variable JDK_HOME
- Registry key HKEY_LOCAL_MACHINE\\SOFTWARE\\JavaSoft\\Java Runtime Environment

## Installing/running multiple SmartGit versions in parallel

You can install multiple versions of SmartGit in parallel and you can even run them at the same time. This will be useful if you want to primarily work with an upcoming *Preview* version, but have the *latest released* version still present as *fall back*. SmartGit has separate settings areas for different versions, so running parallel versions of "installation" requires selecting different folder locations for each version:

- On **Linux**, simply unpack every SmartGit bundle you want to use to a different directory
- On **MacOS**, simply unpack every SmartGit DMG you want to use to a different directory
- On **Windows**,
    - either use **only portables bundles** for every SmartGit version you want to work with and unpack them to different directories
    - use **exactly one installer bundle** for the primary SmartGit version you want to work with and **additional portable bundles** for the other version(s)

## Windows Portable Bundle

The Windows Portable Bundle is set up with the settings directory configured to `.settings` and the updates directory configured to `.updates`. To update the Portable Bundle manually:

- Shut down SmartGit
- Move `.settings` and `.updates` to a temporary directory
- Remove all contents from the remaining installation (this step is important!)
- Recreate the installation from the new Portable Bundle
- Move `.settings` and `.updates` back into place
- Start SmartGit
