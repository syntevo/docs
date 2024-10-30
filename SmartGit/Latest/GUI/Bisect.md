---
redirect_from:
  - /SmartGit/Latest/Bisect
  - /SmartGit/Latest/Bisect.html
---

# Bisect

The Bisect command allows you to find out which previous commit introduced problematic behavior in your project's repository, e.g., to find the origin of a bug which was not present in a previous release of an application.

Bisect works interatively, by checking out a commit approximately mid-way between the current commit (with the bug), and an earlier commit which was known **not** to have contained the bug.

You'll then be required to tell git whether this 'mid point' commit contains the bug (by marking the commit as *bad*), or worked correctly (marking the commit as *good*), e.g. by compiling this version of the application and performing a test. Depending on your response, git will bisect the remaining commits between this midpoint and either the starting commit (if you replied *bad*), or to the current commit (if the midpoint was *good*).

The process repeats until you narrow down the exact commit which introduced the bug.

In this manner, git bisect will efficiently be able to locate the problematic commit by performing a binary search - given N possible commits, you will be able to locate the bug in at most **log <sub>2</sub> N + 1** steps.

## Bisecting using SmartGit

It is recommended that you use bisect in the SmartGit Log or Standard Windows. The Working Tree Window has limited bisect related functionality.

Start a Bisect command by using the menu item **Branch\|Bisect\|Start**. Typically, the current branch HEAD contains the *bad* behavior, so you will usually select **Start Bisect with Bad HEAD**. The HEAD commit show as a red dot, which means *bad*. *Good* commits will be shown as green dots.

Now you will have to find a *good* commit in the commit history that did not contain the issue.

If you are confident that a prior commit (e.g. the inital commit) did not contain the issue, then you can right click on that commit and select `Mark as Good`. If you are unsure, you will need to checkout an earlier commit.

Now test your application to see whether the issue was present in this commit.

Then, select the corresponding buttons **Mark HEAD as Bad** or **Mark HEAD as Good**.

If your application still shows *bad* behavior at this commit, you need to repeat the checkout step and an even earlier commit, until you find a commit which does not contain the issue.

Once you have marked both a *bad* and a *good* commit, the bisecting process starts.

SmartGit will now automatically check out a commit midway between the closest *bad* and *good* commits.

Verify whether your application behaves correctly at this commit, and use the buttons **Mark HEAD as Bad** or **Mark HEAD as Good** as appropriate .

Iterate the above using a binary search to quickly find the problematic commit that causes the trouble. Once there are no remaining commits to be tested between a *good* and *bad* commit, SmartGit will show a dialog identifying the commit and author when the issue was introduced into the repository. You can choose to exit by selecting 'Leave Bisect', or you can abort the bisect by clicking **Abort** (in the banner).

Completing or Aborting or will check out the branch which was checked out when the Bisect command was first started.
