# Using the Git credentials manager

By default, SmartGit will handle repository authentication itself:

-   Starting from version 18.1, SmartGit adds a custom `credential.helper` configuration when executing remote commands to intercept Git's credential callbacks.
-   Up to version 17.1, Git command line prompts for username and password will be intercepted and an appropriate authentication dialog will be shown.

Sometimes, it may be convenient/helpful to let Git and the operating system handle authentication instead.
You can tell Git to do so by configuring the Git credential helper in your global `.gitconfig` or in the `.git/config` of a specific repository.
Below are coarse instructions given for different operating systems, for details refer to the [Git Book](https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage).

# Windows

Use following configuration:

``` java
[credential]
    helper = manager
```

# macOS

Use following configuration:

``` java
[credential]
    helper = osxkeychain
```
