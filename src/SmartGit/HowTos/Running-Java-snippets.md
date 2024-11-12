# Running Java snippets

To debug, we may sometimes send you small Java snippets to run, usually
compressed in a ZIP file. To run these snippets, you need to have a
SmartGit installation on your system which also comes with its own
runtime environment:

1.  Uncompress the ZIP file contents to a temporary directory,
    e.g. `c:\temp\debug`

2.  Open a command line/terminal, `cd` to this directory and invoke:

    **Usage**

    ``` java
    {jre}/bin/java -classpath . {classname} > out.txt 
    ```

    Substitute `{classname}` by the class name we have asked you to run
    and `{jre}` by the path to SmartGit's JRE. Depending on your
    operating system, you will find the JRE at:

    1.  **Windows**: \<smartgit-installation>\\jre
    2.  **Linux**: \<smartgit-installation>/jre
    3.  **MacOS**: \<smartgit.app>/Contents/Resources/jre

    **Example**

    ``` java
    "C:\Program Files\SmartGit\jre\bin\java.exe" -classpath . NioFileSystemWalk "c:\temp\repo" true > out.txt 
    ```

3.  If there is an error printed which is not related to a wrong command
    line usage, also pipe `stderr` to a separate file:

    ``` java
    {jre}/bin/java -classpath . {classname} > out.txt 2> err.txt
    ```

4.  You may investigate both `out.txt` (and `err.txt`) yourself to
    figure out possible problems.

5.  Finally, send us compressed `out.txt` (and `err.txt`) to
    smartgit@syntevo.com.
