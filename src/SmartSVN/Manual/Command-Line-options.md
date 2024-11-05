# Command-Line options

SmartSVN supports a couple of command line arguments.

-   `--server-mode` will just start up the core process and bring up the
    [tray icon](Shell-Integration.md#tray-icon)
    , if present. This startup mode is used for the [Shell Integration](Shell-Integration.md#ShellIntegration-shell-integration)
    .
-   `--exit` will try to detect a running *SmartSVN* process and force
    this process to exit. This allows to stop SmartSVN programmatically.
-   `--transactions` will bring up the [Transactions Frame](Transactions-Frame.md#TransactionsFrame-transactions-frame)
    instead of the [Project Window](Project-Window.md#ProjectWindow-project-window) on
    startup.
-   `--repository-browser` will bring up the [Repository Browser](Repository-Browser.md#RepositoryBrowser-repository-browser)
    instead of the [Project Window](Project-Window.md#ProjectWindow-project-window) on
    startup.
-   *project-path* will bring up the [Project Window](Project-Window.md#ProjectWindow-project-window)
    and load the project containing the specified *project-path*.
