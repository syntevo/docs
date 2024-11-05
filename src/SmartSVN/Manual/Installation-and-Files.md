# Installation and Files

SmartSVN stores its configuration files per-user.
The root directory of SmartSVN's configuration area contains subdirectories for every major SmartSVN version, so you can use multiple versions concurrently.
The location of the configuration root directory depends on the operating system.

## Location of SmartSVN's settings directory

-   **Windows:**: `%APPDATA%\syntevo\SmartSVN\<major-version>\`
-   **Mac OS:**: `~/Library/Preferences/SmartSVN/<major-version>/`
-   **Linux:**: `~/.config/smartsvn/<major-version>/`


#### Tip
> You can change the directory where the settings files are stored by changing the property [smartsvn.settings](VM-Options.md#location-of-the-settings-directory).

## Notable configuration files

-   `log/` contains debug log information.
-   `license` stores your SmartSVN's *license key*.
-   `passwords` is an encrypted file and stores the passwords used throughout SmartSVN.
-   `accelerators.yml` stores the accelerators (shortcuts) configuration.
-   `project-defaults.yml` stores the [default project settings](Project-Settings.md#default-settings).
-   `projects.yml` stores all configured [projects](Projects.md#Projects-project), including their settings.
-   `repositories.yml` stores the repository credentials, except the corresponding passwords.
-   `settings.yml` stores the settings/preferences [Preferences](Preferences.md#Preferences-preferences) of SmartSVN.
-   `tag-branch-layouts.yml` stores the configured Tag-Branch-Layouts.
-   `tools.yml` stores *external* tools which have been configured in the Preferences.
-   `transactions-standalone.yml` stores the configuration of the [Transactions frame](Transactions-Frame.md#TransactionsFrame-transactions-frame).
-   `ui-config.yml` stores UI related, more stable settings, e.g. the toolbar configurations.
    You may remove this file: afterwards, various aspects of the UI will be reset to defaults.
-   `ui-state.yml` stores UI related, volatile settings, e.g. window sizes or column widths.
    You may remove this file: afterwards, various aspects of the UI will be reset to defaults.

## Program Updates

SmartSVN stores program updates which have been downloaded automatically through SmartSVN itself by default in the subdirectory `updates` of the *Settings* root directory).
This allows light-weight, *patch-like* updates which do not require write access to the actual SmartSVN installation directory.
As a consequence, your SmartSVN installation directory is usually not up-to-date, but it will launch the downloaded updates from the `updates` directory.

### Technical Details

The root directory of the *Updates* directory contains sub-directories for every major version.
Such a *major version* directory contains a `control` file for the latest downloaded build and a `current`-file which points to the currently used build.
Usually, this will be the highest build which shows up in this directory.
The `control`-file only *configures* which binaries are part of the build by linking to the actual binaries which are stored in the `repo`-subdirectory and which are shared among all builds.

Each new build has a corresponding, digitally-signed control file which contains information about all required application files with their download location and the expected file content checksum.
Application files only will be downloaded if they are not yet locally available.
After download, the content will be verified with the checksum from the control file.

When starting SmartSVN, the `bootloader.jar` from the installation directory is launched.
This uses the `control` file from the *Updates* directory to determine which updated SmartSVN files to launch that contain the actual application code.


#### Warning
> By modifying the `control` file or any other contents within the >*Updates* directory, you may easily screw up your SmartSVN installation.
> Hence, do not touch these files unless you have good reasons to do so.

## Company-wide installation

For company-wide installations, the administrator can install SmartSVN on a network share or other (read-only) location.
To make deployment and initial configuration for the users easier, certain configuration files can be prepared and put into the subdirectory `default` (within SmartSVN's installation directory).
For Mac OS this `default` directory must be located in `SmartGit.app/Contents/Resources/` (as sibling to the `Java` directory), for other operating systems within SmartGit's installation directory (as sibling to the `lib` and `bin` directories).

When a user starts SmartSVN for the first time, following files will be copied from the `default` directory to his private configuration area:
-   `accelerators.yml`
-   `project-defaults.yml`
-   `repositories.yml`
-   `settings.yml`
-   `tag-branch-layouts.yml`
-   `tools.yml`
-   `transactions-standalone.yml`
-   `ui-config.yml`
-   `ui-state.yml`

The `license` file (only for 10+ users *Professional* licenses) can also be placed into the `default` directory.
In this case, SmartSVN will prefill the **License** field in the **Setup** wizard when a user starts SmartSVN for the first time.
When upgrading SmartSVN, this `license` file will also be used, so users won't be prompted with an 'license expired' message, but can continue working seamlessly.
