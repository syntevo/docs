# Finding bugs with Application Verifier

# Introduction

*Application Verifier* is a free tool from Microsoft designed for finding bugs in software.
It's invaluable in searching for memory corruption bugs.
Without Application Verifier, the corruption is usually detected far away from the code containing the bug, and crash report is almost useless.
With Application Verifier, however, the application is forced to crash exactly at the location of the bug.

# How to use it

1.  Install Application Verifier
    1.  Download [Windows SDK](https://go.microsoft.com/fwlink/p/?LinkID=2033908)
    2.  Install it, only selecting *Application Verifier*; other components are not required.
2.  Configure Application Verifier for SmartGit
    1.  Run *Application Verifier (x64)* from Start menu.
    2.  Use *File \| Add application...* to add smartgit.exe
        -   default install path is `C:\Program Files\SmartGit\bin\smartgit.exe`
        -   Application Verifier ignores the path and will apply to every `smartgit.exe`
        -   If you also use `smartgitc.exe` in your scripts, add it as well.
    3.  **IMPORTANT**: On the right pane, make sure that only **Basics/Heaps** is selected.
        Otherwise, SmartGit will not start at all.
    4.  Click *Save*.
        You can exit Application Verifier now, it will be active until you remove the settings.
    5.  Restart SmartGit
3.  Use SmartGit
    1.  If you can remember, at least approximately, what you did when you got the crash, try that scenario and see if it crashes.
    2.  Otherwise, just use SmartGit as usual.
    3.  SmartGit will be slower.
        This is a side effect of Application Verifier.
4.  If SmartGit crashes, then you found something
    1.  Restart SmartGit and allow it to send the crash report.
    2.  If you prefer to send the crash report manually:
        -   go to this folder: `%APPDATA%\syntevo\SmartGit\<major-version>`
        -   collect recent files with names starting with `hs_err`
5.  If SmartGit doesn't start at all:
    1.  Make sure that you only have *Basics/Heaps* selected in Application Verifier, see step 2.iii.
    2.  If Application Verifier settings are correct, then disable Application Verifier (this will allow SmartGit to start again) and report bug.
6.  Disable Application Verifier:
    1.  If you're willing to tolerate the slowness to help us find bugs, this is most welcome!
        In this case, don't disable Application Verifier.
    2.  Run *Application Verifier (x64)* from Start menu.
    3.  Remove smartgit.exe from the list.
    4.  Click *Save*.
