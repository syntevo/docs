# Changing the Folder Watch Limit (Linux)

SmartGit's file monitor watches the folders of your Git repositories for
file changes, and updates all affected views automatically so you don't
have to refresh them by hand. On Linux, the number of folders that can
be watched simultaneously is limited by a system-wide variable.

This means if you open a Git repository in SmartGit, and this repository
contains more subfolders than is allowed by the system-wide limit, the
file monitor may stop working. If that happens, you'll need to raise the
watch limit. This can be done as follows: For example, to raise the
watch limit to 100K watches, log in as root (described below) and insert
the following line into the file `/etc/sysctl.conf`:



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

## Reducing the number of inotify watches used by SmartGit

Sometimes it's not possible to increase `fs.inotify.max_user_watches`.
In this case, you may try to reduce the number of watches required by
SmartGit:

-   SmartGit will always monitor the currently open repositories; this
    holds true for the main window as well as for the Log. There is no
    way to reduce handles here except of reducing the repository size,
    e.g. by ignoring large untracked subtrees of your repository
-   If you have selected **Detect local changes in closed 'favorite'
    repositories** (Preferences, section **Background Commands**), all
    your favorite repositories will be monitored. Deselecting this
    option usually helps to significantly reduce required watches.

 
