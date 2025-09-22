# https: Remember different passwords for same server

If you need to use a different password for different repositories at
the same server, set the Git option `useHttpPath`:

    $ git config --global credential.<server>.useHttpPath true
