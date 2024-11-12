# SVN: cloning with a custom branch layout

There are scenarios where the default branch-tag-layout may not be
sufficient. Following procedure allows you to customize the layout:

-   Edit the `smartgit.properties` file that you can find in [SmartGit's settings directory](../Latest/Installation-and-Files.md).
-   Add following line to the beginning of the file:

``` text
smartgit.debug=true
```
-   Restart SmartGit.
-   Select **Repository\|Clone**, enter the URL, press **Next**, then
    check **Just initialize clone (expert mode)** and complete the
    wizard.

SmartGit will initialize the repository without starting cloning. Don't
press Pull once finished, but exit SmartGit (**Repository\|Exit**).

-   Edit `path/to/repository/.git/svn/.svngit/svngitkit.config` to
    configure your custom layout by defining the `additional-branches`
    key.
-   Start SmartGit, reopen your project and invoke **Pull**.

#### Example: trunk has been copied from different project

To fetch an *old* trunk from a different project, a configuration could
look like as follows (there must be no line break for the whole
`additional-branches` key).



``` text
[svn-git-remote "svn"]
url = http://servername/svn/MyRepository
fetch = ProjectB/trunk:refs/remotes/svn/trunk
branches = ProjectB/branches/*:refs/remotes/svn/branches/*
tags = ProjectB/tags/*:refs/remotes/svn/tags/*
additional-branches =
"ProjectA/trunk:refs/remotes/svn-old/trunk;ProjectA/branches/*:refs/remotes/svn-old/branches/*;ProjectA/tags/*:refs/remotes/svn-old/tags/*"
```


