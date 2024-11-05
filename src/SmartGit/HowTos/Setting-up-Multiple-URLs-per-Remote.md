# Setting up Multiple URLs per Remote

In Git you can associate multiple URLs with a remote. This allows you to
push your commits to multiple remote repositories in a single step. To
set this up, open the `config` file in the `.git` folder beneath your
Git repository and add your URLs under the appropriate remote entries.

Example: Suppose your Git repository is named `myproject`. Open the file
`myproject/.git/config` with a text editor. Assuming you have remote
named *origin*, your modified `config` file might look like this:



``` text
...
[remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    url = C:/work/repo.git
    url = C:/backup/repo.git
...
```



Now when you do a push either from the terminal (e.g. `git push origin`)
or from within SmartGit, your commits will be send to all repositories
you added in the `config` file.
