# Changing the Folder Watch Limit (Linux)

SmartSVN's file monitor watches the folders of your SVN repositories for
file changes, and updates all affected views automatically so you don't
have to refresh them by hand. On Linux, the file monitor requires Java 7
or later, and the number of folders that can be watched simultaneously
is limited by a system-wide variable.

This means if you open an SVN repository in SmartSVN, and this
repository contains more subfolders than is allowed by the system-wide
limit, the file monitor may stop working. If that happens, you'll need
to raise the watch limit. This can be done as follows: For example, to
raise the watch limit to 100K watches, log in as root (described below)
and insert the following line into the file `/etc/sysctl.conf`:



``` text
      fs.inotify.max_user_watches = 102400
    
```



For this change to take effect, either reboot the system or execute the
command `/sbin/sysctl -p`.


#### Tip
>
>
>To understand implications of increasing the limit, have a look at
><http://askubuntu.com/questions/154255>.
>
>

In order to obtain root privileges, enter `su`, followed by the root
password. On some systems, you may have to "unlock" the root account the
first time. To do so, enter `sudo su` instead.
