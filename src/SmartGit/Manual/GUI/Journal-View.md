---
redirect_from:
  - /SmartGit/Manual/Journal-View
  - /SmartGit/Manual/Journal-View.html
---

# Journal View

The Journal View in SmartGit shows a compact history for the current branch, in linear fashion. This differs from the [Log view](Log.md) in that only the commits in the current branch are displayed.

![SmartGit Journal View](../images/Journal-View.png)

The colors have the following meanings:

- *Orange* commits denote *ahead* commits which are just present on your *local* branch but not yet on the *remote* branch. These commits will be sent to the remote branch/repository for the next [Push](Repository/Synchronizing-with-Remote-Repositories.md#push).
- *Green* commits denote *incoming* commits which are only present in the *remote* branch and will be integrated into your *local* branch for the next [Pull](Repository/Synchronizing-with-Remote-Repositories.md#pull).
- *Black* commits with *green* connectors denote commits which are currently present in the *remote* branch only, but have been present in your *local* branch at an earlier time. Usually, these are commits which have been *rewritten* using [Rebase](Branch/Rebase.md). 
  To show these commits, invoke the **Show Rewritten Commits** from the options menu.
- *Black* commits with *Blue* connectors denote commits from the *auxiliary* branch which can be toggled using **Show Auxiliary Branch** from the options menu.
- *Black* commits with *Gray* connectors denote commits which are common to more than one of the *local*, *remote* or *auxiliary* branch.

The number of commits displayed per category is limited, so the graph will stay neatly arranged even if there are lots of commits per category (e.g. hundreds or thousands of incoming commits). 
If you want to see more commits for a certain category you can expand this category by clicking the dashed area after its last commit. 
To expand all categories at once, you can use **Show More Commits (Temporarily)** from the action menu. 
You can permanently change the default number of displayed commits using by changing journal layout [Low-level properties](AdvancedSettings/Low-Level-Properties.md).

See [Interactive Rebase](Branch/Rebase-Interactive.md) for details on how to change/rewrite these commits.

#### Note

>
>The behavior of how commit times will (or will not) be adjusted can be configured by low-level properties
> ([smartgit.pushableCommits.preserveAuthorDate](AdvancedSettings/System-Properties.md)).
>

#### Tip

>
>To just change the commit message of the last commit (even for a merge commit or if the working copy is not clean),
> invoke **Local\|Edit Last Commit Message**.
>
