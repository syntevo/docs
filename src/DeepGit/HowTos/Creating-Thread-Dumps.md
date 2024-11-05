# Creating Thread Dumps

By creating thread dumps, you can help us fix program lock-ups (UI
freezes, never-ending operations, etc.) and performance problems, among
other things. How a thread dump is created depends on your operating
system. In the following, we'll assume DeepGit has been installed in the
directory `install-dir`.

#### Windows

-   Shut down DeepGit if it's still running. Also check that it isn't
    hidden in the system tray, and make sure no more DeepGit processes
    are running, by terminating any `deepgit.exe` (and `deepgitc.exe`)
    processes in the *Windows Task Manager*.
-   Open a command prompt and navigate to the directory
    `<install-dir>\bin`.
-   Execute `bin\deepgitc.exe > dump.txt`. This will start DeepGit and
    keep the command prompt attached to the program.
-   Perform the necessary actions to reach the program state for which
    you want to create a thread dump.
-   In the command prompt, press *\<Ctrl>+\<Break>*-keystroke to create
    a thread dump. Then wait a few seconds to create another dump and
    repeat this step at least five times in order to get a reasonable
    number of dumps. Check that the thread dumps were actually written
    to `dump.txt`.
-   Follow the instructions at the bottom of this section to send the
    thread dumps to our customer support.

#### Mac OS X

-   If DeepGit is already running, quit it.
-   Open a terminal window and launch DeepGit redirecting the output to
    a file:
    `<install-dir>/DeepGit.app/Contents/MacOS/DeepGit > ~/dump.txt`
-   Perform the necessary actions to reach the program state for which
    you want to create a thread dump.
-   Open a second terminal window and execute `ps -A | grep DeepGit` to
    find the process ID (PID) of the running DeepGit instance.
-   Execute `kill -3 PID` where *PID* is the process ID you obtained in
    the previous step. This will append a thread dump to `~/dump.txt`.
    Then wait a few seconds and repeat this step at least 5 times in
    order to get a reasonable number of dumps.
-   Check that the thread dumps were indeed written to the `dump.txt`
    files.
-   Follow the instructions at the bottom of this section to send the
    thread dumps to our customer support.

#### Linux and other Unix-like operating systems

-   Open a terminal window.
-   Shut down DeepGit if it's still running. Also make sure it's not
    hidden in the system tray and that no more DeepGit processes are
    running. The latter can be checked as follows: DeepGit runs as a
    `java` process, and you can enter `ps -A | grep java` in the
    terminal to find all running `java` processes. If you have other
    Java applications running, you may execute `ps -Af | grep java` to
    find out the process IDs (PID) of the DeepGit processes. Terminate
    all of these processes, if there are any.
-   Execute `<install-dir>/bin/deepgit.sh > dump.txt`.
-   Perform the necessary actions to reach the program state for which
    you want to create a thread dump.
-   Open another terminal window.
-   Execute `ps -a | grep java` to find out the process ID of DeepGit's
    `java` process. If there's more than one, you'll have to try them
    all.
-   Send the KILL signal to DeepGit by executing `kill -3 PID` in the
    second terminal window, where *PID* is the process ID you obtained
    in the previous step. Wait a few seconds and create a another dump.
    Repeat this step at least 5 times. After you're done, make sure the
    file `dump.txt` has actually been filled.
-   Send the thread dumps to our customer support, as explained below.

*How to send the dump.txt file*: Compress the `dump.txt` file as a *zip*
or *tar/gzip* archive, and also include the file `log.txt` from
DeepGit's settings directory. Send this archive, as well as a short
description of how to reproduce the problem, to
[deepgit@syntevo.com](mailto:smartgit@syntevo.com).
