# Setting up an SSH tunnel (Windows)

This page explains how to set up an SSH tunnel on Windows using Putty,
for the purpose of routing traffic between SmartGit and your Git
repository through the SSH tunnel.

When you start Putty, a configuration window shows up where you can
configure the connection you're about to open. On the **Session** page,
enter the host name or IP address and the port number of the connection.
For this tutorial let's say we'll connect to `my.private.server`, port
number 22. On the **Session** page, you may save your configuration as a
session.

Next up, enter the required authentication information on the pages
**Connection\|Data** and **Connection\|SSH\|Auth**. For this example,
we'll log in as user `john`, using the private key file
`F:\certificates\my-git-certificate.ppk`.

Now comes the part where we set up the SSH tunnel: On the page
**Connection\|SSH\|Tunnels**, enter the source and destination of the
tunnel. We'll use 2022 as source port and `my.private.server:22` as
destination. Leave the other options as they are, i.e. **Local** and
**Auto**. Click the **Add** button to add the tunnel to the connection
configuration.

Finally, click the **Open** button at the bottom of the Putty
configuration window to open the connection. Now, while the connection
is open, you can access your Git repository from SmartGit through the
SSH tunnel. In our example, we can now clone the Git repository via a
URL like this: `ssh://john@localhost:2022/path/to/gitrepo`
