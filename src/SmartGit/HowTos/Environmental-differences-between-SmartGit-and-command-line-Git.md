# Environmental differences between SmartGit and command line Git

If SmartGit behaves differently compared to command line Git, this is
usually caused by differences in environment variables. Environment
variables may affect:

-   `HOME` which may result in a different `.gitconfig` to be used and
    thus affect execution of Git commands in various ways
-   other environment variables which may affect Git hooks

To investigate, first try to invoke the problematic Git command from a
shell which has been forked from SmartGit:

-   from the **Repositories** view context menu of the repository,
    invoke **Open Git-Shell**
-   invoke the command in this shell

Usually the problem which you encounter in SmartGit is reproducible in
this shell, too:

-   if so, this confirms the suspicion that it's related to
    environmental differences and you should continue to compare
    environment variables (see below).
-   if not, first try to reproduce the problem with a clean SmartGit
    installation:
    -   temporarily get rid of the [Settings directory](../Latest/Installation-and-Files.md)
    -   retry the problematic operation  
        -   if the problem is still reproducible, compare environment
            variables (see below)
        -   if not reproducible anymore, start reconfiguring SmartGit
            settings until the problem becomes reproducible

# Compare environment variables:

1.  Startup SmartGit with [a clean log file](Debugging.md)

2.  invoke the problematic Git command

3.  shutdown SmartGit

4.  open `logs/log.txt.0` from the [Settings directory](../Latest/Installation-and-Files.md) and
    locate `Environment variables` in the top of the log file

5.  open a terminal/command prompt directly from your operating system
    and list configured environment variables by invoking:



    ``` java
    set
    ```



6.  compare SmartGit's environment with the terminal environment
