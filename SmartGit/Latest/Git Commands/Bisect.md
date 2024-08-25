# Bisect

The Bisect command allows you to find out which (past) commit introduced a problematic behavior in your project, e.g., a bug which was not present a half year ago.

Start a Bisect command by using the menu item **Branch\|Bisect\|Start**.
Typically, the current branch (HEAD) currently shows the *bad* behavior, so you can select **Start Bisect with Bad HEAD**.
Then the HEAD commit will show up with as red dot which means bad (*good* commits will be shown as green dots).

Now you will have to find a *good* commit in the history of HEAD that worked fine.
To do that, right-click commits in the history of HEAD and invoke **Check Out**.
Now test your application whether it runs fine or not.
Select the corresponding buttons **Mark HEAD as Bad** or **Mark HEAD as Good** (from the banner).
If your application still shows *bad* behavior, you need to go back even further and try further commits.
Once you have marked a *bad* and a *good* commit, the bisecting process starts.

Git will check out a middle commit between the closest *bad* and *good* commits.
Verify whether your application behaves correctly or not and use the buttons **Mark HEAD as Bad** or **Mark HEAD as Good** again to tell Git about it.
This will use a binary search to quickly find the problematic commit that causes the trouble.

You can always abort the bisecting-mode by clicking **Abort** (in the banner).
This will check out the branch which was checked out when starting the Bisect command.
