# User Interface Preferences

## User Interface
The User Interface settings allow configuration of all visual elements in SmartGit.
After making changes to preferences, select `OK` to confirm and apply changes.

![SmartGit User Interface Preferences](<../../images/Preferences-user-interface-themes.png>)

### Language
This option allows the language on the SmartGit UI to be changed.
> [!NOTE]  
> After changing the language, you will need to restart SmartGit in order for the new language to take effect.

### Theme Selection
Changing the theme will affect the visual appearance of SmartGit. This includes the Text Fonts, Colors and Background displayed in SmartGit.

SmartGit will automatically select a default light or dark theme based on your current operating system preference, for instance, if you are using Windows in `Dark Mode`, then SmartGit will default to using its `Dark Mode` theme.

Once a theme has been selected, it is also possible to override individual theme attributes using the [Built In Text Editor](#built-in-text-editors).

 **Advanced Users Only**: It is possible to provide custom `.theme` files, in addition to the standard Light and Dark mode themes. Refer to [Theme Customization](<../Advanced Settings/Theme-Customization.md>) for details.

### Startup Window
This option allows selection of the initial Window view when SmartGit starts up. Refer to [Main Windows Documentation](../Main-Windows)  for further details.

### On Startup
**TODO**

### File Name Matches
**TODO**

### Date and Time Format
**TODO**

### Restore all Confirmation Dialogs

Ticking this option will restore the original confirmation dialogs, and SmartGit will again prompt you for confirmation for important actions.


## Built-in Text Editors

### Fonts and Colors
SmartGit supports syntax highlighting for a large number of popular coding languages. The `Fonts and Colors` tab allows customization of the display of files containing code across SmartGit.

For each highlighting class or context, the Foreground Font Family, Size and Color, as well as Background Color, can be customized.

#### Font Family
This selects the font used to display code.
The choice of available fonts may vary, depending on the fonts installed on your operating system.

#### Show only fixed-width fonts
It is recommended that you restrict your choice of font to fixed-width fonts, as this will ensure that code alignment is preserved. Ticking this option will remove any fonts which are not fixed-width from the available font selection.

#### Font Size
You can input a numeric font point-size to control the size of the font.
Values between 8 and 12 are recommended, depending on the resolution of your screen.

#### Foreground and Background Color Selection
![Changing Font Colors](<../../images/Preferences-user-interface-fonts-and-colors.png>)

Click on a visual text element with the Right Mouse button to configure the Color used for that element.
If you are not satisfied with the color setting, you can choose `Reset to default` to return the element to the default theme value.
