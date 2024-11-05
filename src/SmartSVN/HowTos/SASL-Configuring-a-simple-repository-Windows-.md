# SASL: Configuring a simple repository (Windows)

# What is SASL?

SASL is an authentication framework designed to support various
authentication plugins.

Without SASL, SVN only supports very basic user/password authentication
for its repositories.

# Note on SmartSVN versions

SASL is only supported since SmartSVN 11.

# Note on using two computers

For this guide, it's recommended to use two computers - this way, it
will be closer to real life scenario.

If you use just one computer, it will still work, but it's not as good
in verifying that everything is set up correctly.

# Note on hardcoded names

This guide uses the following names/paths that could be changed to your
liking. But if you change them, please remember to change them accordingly in
all steps.

-   `SERVER`  
    Name of computer where SVN repository will be hosted.
-   `CLIENT`  
    Name of computer where you will use SmartSVN to access the
    repository.
-   `C:\TestSASL\subversion`  
    Folder where you keep SVN binaries.
-   `TestRepository`  
    Folder of your test repository.
-   `C:\TestSASL\SvnRoot\TestRepository`  
    Full path of your test repository.
-   `C:\TestSASL\SASL_Config`  
    Folder to keep SASL configuration files.
-   `TestRealm`  
    Authentication realm for your repository.  
    SVN repositories assigned to the same realm will share users and passwords.
-   `john.smith`  
    Name of the SVN user that will access repository.  
    It doesn't have to match Windows username.

# Configure and test non-SASL repository

#### On `SERVER` computer

1.  Download and extract SVN binaries
    1.  Download them
        -   Visit <https://www.smartsvn.com/download/>
        -   You will find 'Download SVN Binaries' at the bottom of this
            page
    2.  Extract to `C:\TestSASL\subversion`

2.  Create a new SVN repository
    -   Run console commands:  
        `mkdir "C:\TestSASL\SvnRoot"`  
        `"C:\TestSASL\subversion\svnadmin.exe" create "C:\TestSASL\SvnRoot\TestRepository"`

    -   When successful, there will be no output from this command.

3.  Start an SVN server

    -   It's supposed that you don't yet have an SVN server running.

    -   Note that this console command will keep running, so you might
        want to open a dedicated console window for it.

    -   Run console command:  
        `"C:\TestSASL\subversion\svnserve.exe" -d -r "C:\TestSASL\SvnRoot"`

    -   Make sure that `svnserve.exe` is allowed through your firewall
        (for Windows Firewall, a prompt will appear after starting it).
    -   When successful, there will be no output from this command.
    -   Do not close console window (doing so will stop SVN server).

#### On `CLIENT` computer

1.  Start SmartSVN.

2.  Select `Project | Check Out...`

3.  Use this repository URL  
    `svn://SERVER/TestRepository`

4.  Complete the other wizard steps as usual.

5.  If you receive error 'Unable to connect to a repository at URL'

    -   You're having some basic connection problem, and this is beyond
        the scope of this guide.

    -   You might want to check that
        -   `svnserve.exe` is still running on `SERVER`
        -   `svnserve.exe` is allowed through firewall
        -   `CLIENT` can ping `SERVER`

# Prepare SASL

Steps in these section are performed on computer `SERVER`.

#### Verify that SASL is not configured yet

-   It's possible that you have leftover SASL installed along with other SVN client  
    This could cause unexpected failures when you try to run
    `svnserve.exe` with SASL later.
-   Run console command:  
    `"C:\TestSASL\subversion\pluginviewer.exe"`
-   It should only have 'EXTERNAL' in all lists  
    This means SASL doesn't see its plugins yet, even though they're
    located in the same folder.

#### Configure SASL registry keys

1.  Create the registry key if it doesn't exist  
    -   For 32-bit:  
        `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Carnegie Mellon\Project Cyrus\SASL Library`
    -   For 64-bit:  
        `HKEY_LOCAL_MACHINE\SOFTWARE\Carnegie Mellon\Project Cyrus\SASL Library`
2.  Create `String` values:
    -   `SearchPath` with value `C:\TestSASL\subversion`  
        This is the folder where SASL will look for its plugins.
        For SmartSVN's SVN package, SASL plugins are located in the same
        folder as SVN itself.
    -   `ConfFile` with value `C:\TestSASL\SASL_Config`  
        This is the folder where SASL will look for its configuration file.  
        Note that this is a folder path and not the path to 'svn.conf'
        file that you will create in next step.

#### Create SASL configuration file

1.  Create text file `C:\TestSASL\SASL_Config\svn.conf` with the
    following contents:
    ```
    pwcheck_method: auxprop
    auxprop_plugin: sasldb
    mech_list: DIGEST-MD5
    sasldb_path: C:\TestSASL\SASL_Config\sasldb
    ```

    `DIGEST-MD5` is the authentication plugin to be used. There are
    other plugins available, but they are beyond the scope of this
    guide.  
    `C:\TestSASL\SASL_Config\sasldb` is the location of user/password
    database (database itself is created in the next step).

#### Create user/password database

1.  Run console command:   
    `"C:\TestSASL\subversion\saslpasswd2.exe" -c -f "C:\TestSASL\SASL_Config\sasldb" -u TestRealm john.smith`  
    This will create user `john.smith`  
    This will also create the database if it doesn't exist.  
    `TestRealm` is the name of the authentication realm.

# Configure your SVN repository to use SASL

Steps in these section are performed on computer `SERVER.`

You will need to edit repository configuration file:  
`C:\TestSASL\SvnRoot\TestRepository\conf\svnserve.conf`

For a newly created repository this file will already contain some
settings, but these settings will be commented with `#`. Remember to uncomment values as you edit them.

Steps:
1.  Enable SASL:
    ```
    [sasl]
    use-sasl = true
    ```
    This will enable SASL authentication and also disabled SVN's builtin
    authentication.

2.  Configure realm
    ```
    [general]
    realm = TestRealm
    ```
    SASL needs a realm assigned to repository to be able to match it
    with user/password database.

3.  Disable anonymous read access
    ```
    [general]
    anon-access = none
    ```
    This disables anonymous read access.  
    This step is not necessary, but convenient for testing.  
    If you skip this, remember that you need to perform a writing
    operation (such as Commit) to verify that SASL works

4.  Restart `svnserve.exe`  
    Close `svnserve.exe` console you have running from the previous
    steps.  
    Start it again with the same command.  
    Without restart, `svnserve.exe` will not find SASL plugins, because
    it only searches for them once.

# Test SASL

Steps in these section are performed on computer `CLIENT`.

1.  Start SmartSVN if you don't have it running.
2.  Press 'Update' on SmartSVN's toolbar.
3.  You will be prompted to enter username/password.
4.  Enter credentials you used with `saslpasswd2.exe` in one of the
    previous steps.
5.  You shall see successful completion of 'Update' in SmartSVN.

# Cleanup

Unfortunately, SASL registry settings are global and affect all programs
on the same computer.  
If you're not planning to continue using SASL on `SERVER`, it's best to
delete registry settings you applied.  
Otherwise, other SASL-based programs may break in unexpected ways due to
incompatible versions of libraries.

# That's it!

If you performed all steps correctly, you should be able to access your
new SASL-based repository.  
