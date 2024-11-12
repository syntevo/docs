# Customizing SmartGit's theme colors

You can customize certain colors in SmartGit by patching its themes.
The custom colors are configured in files `light-patch.theme` and `dark-patch.theme` in [SmartGit's Settings Directory](#Company-wideinstallation-settings-dir.default-location).
Depending on the selected theme from the Preferences, the appropriate file will be used.
In case of automatic theme selection (which is the default), your system theme (light or dark) will determine the used file.

#### Note
> These files only will be read on SmartGit start.

## List of customizable colors

To get a complete list of customizable colors, you can run SmartGit from command line using parameter `--write-default-theme-file`.

#### Example
>
>On Windows, you have to run `smartgitc.exe`:
>```
>smartgitc.exe --write-default-theme-file
>```

This will create `own-dark.theme` and `own-light.theme` files in SmartGit's settings directory which will contain all keys and their defaults.
You can now copy over selected keys to your `patch`-files; be sure to drop the leading comment mark `#`.

### Sample colors

The following is an incomplete list of important theme colors which can be customized.

```
ahead#branches
graph.aheadBehindDimmedForeground
graph.aheadBehindForeground
graph.auxColumn.text
graph.auxColumn.text.changed
graph.branch.auxiliary
graph.branch.local
graph.branch.other
graph.branch.remote
graph.connector.1
graph.connector.2
graph.connector.3
graph.connector.4
graph.connector.5
graph.connector.6
graph.connector.7
graph.connector.8
graph.connector.9
graph.connector.10
graph.connector.11
graph.connector.12
graph.connector.13
graph.connector.14
graph.connector.15
graph.connector.16
graph.connector.ahead
graph.connector.auxiliary
graph.connector.available
graph.connector.behind
graph.connector.common
graph.connector.head
graph.connector.multiple
graph.connector.other
graph.connector.unavailable
graph.disabledBackground
graph.disabledForeground
graph.dot.anchor
graph.dot.bisectBad
graph.dot.bisectGood
graph.headarrow
graph.ref.border
graph.signed
graph.tag
graph.text
graph.truncatedBackground
graph.truncatedRefs
```

#### Example
> Following `light-patch.theme` will give an almost identical palette as for version 21.2:
>
>``` text
>graph.connector.1=derive(#80ff00, 0.7, 0.7)
>graph.connector.2=derive(#0000ff, 0.6, 0.9)
>graph.connector.3=derive(#ff8000, 0.6, 0.95)
>graph.connector.4=derive(#c000c0, 0.5, 0.9)
>graph.connector.5=derive(#0080ff, 0.7, 0.8)
>graph.connector.6=derive(#ffff00, 0.8, 0.7)
>graph.connector.7=derive(#00ff40, 0.8, 0.7)
>graph.connector.8=derive(#ff0000, 0.8, 0.7)
>graph.connector.9=derive(#80ff00, 0.7, 0.7)
>graph.connector.10=derive(#0000ff, 0.6, 0.9)
>graph.connector.11=derive(#ff8000, 0.6, 0.95)
>graph.connector.12=derive(#c000c0, 0.5, 0.9)
>graph.connector.13=derive(#0080ff, 0.7, 0.8)
>graph.connector.14=derive(#ffff00, 0.8, 0.7)
>graph.connector.15=derive(#00ff40, 0.8, 0.7)
>graph.connector.16=derive(#ff0000, 0.8, 0.7)
>```

#### Example
> This will use a light-yellow tag symbol background in the graph as until SmartGit 21.2.
>```text
>graph.tag=#FFF1BF
>```
