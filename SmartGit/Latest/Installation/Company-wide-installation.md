---
redirect_from:
  - /SmartGit/Latest/Company-wide-installation.html
  - /SmartGit/Latest/Company-wide-installation
---
# Company-wide installation

For company-wide installations, the administrator may install SmartGit on a read-only location or network share or customize the installation process by e.g. using batch files.
To set up a custom initial configuration for the users, certain settings files can be prepared and put into a directory named `default`.
For MacOS this `default` directory must be located in `SmartGit.app/Contents/Resources/` (parallel to the `Java` directory), for other operating systems within SmartGit's installation directory (parallel to the `lib` and `bin` directories).

When a user starts SmartGit for the first time, the following files will be copied from the `default` directory (on the network share) to the user's personal SmartGit settings directory (refer to [Default Path of SmartGit's Settings Directory](Installation-and-Files.md#default-path-of-smartgits-settings-directory)):
-   `smartgit.properties`
-   `accelerators.yml`
-   `credentials.yml`
-   `hosting-providers.yml`
-   `preferences.yml`
-   `repository-grouping.yml`
-   `tools.yml`
-   `ui-config.yml`
-   `ui-state.yml`

The `license` file (only for 10+ user *Commercial* licenses) can also be placed into the `default` directory.
In the latter case, SmartGit will prefill the **License** field in the **Set Up** wizard when a user starts SmartGit for the first time.
When upgrading SmartGit, this `license` file will also be used, so users won't be prompted with a 'license expired' message, but can continue working seamlessly.


#### Note
> Be sure to name the license file `license` in the `default` directory without any extension.
> There are a couple of [system properties](System-Properties.md#license-userseat-tracking) related to SmartGit's license management.

To preconfigure only a subset of default options to custom values and leave initialization of other defaults to SmartGit, you may provide reduced versions of the settings `.yml` files in the `default` directory.


Example

If you want to preconfigure the used Git executable to `C:\path\to\your\preferred\bin\git.exe`, you may use following `settings.yml` file:

```
git:
  executable: C:\path\to\your\preferred\bin\git.exe
```


### System properties vs. VM options

From a technical perspective, [system properties](System-Properties.md) and [VM options](VM-options.md) are the same thing, they are just specified in different files.
System properties are specified in `smartgit.properties` in the [SmartGit's Settings Directory](Installation-and-Files.md#default-path-of-smartgits-settings-directory), VM options are specified in the `smartgit.vmoptions` file.
From an administrative perspective, it's recommended to configure all system properties in the `smartgit.vmoptions` file and leave individual user `smartgit.properties` files untouched.


#### Note
> `smartgit.vmoptions` is loaded before `smartgit.properties` and thus properties present in `smartgit.vmoptions` have precedence over the same properties specified in `smartgit.properties`.
> This way, when having a read-only installation of SmartGit you can configure SmartGit in a pretty safe way using `smartgit.vmoptions`.


### Overriding Defaults

By default, the files from the `default` directory will only be copied during the initial setup of the user's SmartGit installation.
In certain scenarios, it may be desirable to replace a configuration even after SmartGit has been set up for a user.
For example, the **Tools** may be managed by the administrator and updated from time to time.
User should receive these updates regardless whether their SmartGit is already set up or not.
In this case, you can use the [VM option](VM-options.md) `smartgit.startup.settingsToReplaceFromDefaults` to force overwriting (i.e. to reset) the specified files in the user's settings directory.


#### Example
>To reset `tools.yml` on every start, add following line to `smartgit.vmoptions`:
>```
>-Dsmartgit.startup.settingsToReplaceFromDefaults=tools.yml
>```

You can modify the `.yml` file in the `default` directory to only those values that should be overridden or removed (the key needs to be prefixed with a leading minus sign).
For lists the default items will be added first and user items are only kept if not equal to a default item.
List items that should be removed, need to have a key-value paid of `__merge__: delete`.

### Hide Preferences

When you are providing initial defaults or specify to overwrite defaults, you usually don't want the user to change these settings in the **Preferences**.
Therefore, you might want to hide certain **Preferences** pages, using [system properties](System-Properties.md#smartgitpreferencescategoryvisible).
