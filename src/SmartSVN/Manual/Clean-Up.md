# Clean Up

Use **Modify\|Clean Up** to clean up unfinished SVN operations for the
selected directory (and all subdirectories). Cleaning up a working copy
is necessary when the working copy becomes 'internally' locked (in
contrast to file locks, see
[Locks](Locks.md#Locks-commands.locks)). A working copy can
become locked when certain SVN operations (like commit or update) are
aborted. In general, cleaning up a working copy is a safe process.


#### Note
>
>
>A clean up may fail for the same reasons for which the preceding SVN
>operation has failed. This typically happens if certain files or
>directories can't be read or written. In such cases, please check
>whether other running processes might lock the file and whether file
>permissions have been set adequately.
>
>
