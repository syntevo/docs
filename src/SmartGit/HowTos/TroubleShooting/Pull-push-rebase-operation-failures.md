# Pull/push/rebase operation failures

In this case, it wasn't SmartGit itself that crashed, but one of its
helper applications. This is why SmartGit warns you about crashes even
though you didn't notice problems with SmartGit itself.

SmartGit uses the following helpers:

1.  SSH helper - involved in accessing (Fetch / Pull / Push) remote
    repositories via SSH.
2.  Credential helper - involved in accessing (Fetch / Pull / Push)
    remote repositories with passwords.
3.  Rebase helper - used in interactive rebases.

When a helper crashes, corresponding git's operation will usually fail.

Helper applications are rather small and simple. Crashes in them are
usually caused by external reasons, such as [exhausted virtual memory](Your-system-ran-out-of-virtual-memory.md).

  
