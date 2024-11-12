# Debugging Refresh-related problems (of external changes)

If you are encountering problems with SmartGit's refreshing not picking
up external changes, do the following:

-   While SmartGit is running, locate the settings directory: invoke
    **Help\|About SmartGit** and check the **Information** page for the
    settings directory (**Settings Path**).
-   Shutdown SmartGit (use **Repository\|Exit** and afterwards make sure
    that no more SmartGit process is running).
-   In the settings directory, open `smartgit.properties` (create this
    file if necessary) and add following line to enable the **Debug**
    menu:



``` java
smartgit.debug=true
```



-   Remove the `logs` directory inside the settings directory.
-   Startup SmartGit.
-   Open the repository for which the Refresh-problem is reproducible
    and wait until SmartGit has completed the initial scan.
-   Trigger the external change.
-   Switch back to SmartGit, wait until (a possibly) started refresh has
    definitely finished and make sure the changes actually have not been
    picked up.
-   Invoke **Debug\|Log File Monitor Events**.
-   Shutdown SmartGit again.
-   Compress the `logs` directory from the settings directory as a *zip*
    or *tar/gzip* archive and send this archive, as well as a short
    description of how to reproduce the problem, to
    <smartgit@syntevo.com>.
