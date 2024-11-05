# Debugging Refresh-related problems

If you are encountering problems with SmartSVN's refreshing not picking
up external changes, do the following:

-   While SmartSVN is running, locate the settings directory: invoke
    **Help\|About SmartSVN** and check the **Information** page for the
    settings directory (**Settings Path**).
-   Shutdown SmartSVN (use **Project\|Exit** and afterwards make sure
    that no more SmartSVN process is running).
-   In the settings directory, open `smartsvn.properties` (create this
    file if necessary) and add following line to enable the **Debug**
    menu:



``` java
smartsvn.debug=true
```



-   Remove the `logs` directory inside the settings directory.
-   Startup SmartSVN.
-   Open the working copy for which the Refresh-problem is reproducible
    and wait until SmartSVN has completed the initial scan.
-   Trigger the external change.
-   Switch back to SmartSVN, wait until (a possibly) started refresh has
    definitely finished and make sure the changes actually have not been
    picked up.
-   Invoke **Debug\|Log File Monitor Events**.
-   Shutdown SmartSVN again.
-   Compress the `logs` directory from the settings directory as a *zip*
    or *tar/gzip* archive and send this archive, as well as a short
    description of how to reproduce the problem, to
    <support@smartsvn.com>.
