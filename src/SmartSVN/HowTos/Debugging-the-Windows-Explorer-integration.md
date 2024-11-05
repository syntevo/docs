# Debugging the Windows Explorer integration

The Windows Explorer integration consists of two
DLLs `bin\shellext32.dll,` `bin\shellext64.dll`
and `bin\shellnotify.exe` which are referenced and controlled by the
Windows registry. The log file is located at
`%APPDATA%\SmartSVN\explorer-integration.log.`

SmartSVN's main registry entry is located
at `HKEY_LOCAL_MACHINE\SOFTWARE\SmartSVN` which will point to the
currently installed version of SmartSVN.

### Debugging options for the DLLs

Below `HKEY_LOCAL_MACHINE\SOFTWARE\SmartSVN\<version>` you will find
following properties:

-   `debug-logging` - set to `true` to enable additional general debug
    output into the log file
-   `shell-integration-full` - specifies whether overlay icons should be
    enabled at all (`true`)
-   `socket-logging` - set to `true` to enable logging of the
    communication between the DLLs and the main SmartSVN process

The same set of options is duplicated
below `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\SmartSVN`. Depending on
whether your application is 64-Bit or 32-Bit the former or the latter
set of options will be applied.

After changing any of the above options, the `explorer.exe` process must
be restarted. This can be done with the Task Manager, however it's
usually a good idea to restart your entire machine.  
  



Be careful when changing these options – enabling logging may slow down
the integration significantly and may make the log file grow quickly.



### Debugging options for shellnotify.exe

Below `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node`\\SmartSVN\\\<version>
you will find the `notify-logging` option which you can set to `true` to
enable logging for the `shellnotify.exe` process. Logging is written
to `explorer-integration.log` as well.



If you are running a 64-Bit Windows, do not change the 64-Bit option
located at `HKEY_LOCAL_MACHINE\SOFTWARE\`SmartSVN\\\<version> because
it's not honored.



After changing options, `shellnotify.exe` must be restarted: it's
sufficient to kill the `shellnotify.exe` process from the Task Manager.
When invoking the Explorer context menu the next time, it will be
restarted automatically. To make sure logging is properly enabled, check
`explorer-integration.log`: immediately after `shellnotify.exe` has been
restarted, you should find a line like



``` java
ShellNotify::_tWinMain Signaled start successfully
```



### Context menu registry entries

-   `HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\SmartSVN`  
    enables the context menu on files
-   `HKEY_CLASSES_ROOT\directory\shellex\ContextMenuHandlers\SmartSVN`,  
    `HKEY_CLASSES_ROOT\directory\background\shellex\ContextMenuHandlers\SmartSVN`,  
    `HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\SmartSVN`  
    enables the context menu on directories

Following registry scripts can be used to enable/disable the context
menu:

-   [context-menu-register.reg](attachments/2720008/2720018.reg.md)
-   [context-menu-unregister.reg](attachments/2720008/2720019.reg.md)

After running any of these scripts, the `explorer.exe` process must be
restarted. This can be done with the Task Manager, however it's usually
a good idea to restart your entire machine.

### Overlay icon registry entries

Below

-   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers`
-   `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers`

following icon overlays are defined:

-   `SmartSVN1` - modified
-   `SmartSVN2` - added
-   `SmartSVN3` - removed
-   `SmartSVN4` - working copy root/external
-   `SmartSVN5` - unversioned
-   `SmartSVN6` - ignored
-   `SmartSVN7` - conflicted

Windows supports only a very limited amount of overlay icon handlers and
only the first 15 handlers will be invoked at all (taken in alphabetical
order). Hence, the SmartSVN installer will optionally prefix the overlay
handlers by two spaces to make sure they will be at the top of the list.



If overlay icons do not show up, check registered handlers at the two
registry keys given above. If there are multiple other handlers, try to
prefix SmartSVN's handlers by as many spaces as necessary to move them
into first position.



  

  


