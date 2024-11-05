# Creating Heap Histograms

If there is a suspected memory leak in SmartGit, in a first step a heap histogram may be helpful for further diagnosing. How a heap histogram is created depends on your operating
system.

#### Windows

In the following, we'll assume the presence of temporary directory `C:\temp`.

-   If you do not already have a recent JDK installed, get the Open JDK for Windows from:

    https://adoptium.net/releases.html?variant=openjdk11

    The ZIP bundle is sufficient; it requires no installation and can simply be moved to trash after the investigation.
    Unpack the bundle to `C:\temp`. Usually the bundle contains a single root directory named like `jdk-...`.
    In the following this unpacked directory is referred to as `jdk-dir`.

-   Determine SmartGit's process ID from the *Details* page of the *Windows Task Manager*.
-   Open a command prompt and execute:
   
    ```
    <jdk-dir>\bin\jmap -histo <pid> > c:\temp\histo.all
    ```
    
    and
    
    ```
    <jdk-dir>\bin\jmap -histo:live <pid> > c:\temp\histo.live
    ```

    `<jdk-dir>` needs to be replaced by the JDK root directory; `<pid>` needs to be replaced by SmartGit's process ID.

-   Follow the instructions at the bottom of this section to send the heap histogram to our customer support.

#### Send us heap histograms

Compress the `histo.all` and `histo.live` files as a *zip* or *tar/gzip* archive, and also include the zipped `log` directory from SmartGit's settings directory.
Send this archive, as well as a short description of how to reproduce the problem, to <smartgit@syntevo.com>.
