# git: '...' is not a git command

If running certain commands from SmartGit fails, which work when running from command line, this is usually caused by a different `PATH` environment of SmartGit.
This happens e.g. when extending the `PATH` in files like `~/.bash_profile, ~/.bash_login, and ~/.profile`.
Because SmartGit is not starting an interactive shell, these files won't be processed.
The solution is to specify the `PATH` either in a file which will be processed by the system when starting SmartGit (for macOS, see [this Stackoverflow answer](https://stackoverflow.com/a/3756686)) or by adding `PATH`= to `smartgit.vmoptions`, see [VM Options](../Latest/VM-options.md).

Typical failures:

-   `git: 'credential-osxkeychain' is not a git command.`
