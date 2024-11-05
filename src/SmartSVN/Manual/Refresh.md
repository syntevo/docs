# Refresh

When a project is opened, the contents of the directory tree and the
file table are initialized by reading at least the contents of the root
directory into memory. Whether the complete project should also be read
into memory at project startup or not can be configured in the project
settings ([Project Settings](Project-Settings.md#ProjectSettings-project.settings)).

The scanning and refreshing of the project's directories and files is in
general performed in the background, so you can immediately start to
work after opening a project and you may continue to work while the
project is refreshed. If a Refresh is currently in progress, the status
bar shows a **Refreshing** text and symbol.



The initial scanning/refresh is in general much slower than subsequent
refreshes due to the *system disk cache*.





A manual **View\|Refresh** will be needed, if you are performing SVN
operations with another SVN client (i.e. outside of SmartSVN).

SmartSVN is only refreshing *relevant* parts and with changes to
`.svn/`-admin area it's hard to tell what's *<u>relevant</u>*. On the
other hand, usually, the `.svn/`-admin is only changed by SVN clients.
Hence, SmartSVN has two options:

\(1\) process .`svn/`-admin area file monitor events (because they might
originate from a different SVN client) and refreshing the entire working
copy recursively or

\(2\) don't process these events (because they have been produced by
SmartSVN itself and hence are redundant).

Given commonness of these use cases and performance reasons, we have
have opted for (2).


