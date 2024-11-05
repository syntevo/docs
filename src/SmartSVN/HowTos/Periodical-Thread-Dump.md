# Periodical Thread Dump

Logging periodical thread dumps is a built in feature of SmartSVN to
track *well reproducible*, *pervasive* performance problems. To
investigate a problem using periodical thread dumps, do the following:

-   While SmartSVN is running, locate the settings directory: invoke
    **Help\|About SmartSVN** and check the **Information** page for the
    settings directory (**Settings Path**).
-   Shutdown SmartSVN (use **Project\|Exit** and afterwards make sure
    that no more SmartSVN process is running).
-   In the settings directory, open `smartsvn.properties` (create this
    file if necessary) and add following line to enable the **Debug**
    menu:



``` java
smartsvn.debug=true
```



-   Remove all `log.txt.*` files from the settings directory.
-   Startup SmartSVN.

Now, if the slow operation is **not locking** the GUI (so you can still
invoke menu items):

-   -   Trigger the slow operation.
    -   Invoke **Debug\|Create Periodical Thread Dumps.**

Otherwise, if the slow operation is blocking the GUI, perform these
steps in the reverse order:

-   -   Invoke **Debug\|Create Periodical Thread Dumps.**
    -   Trigger the slow operation.

Then:

-   After at least 10 seconds, shutdown SmartSVN again.
-   Compress all `log.txt.*` files from the settings directory as a
    *zip* or *tar/gzip* archive and send this archive, as well as a
    short description of how to reproduce the problem, to
    <support@smartsvn.com>.
