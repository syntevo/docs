# EOL-Style

Use **Properties\|EOL-Style** to change the *EOL-Style* (line separator)
of the selected files. The EOL-style is used when updating or checking
out a text file and results in a corresponding conversion of its line
endings:

-   **Platform-dependent** converts to the platform's native line
    separators.
-   **LF**, **CR**, **CR+LF** converts to the corresponding line
    separators, regardless of the current platform.
-   **As is** performs no conversion.

In the [project settings](Project-Settings.md#eol-style)
, the default EOL-style which will be applied to every added file can be
specified. By default, this will be **Platform-dependent**.

When changing the EOL-style of a file, SmartSVN checks whether the file
has consistent line endings. If this is not the case, it will reject to
change the EOL-style (other behaviors can be configured in the project
settings). To skip this check, use **Force**.
