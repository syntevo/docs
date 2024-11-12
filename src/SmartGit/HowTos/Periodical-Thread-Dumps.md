# Periodical Thread Dumps

Logging periodical thread dumps is a built in feature of SmartGit to
track *well reproducible*, *pervasive* performance problems. To
investigate a problem using periodical thread dumps, do the following:

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

Now, if the slow operation is **not locking** the GUI (so you can still
invoke menu items) **and** it takes a long time to finish:

-   -   Trigger the slow operation.
    -   Invoke **Debug\|Create Periodical Thread Dumps** immediately
        after triggering the slow operation (so thread dumps will
        definitely catch the slow operation).

Otherwise:

-   -   Invoke **Debug\|Create Periodical Thread Dumps.**
    -   Trigger the slow operation.

Then:

-   After the offending operation has finished, shutdown SmartGit again.
-   Compress the `log` directory from the settings directory as a *zip*
    or *tar/gzip* archive and send this archive, as well as a short
    description of how to reproduce the problem, to
    <smartgit@syntevo.com>.
