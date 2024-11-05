# Running on WSLg

This page is dedicated to running SmartGit on Windows Subsystem for Linux with GUI (WSLg).
WSLg allows running GUI based Linux applications, such as SmartGit, in emulated Linux environment on Windows.
This is convenient if you need to mix Windows and Linux development and prefer Windows as main OS.

#### Note
> You'll need **Win10 update 21H2** or a recent **Win11 or higher**, because older versions will only support plain WSL.

# WSLg installation

Run this command in administrator commandline:
```
wsl --install -d Ubuntu
```
After a Windows reboot, a console starts automatically to continue installing Ubuntu, especially to create a user account.
Also, find the new Start menu item `Ubuntu` to launch it.

#### Tip
>Run these commands in WSL terminal to make sure that WSLg and the GUI, especially GTK3, works as intended:
>```
>sudo apt update
>sudo apt install gedit
>gedit
>```
>
>You should see `gedit` window open in your Windows. If this doesn't happen, then either you don't have WSLg or it's broken in some way.

# SmartGit installation

1. Download SmartGit to WSLg
   * On Windows, navigate to the [SmartGit download](https://www.syntevo.com/smartgit/download/)
   * Click `Download for Linux`
   * Start `Ubuntu` from Windows Start menu. This will open a console, you'll use it later.
   * In your Windows Explorer, notice `Linux` item on side panel.
   * Navigate to location where you want to install SmartGit on Linux, such as<br>
      `Linux\Ubuntu\home\user`<br>
      (replace `user` with your configured Ubuntu username)
   * Copy the `.tar.gz` file you downloaded to this folder in Windows Explorer
2. In `Ubuntu on Windows`, run these commands:<br>
   * `cd ~`<br>
     If you downloaded SmartGit to a different folder, adjust this step.
   * `tar xvzf smartgit-linux-21_2_2.tar.gz`<br>
     Replace filename with the one you downloaded.<br>
     This will extract `smartgit` folder from the archive.
   * `sudo apt update`<br>
     A preparation for `sudo apt install` steps.
   * `sudo apt install libgtk-3-0`<br>
     SmartGit is a GTK based program. GTK is installed in most GUI based Linux, but not on WSL. Without GTK installed, SmartGit will fail to start with error like
	 ```
	 java.lang.reflect.InvocationTargetException
	     at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	     at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	     at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	     at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	     at com.syntevo.QBootLoader.main(SourceFile:115)
	 Caused by: java.lang.UnsatisfiedLinkError: Could not load SWT library. Reasons:
	     Can't load library: /home/user/.smartgit/21.2/swt.tmp/libswt-pi4-gtk-4946r10.so
	     Can't load library: /home/user/.smartgit/21.2/swt.tmp/libswt-pi4-gtk.so
	     Can't load library: /home/user/.smartgit/21.2/swt.tmp/libswt-pi4.so
	     no swt-pi4-gtk-4946r10 in java.library.path: [/usr/java/packages/lib, /usr/lib64, /lib64, /lib, /usr/lib]
	     no swt-pi4-gtk in java.library.path: [/usr/java/packages/lib, /usr/lib64, /lib64, /lib, /usr/lib]
	     no swt-pi4 in java.library.path: [/usr/java/packages/lib, /usr/lib64, /lib64, /lib, /usr/lib]

	     at org.eclipse.swt.internal.Library.loadLibrary(Library.java:348)
	     at org.eclipse.swt.internal.Library.loadLibrary(Library.java:257)
	     at org.eclipse.swt.internal.gtk.OS.<clinit>(OS.java:96)
	     at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:209)
	     at org.eclipse.swt.internal.Converter.wcsToMbcs(Converter.java:155)
	     at org.eclipse.swt.widgets.Display.<clinit>(Display.java:165)
	     at smartgit.IV.a(SourceFile:63)
	     at smartgit.abZ.a(SourceFile:161)
	     at com.syntevo.smartgit.p.a(SourceFile:384)
	     at com.syntevo.smartgit.p.a(SourceFile:283)
	     at smartgit.acE.b(SourceFile:68)
	     at com.syntevo.smartgit.SmartGit.main(SourceFile:11)
	     ... 5 more
	 ```
   At this point you should be able to run SmartGit from command line and you may skip to step 3.
   To create a link to SmartGit in your Windows Start menu, proceed with following steps:
  
   * `sudo apt install xdg-utils`<br>
     A package necessary for next step. Installed by default on most Linux distros. For some reason, not present by default on WSL.
   * `sudo mkdir /usr/share/desktop-directories`<br>
     A workaround for Linux bug, see [https://askubuntu.com/questions/405800](https://askubuntu.com/questions/405800).
	 Without it, you might have error `No writable system menu directory found` in next step.
   * `sudo ./smartgit/bin/add-menuitem.sh`<br>
     This will let Windows know about SmartGit. Right after running this command, your Windows Start menu will get new entry `SmartGit (Ubuntu)`.
     Note that you need to run it with `sudo`, because Windows only picks up info from system `/usr/share/applications` and ignores user `~/.local/share/applications`.
3. Run and set up SmartGit
   * Run `SmartGit (Ubuntu)` in Windows Start menu or directly from WSL command line using `smartgit/bin/smartgit.sh`.
     #### Note
     >If you are not able to finish the Setup due to a missing `machine-id` file and `sudo apt update` does not resolve your problem,
     >you can create the file from command line:
     >```
     >sudo systemd-machine-id-setup
     >```
   * When asked for license, know that you can pick your Windows license from inside WSLg. To do that, navigate to
     `/mnt/c/Users/win-user/AppData/Roaming/syntevo/SmartGit/22.1/license`<br>
     (here, `win-user` is your Windows username, and `22.1` with your SmartGit version. Just use directory browser button)
   * From this point, you can use SmartGit as usual.

# <a name="workarounds"></a> Workarounds for WSLg issues in SmartGit

### For SmartGit 23.1 and older:

1. **On some machines, SmartGit could fail to check for updates**<br>
   Only happens on some machines. Disabling Windows Firewall seems to help. 
   More information is needed.
1. **SmartGit UI uses too small font with 150% Windows zoom level<br>**
   You can workaround this problem by removing the leading `#` from the next line from `smartgit.sh`:
   ```
   #export GDK_DPI_SCALE=1.5
   ```

1. **SmartGit doesn't show "resize" cursor when trying to resize panes**<br>
   This is because in WSL, cursors are not installed by default. Fix it with:
   ```
   sudo apt install adwaita-icon-theme-full
   ```

### For SmartGit 22.1 and older:

1. **SmartGit fails to install updates**<br>
   The workaround is to run SmartGit from terminal, not from Windows shortcut.
   After updates are installed, you can use shortcut again.
1. **SmartGit windows do not have minimize/maximize buttons**<br>
   This is due to how WSLg is configured by default.
   Run these commandline commands to fix for all apps:
   ```
   sudo systemd-machine-id-setup
   gsettings set org.gnome.desktop.wm.preferences button-layout "menu:minimize,maximize,close"
   ```
1. **SmartGit UI layout is wrong with >= 200% Windows zoom level<br>**
   This problem is resolved in SmartGit 23.1 [preview](https://www.syntevo.com/smartgit/preview/)<br>
   In older versions, you can work around it by adding this line in `~/.config/smartgit/smartgit.vmoptions`:
   ```
   -Dswt.autoScale=100
   ```
   Windows zoom level is configured at `Windows > Settings > System > Display > Scale`.
1. **Fractional scaling might cause crashes on startup**<br>
   In the `smartgit.sh` you will find these lines:
   ```
   if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      # comment the next line if you have problems with incorrectly zoomed drawing (see https://bugs.eclipse.org/bugs/show_bug.cgi?id=574182)
      export GDK_BACKEND=x11
   fi
   ```
   Try changing the first line to
   ```
   if [ "$XDG_SESSION_TYPE" = "" ]; then
   ```

### Other problems
If you noticed anything else, please send us a mail to `smartgit@syntevo.com`.

# Other WSLg issues

### VirtualBox

Installing WSLg also installs `Windows Hyper-V`, which is required for `WSLg` to run.
Unfortunately, having `Hyper-V` installed might cause `VirtualBox` VMs to fail in various ways: they might crash, hang, etc.

The workaround is to create an additional Windows boot configuration.
This way, you can select either `Hyper-V` or no `Hyper-V` on every boot.
Run these commands on Windows administrator commandline:
```
bcdedit /copy {current} /d "Win11 + Hyper-V"
bcdedit /set {current} hypervisorlaunchtype off
```

See also: [https://forums.virtualbox.org/viewtopic.php?t=90853](https://forums.virtualbox.org/viewtopic.php?t=90853)

### No internet / network after installing WSL

This seems to be happening on some machines, but not the others. For me, the following fixed the problem:

1. Press Win+R and run `ncpa.cpl`. This will show your network adapters.
2. Right-click adapter you're using for internet and select `Diagnose`.
3. Agree to reset adapter and reboot when suggested.

### Performance problems when running remote SmartGit from within WSLg

We have been reported significant UI performance problems when running SmartGit remotely from within WSLg by following setup:

1. In a bash prompt in WSLg (i.e. graphics enabled), `ssh -Y` to a remote computer
2. Start SmartGit

This can be worked around by following setup:

1. Disable graphics in `.wslconf`
2. Install **Xlaunch**, following [these instructions](https://cs233.github.io/oyom_wsl2_setup.html)
3. `ssh -Y` to remote computer
4. Start SmartGit

## Known problems when accessing hosted-mounted repositories

Accessing host-mounted repositories, i.e., accessing repositories from within WSL that are stored on the host and accessed by `/mnt/...` is strongly discouraged because it is known to cause several problems:

1. Various Git configuration options from the host may result in confusing behavior in WSL (or vice versa).
2. File monitoring does not work.
3. The refresh performance is usually degraded.
   * This is mainly due to optimizations during `.git/index` processing, for instance, different timestamp precision on different systems.

Note that many of the issues mentioned above affect any Git client and can be reproduced using `git status`.

### Suggested solutions

Maintain a dedicated clone of your repository in WSL's native filesystem. You can add the host-mounted repository as a remote, allowing you to conveniently synchronize commits between both environments.
