# Debugging smartgit.exe startup (Exe4J)

On Windows, if SmartGit is not properly starting up and/or even exits
before a log file will be written, it can be helpful to debug the
`smartgit.exe` launcher:

1.  open a Windows command line terminal

2.  `cd` to SmartGit's installation directory, sub-directory `bin`

3.  invoke



    ``` java
    set EXE4J_LOG=yes
    ```



4.  start `smartgitc.exe` (notice the trailing 'c'!)

5.  in your `%TEMP` directory, locate a file called `i4j_nlog_2`

6.  either inspect this file yourself or send it to us (if request so)
