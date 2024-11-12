# How to set up a Git server

Though Git is a distributed version control system, a common usage setup
is similar to, e.g. SVN, having one central Git server repository and
multiple user-specific Git repositories.

Of course, you could use cloud based Git hosting providers like GitHub,
Assembla or BitBucket, but here we want to cover the topic of using an
own server. Some Git hosting providers also offer a version that you
could install on your own server. A free and good one is GitLab
([www.gitlab.com](www.gitlab.com.md)).

Usually, Linux servers are used. They make authentication with SSH
simple and, if there already runs an Apache, https-authentication also
should be quite easy to install. We don't recomment network shares as
central Git repository location, if it is not for reliability then for
the possibility to delete or manipulate it directly without intent. If
you want to install on a Windows server, setting up SSH authentication
can be tricky, so one either has to install Apache to handle https
authentication or directly use an own hosting provider like GitLab.

On the Git server, you will need to have installed the Git executables.
Download from <http://git-scm.com/downloads> and install correctly.

Basically, it is possible to pull from and push to any repository, but
Git has problems to push branch changes to a repository with working
copy if it involves changing the checked out branch. On servers usually
you don't need a Git working tree (you usually don't edit and commit
directly there). Hence, socalled *bare* repositories without a working
tree are used. The directories of bare Git repositories usually end with
`.git`. To create one, invoke



``` text
git init --bare /path/to/repository.git
```



No matter whether you will use SSH or https, you should add all allowed
users to the same group, e.g. *gitusers* and set the guid permissions
recursively on the created repository directory structure.



``` text
chgrp -R gitusers /path/to/repository.git
        chmod -R u=rwX,g=rwXs,o= /path/to/repository.git
    
```



Now just set up the SSH as usually, either using private keys
(recommended) or password. Then you can clone the repository using the
URI <ssh://server:22/path/to/repository.git>. If you already have a
local repository that you want to import into the central repository,
just add the remote *origin* with this URI (**Remote\|Add** and then
push.
