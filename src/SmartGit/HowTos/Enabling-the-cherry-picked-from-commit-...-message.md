# Enabling the "cherry picked from commit ..." message

Git's cherry-pick command has an `-x` option that tells Git to
automatically append a "cherry picked from commit ..." message to the
created commits, in order to indicate where the latter came from.
SmartGit does not do this by default, but you can enable it by setting
the following system property:



``` text
-Dsmartgit.cherryPick.shaPrefix="cherry picked from commit"
```



For more information on how to set system properties, see :EXTREF:the
manual:EXTREF:.
