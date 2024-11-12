# On-premise update-server

For a large number of installations, it may be convenient to replicate
our way of deployment in your company.

Advantages of this approach:

-   light-weight updates are managed by SmartGit itself:
    -   they usually don't require admin privileges
    -   they won't disturb the user
-   less effort in deploying new versions, once the infrastructure is
    set up

Disadvantages of this approach:

-   initial effort required to set up the infrastructure
-   some updates (usually the first build of a major version) requires
    admin privileges for SmartGit's updater to run
-   very seldom, there may be updates (usually of a major version) which
    can't be even run by SmartGit's updater. In this case, a fresh
    installation will be necessary. SmartGit provides notification
    mechanisms to inform your users about such updates (the same way as
    we would do with our users).

# Central updates repository

To provide the updates to your users, a central "repository" has to be
set up (the term "repository" is completely unrelated to a Git
repository). The repository must be accessible either over HTTP- or
file-protocol and must provide endpoints for:

-   an "autoupdate" file
-   several control files and all files which make up the installation
-   a human-readable HTML information page

From now on, let's assume that the custom update server's URL is
`http://updateserver/smartgit` (`updateserver` may contain a port, too)
and it offers following endpoints:

-   `http://updateserver/smartgit/autoupdate` and
-   `http://updateserver/smartgit/updates`
-   `http://updateserver/smartgit/info`


#### Info
> If you want to use `file://`-protocol instead of `http://`-protocol, for
> example, the URL for local file `d:\update-server\autoupdate` would be
> `file://localhost/d:/update-server/autoupdate`. The URL for a network
> share file `\\update-server\autoupdate` would
> be `file://update-server/autoupdate`.



## Autoupdate file

The `autoupdate` file is the entry-point for the entire update
procedure. It will be read by SmartGit on every invocation of the check
for new version. For a reference `autoupdate` file, refer to our main
`autoupdate`-file at <http://www.syntevo.com/smartgit/autoupdate>.

The `autoupdate` file contains directions for each major version of
SmartGit and its top-level structure looks like:



``` java
<updateinfo>
    <product id="syntevo.smartgit.release-X">
        ...
    </product>
    <product id="syntevo.smartgit.release-Y">
        ...
    </product>
    ...
<updateinfo> 
```



A `<product>`-element will usually contain a `<version>`-element which
gives details on the update target version and has basically following
structure:



``` java
<version>
    <major-version>...</major-version>
    <major-date>...</major-date>
    <build>...</build>
    <name>...</name>
    <date>...</date>
    <location>...</location>
    <update-url>...</update-url>
     ...
</version>
```



You will usually want to copy these elements over from our
main `autoupdate`-file and only adjust the `<location>`-element and the
`<update-url>`-element to your company-internal URLs. An example
`<version>`-element for SmartGit 17.1.2 **with adjusted paths** might
look like:



#### Example


> ``` java
> <version>  
>     <major-version>17.1</major-version>  
>     <major-date>2017-10-12</major-date>  
>     <build>11190</build>  
>     <name>17.1.2</name>  
>     <date>2017-11-14</date>  
>     <location>http://updateserver/smartgit/info</location>         
>     <update-url>http://updateserver/smartgit/updates/control-11190</update-url>  
>     <update-delay>3600</update-delay>  
>     <update-density>100</update-density>  
>     <update-density-max>100</update-density-max>  
> </version>
> ```


The important URL is `<update-url>` which specifies the URL-**prefix** for the update "control"-files.
The `<location>`-URL is of minor importance and will just be displayed by SmartGit if an automatic upgrade is not possible (which should almost never be the case).

Depending on the operating system, the URL-prefix will be completed to a full URL by appending:

-   `-win` for Windows
-   `-gen` for Linux
-   `-macos-aarch64` or `-macos-x86_64` for MacOS


#### Example
>The complete URL for the Windows update control file will look like:
>
>    http://updateserver/smartgit/updates/control-11190-win
>
>

## Control file

The "control" file specifies how the final SmartGit installation must
look like after an update. The basic structure of a control file looks
like:



``` java
HEADER
build=...
minRequiredBuild=...
sourceRootUrl=...
...
CONTENT
...
<signature>
```



You will usually want to copy the control files from our website as is
and only adjust the `sourceRoolUrl` to your company-internal URL. An
example Windows update control file for SmartGit 17.1.2 **with adjusted
URL** might look like:



#### Example
>
>
>
>`HEADERbuild=11190minRequiredBuild=11170versionName=17.1.2majorName=17.1majorDate=2017-10-12executable32bit=bin/smartgit.exeexecutable64bit=bin/smartgit64.exe         sourceRootUrl=http://updateserver/smartgit/updates         copyPatterns=bin/*.vmoptions,.settings/*,.updates/*,unins???.dat,unins???.exeskipPatterns=lib/hgext/*.pycCONTENTe6971f3e69c064e0468f13ae02a332b913f8e659    f    changelog.txt    changelog.txt...`
>
>

The `CONTENT` section describes exactly how the installation should look
like and consists one line for very file which will be present in the
installation:



``` java
<sha> <type> <name-on-server> <relative-path-in-installation>
```



URLs for all files mentioned in the `CONTENT` section will be composed
by concatenating the `sourceUrl + / + <name-on-server> + . + <sha>.`



#### Example
>
>
>
>The complete URL for `changelog.txt` from the above example will be:
>
>http://updateserver/smartgit/updates/changelog.txt.e6971f3e69c064e0468f13ae02a332b913f8e659
>
>The file can be obtained from:
>
>`http://www.syntevo.com/updates/smartgit/changelog.txt.e6971f3e69c064e0468f13ae02a332b913f8e659`
>
>

### Details on control file HEADER fields

-   `build` specifies the SmartGit build number. It must match
    the `autoupdate`'s `<build>`-element and the hard-coded build number
    in the SmartGit binaries. Hence, do **never change** this field.
-   `minRequiredBuild` specifies the minimum build number which the
    local installation must be of for a *light-weight* update (see
    [Installation and Files](Installation-and-Files.md)). If the local
    build number is lower, an *installation update* will occur. Usually
    you will simply copy over `control` files as we have published them
    and only adjust the `sourceRootUrl`. In case you want to change the
    installation directory (see below) as part of the update, you have
    to set `minRequiredBuild` to the same value as `build`.
-   `versionName` and `majorVersionName` will only be used in the UI and
    should not be changed.
-   `majorDate` will be used to decide whether an upgrade to a new major
    version is supported by the license and should not be changed.
-   `executable32bit` and `executable64bit` specifies the binaries which
    will be launched after an *installation update*. Usually they should
    not be changed.
-   `sourceRootUrl` has been discussed already and must **always be
    adjusted**.
-   `copyPatterns` will be applied to all files in the old installation
    which were not known to be part of the old installation ("unknown
    files"), i.e. such files are not listed in the `control`-file of the
    old installation. Those unknown files which are matched by the
    pattern will be copied over to the new installation. For
    example, `bin/smartgit.vmoptions` is not part of the installation
    and hence will be copied over from old to new installation.
-   `skipPatterns` will also be applied to unknown files and directs
    SmartGit to ignore them when cleaning up the old installation. With
    regards to the cleanup, an unknown file may have been copied to the
    new installation, may have been skipped or may have not been handled
    in which case it will remain in the old installation. If the old
    installation is not empty after the cleanup, the SmartGit updater
    will warn about this fact and an `-archive` directory with the
    unhandled files will remain on disk.

## Populating the updates "repository"

`autoupdate` and `control`-files can easily be fetched from our website.
To fetch all files listed in the `control` file, you have two options:

-   write a script which will fetch all these files from our website and
    put it onto your update server
-   have a temporary SmartGit installation, let it fetch all necessary
    files using `Help|Check for New Version` and copy files over from
    SmartGit's local update "repository" (see [Installation and Files](Installation-and-Files.md)) to your update server.

# Required and helpful SmartGit system properties


#### Note
> The following system properties should be added to
> `bin/smartgit.vmoptions`, so they will be part of the installation and
> automatically present for every user.



#### smartgit.updateCheckUrl (required)

The URL of the `autoupdate` file which SmartGit will access can be
configured by system property `smartgit.updateCheckUrl`.



#### Example
>
>
>
>`-Dsmartgit.updateCheckUrl=http://updateserver/smartgit/autoupdate       `
>
>

#### smartgit.autoupdate.checkSignature (required)

Every `control` file ends with a `<signature>` which secures this file
against tampering. By default, SmartGit will reject `control` files for
which the signature does not match. To make SmartGit accept
such `control` files, you have to set system
property `smartgit.autoupdate.checkSignature=false.` **Be careful!** By
switching off this important check, everyone who gains control over the
update server can deploy arbitrarily modified and possibly harmful
SmartGit binaries.

#### smartgit.updateCheck.force smartgit.updateCheck.intervalSecs (optional)

By default, the update check will be performed on every SmartGit startup
(if at least 23 hours have passed since the last check) and from then on
all 23 hours. You may optionally shorten this interval by adding system
property `smartgit.updateCheck.force=true` and specifying the desired
interval in seconds using `smartgit.updateCheck.intervalSecs`.

# Customizing the installation

When replicating the `control`-files as they are and only adjusting
the `sourceRootUrl`, SmartGit updates from your company server will look
exactly the same as when done from our main server. But as we have seen
above, to use a custom update-server, `smartgit.vmoptions` has to be
adjusted and these changes must be preserved after an update. By
default, SmartGit will copy "unknown" files from the old installation
over to the new installation, so the file will be preserved
automatically. However, it's better to not rely on this mechanism and
instead make these system properties part of your custom installation.
This way you will be able to add additional system properties on demand.
In a similar way you may add, replace or remove additional files on
demand, like the `default/license` file.



#### Example
>
>
>
>Let's assume that our customized `bin/smartgit.vmoptions` looks like:
>
>
>
>    -Dsmartgit.updateCheckUrl=http://updateserver/smartgit/autoupdate
>    -Dsmartgit.autoupdate.checkSignature=false
>
>
>
>SHA-1 of this file is FCF5C579466B184693A1305FD161008203F82CA1.
>
>Let' assume we want to place following `license` file into the `default`
>directory:
>
>
>
>    Format=2
>    Name=Joe
>    Address=Average
>    Email=joe.average@company.com
>    ...
>
>
>
>SHA-1 of this file is 44737F607645106D5F52C097CE21E69025E8BDBB.
>
>The official `control-11190-win` file serves as starting point, which
>looks like:
>
>
>
>    HEADER
>    build=11190
>    minRequiredBuild=11170
>    versionName=17.1.2
>    majorName=17.1
>    majorDate=2017-10-12
>    executable32bit=bin/smartgit.exe
>    executable64bit=bin/smartgit64.exe
>    sourceRootUrl=http://www.syntevo.com/updates/smartgit
>    copyPatterns=bin/*.vmoptions,.settings/*,.updates/*,unins???.dat,unins???.exe
>    skipPatterns=lib/hgext/*.pyc
>    CONTENT
>    e6971f3e69c064e0468f13ae02a332b913f8e659    f   changelog.txt   changelog.txt
>    ...
>
>
>
>We will apply following modifications (highlighted in bold):
>
>
>
>`HEADER`  
>`build=11190`  
>`minRequiredBuild=11190`  
>`versionName=17.1.2`  
>`majorName=17.1`  
>`majorDate=2017-10-12`  
>`executable32bit=bin/smartgit.exe`  
>`executable64bit=bin/smartgit64.exe`  
>`sourceRootUrl=http://updateserver/smartgit/updates`  
>`copyPatterns=.settings/*,.updates/*,unins???.dat,unins???.exe`  
>`skipPatterns=lib/hgext/*.pyc,bin/*.vmoptions`  
>`CONTENTfcf5c579466b184693a1305fd161008203f82ca1    f    smartgit.vmoptions    bin/smartgit.vmoptions44737f607645106d5f52c097ce21e69025e8bdbb    f    license    default/licensee6971f3e69c064e0468f13ae02a332b913f8e659    f    changelog.txt    changelog.txt`  
>`...`
>
>
>
>Reasons:
>
>-   We have set `minRequiredBuild` to the same value as `build` to make
>    sure SmartGit will perform a "genuine" upgrade of the installation.
>    Only with such a genuine upgrade, we will be able to modify files
>    like `bin/smartgit.vmoptions` and `default/license`.
>-   The `sourceRootUrl` is set to the custom server.
>-   For `copyPatterns`, we have removed `bin/*.vmoptions`, because (1)
>    we are now providing this file as part of the installation and (2)
>    we don't want SmartGit to copy the file over from the old
>    installation anymore.
>-   For `skipPatterns`, we have added `bin/*.vmoptions`, because for the
>    first upgrade, `bin/smartgit.vmoptions` was not yet part of the
>    installation and we didn't copy it (see above). If we wouldn't skip
>    it either, SmartGit would consider this file as a leftover and thus
>    not clean up the old installation directory but issue a warning
>    instead
>-   For the `CONTENT` section, we have inserted our new files, including
>    their appropriate SHA.
>
>

# Debugging SmartGit's update mechanism

If updates are not working as expected, it can be helpful to debug the
update mechanism by adding following system property **temporarily**
to `smartgit.properties` of your test installation:



``` java
logging.q.application.update=DEBUG
```



After restarting SmartGit, you may grep `log.txt.0`
for `q.application.update`.
