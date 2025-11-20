# Dark Mode on Linux

This page gives an overview of potential pitfalls and their solutions to running SmartGit on Linux with enabled dark mode.

# Enabling Dark Mode

Enabling dark mode on Linux can be done system-wide, or application-wide. SmartGit tries to respect the system settings by default. The setting can be overridden manually at `Edit > Preferences > User Interface > Theme`.

# Troubleshooting

A common occurrence when using SmartGit with a dark system theme, or when forcing dark mode by selecting the respective theme in the preferences, is a mismatched look of certain user interface elements.

The reason for this is that most modern Linux Desktop Environments come with GTK-4 installed, and as such use the GTK-4 mechanisms to switch between light- and dark mode. SmartGit currently is using GTK-3, which sometimes needs a bit of persuasion to display correctly.

## Enabling Dark Mode System-Wide

Dark mode can be enabled system-wide for GTK-3 applications using *settings.ini*. Add, or modify, the entry `gtk-application-prefer-dark-theme` to `true`. The settings.ini file is usually found in `~/.config/gtk-3.0/settings.ini`, however its location can vary by distribution. More information on where to find this file is available [in the GTK-3 documentation](https://docs.gtk.org/gtk3/class.Settings.html)

## Enabling Dark Mode for SmartGit only

### Using SmartGit functionality

Since *SmartGit Build 25.1.098*, there's a built-in way to force the dark mode using `smartgit.vmoptions`. Add the line

```
-Dsmartgit.linux.darkmode=true
```

to your `smartgit.vmoptions` file. More information about `smartgit.vmoptions` [can be found here](../../Manual/GUI/AdvancedSettings/VM-options)

### Setting the GTK_THEME environment variable

You can also set the GTK_THEME environment variable for SmartGit to a theme of a dark variant, such as `Adwaita:dark`, or do the opposite using `Adwaita:light` if you prefer the light theme of SmartGit.

