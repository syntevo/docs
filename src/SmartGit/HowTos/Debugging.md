# Debugging

## General advices/preparations

Always try to investigate problems with a fresh SmartGit setup:

-   on Windows, use the *Portable* bundle: <https://www.syntevo.com/smartgit/download/>
-   on macOS and Linux, temporarily use a new [smartgit.settings](../Latest/VM-options.md#location-of-the-settings-directory) directory

#### Why?
> SmartGit has plenty of **Preferences** options and even more
> **Low-Level Properties** which may sometimes affect the behavior of
> operations in non-obvious ways. This is especially true if the
> behavior you are experiencing is unexpected and/or looks like a bug.

### Clean Logs

#### Note
> When starting with fresh settings as explained above, this implies clean logs and you won't have to run through the following instructions when investigating a problem for the first time.
> Also, the Settings Path will match your `smartgit.settings` from above.

Before investigating a problem, restart SmartGit with clean logs:

- locate the [Settings Path](../Latest/Installation-and-Files.md) in the **Help\|About** dialog
- shut down SmartGit
- from the sub-directory `logs/` remove all `log.txt*` files
- restart SmartGit

### Reproduce the problem

Once SmartGit has been restarted, immediately proceed with reproducing the problem. Once reproduced, shut down SmartGit again.

### Send results

When sending logs to us, make sure they are **compressed** either with *ZIP* or *7z*. This prevents the logs from becoming inlined in the email. Include the stripped-down settings (see above), if the problem isn't reproducible with clean settings.

### Strip down settings

If the problem is not reproducible with fresh settings, try to copy the settings from your main installation over to the new settings area. This should make the problem reproducible again. Now start to strip down the settings as much as necessary (e.g., to get rid of possibly sensitive information, especially the `passwords` file). Most crashes will be preserved as long as `preferences.yml` is left untouched. Once the settings are stripped down enough, compress them and include them with the logs (see below).

## Enabling debug logging for certain keys

To enable debug logging for a certain key `logging.foo.bar`, first decide the log level – whether it should be fine (`DEBUG`) or as fine as possible `TRACE`. Usually SmartGit support will tell you. After that, add the corresponding line to `smartgit.properties` (in the Settings directory, see [Installation and Files](../Latest/Installation-and-Files.md)). Depending on the log level, this will be either:

**DEBUG logging**

``` java
logging.foo.bar=DEBUG
```
Or:

**TRACE logging**

``` java
logging.foo.bar=TRACE
```
After that, restart SmartGit and repeat the operation for which debug logging should be collected and shut down SmartGit again.

Now `logs/log.txt.0` should contain `DEBUG` (or `TRACE`) lines for the specified key.
