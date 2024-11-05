# Fix Problems with Rocky Linux

On Rocky Linux 9.3 there might be a conflict with the `libsqlite3.so.0` from the system and the one bundled with SmartSVN.

In SmartSVN the GUI library SWT first loads.
As a consequence the `/lib64/libsqlite3.so.0` is loaded by SWT or GTK.
Later, SmartSVN unpacks its bundled SVN libraries into a temp directory like `$HOME/.config/smartsvn/14.4/svn-tmp/15010`.
That also contains a more modern `libsqlite3.so.0` which is required by the other SVN libraries.
But because a `libsqlite3.so.0` already is loaded, it will not load the newer one again - and fail.

As a workaround, please copy the `libsqlite3.so.0` from the `$HOME/.config/smartsvn/14.4/svn-tmp/<build>` directory to, e.g. `<smartsvn-install-dir>/bin` and modify the `smartsvn.sh` script to set the LD_LIBRARY_PATH to this `<smartsvn-install-dir>/bin`.
