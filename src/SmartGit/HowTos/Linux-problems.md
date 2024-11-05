# Linux problems

# Permission denied error

If you are getting an error similar to `Cannot run program "/usr/bin/git" (in directory "/usr/bin"): error=13, Permission denied` (was reported for Gentoo Linux), try adding the following line to `~/.config/smartgit/<main-version>/smartgit.properties`:

```
jdk.lang.Process.launchMechanism=VFORK
```

and restart SmartGit.
It might be necessary to try also the option `POSIX_SPAWN` instead of `VFORK`.


# Copy-Paste problems

If copy-pasting always pastes at the end, ensure that the **Pointer Location** feature in the Gnome Tweaks tool is **disabled** (red).

![](attachments/53215604/53215603.png)


