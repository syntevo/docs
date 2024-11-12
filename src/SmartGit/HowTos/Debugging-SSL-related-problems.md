# Debugging SSL-related problems

Various built-in SmartGit functionality will connect to *https* URLs, for example:

- **Check for New Version**
- various integrations, like Hosting Providers

When experiencing problems here, it can be helpful to debug Java's networking layer.
To do that, add the `javax.net.debug` property to the [smartgit.properties](../Latest/System-Properties.md) file.
The property value depends on the type of logging you are looking for:

* `javax.net.debug=ssl:trustmanager` to debug problems with server certificates
* `javax.net.debug=ssl:handshake` to debug problems with the SSL handshake
* `javax.net.debug=ssl:trustmanager,ssl:handshake` to combine logging for both aspects

After that, restart SmartGit from the command line and pipe the output to a file:

- On Windows: execute `<install-dir>\bin\smartgitc.exe > dump.txt 2>&1`
- On MacOS: execute `<install-dir>/Contents/MacOS/SmartGit > dump.txt 2>&1`
- On Linux: execute `<install-dir>/bin/smartgit.sh > dump.txt 2>&1`

Finally, verify that `dump.txt` contains SSL-related output.

*How to send the dump.txt file*:
Compress the `dump.txt` file as a *zip* or *tar/gzip* archive, and also include the zipped `log` directory from SmartGit's settings directory.
Send this archive, as well as a short description of how to reproduce the problem, to <smartgit@syntevo.com>.
