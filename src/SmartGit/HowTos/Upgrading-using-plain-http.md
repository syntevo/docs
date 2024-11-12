# Upgrading SmartGit using HTTP instead of HTTPS

Due to the (mis)configuration of internal firewalls, it may sometimes be impossible to upgrade SmartGit over HTTPS.
Symptoms of such a problem will usually be error messages like the following when invoking **Help|Check for New Version** (or **Help|Check for Latest Build**):

```
PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
```

For certain versions, we are providing update over plain HTTP.
To switch to plain HTTP, locate `smartgit.properties` in the Settings directory (see About dialog) and add following line

```
smartgit.updateCheck.url=http://www.syntevo.com/api/autoupdate/smartgit-nossl
```

After restarting SmartGit, try **Help|Check for New Version** (or **Help|Check for Latest Build**) again.
