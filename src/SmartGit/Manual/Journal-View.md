# Journal View

The Journal shows a compact history (Log) for the current branch:

-   *orange* commits denote *ahead* commits which are just present on
    your *local* branch but not yet on the *remote* branch. These
    commits will be sent to the remote branch/repository for the next
    [Push](Synchronizing-with-Remote-Repositories.md).
-   *green* commits denote *incoming* commits which are only present in
    the *remote* branch and will be integrated into your *local* branch
    for the next [Pull](Synchronizing-with-Remote-Repositories.md).
-   *black* commits with *green* connectors denote commits which are
    currently present in the *remote* branch only, but have been present
    in your *local* branch at an earlier time. Usually, these are
    commits which have been *rewritten* using [Rebase](Rebase.md). To show
    such commits, invoke **Show Rewritten Commits** from the options
    menu.
-   *black* commits with *blue* connectors denote commits from the
    *auxiliary* branch which can be toggled using **Show Auxiliary
    Branch** from the options menu.
-   *black* commits with *gray* connectors denote commits which are
    common to more than one of the *local*, *remote* or *auxiliary*
    branch.

The number of commits displayed per category is limited, so the graph
will stay neatly arranged even if there are lots of commits per category
(e.g. hundreds or thousands of incoming commits). If you want to see
more commits for a certain category you can expand this category by
clicking the dashed area after its last commit. To expand all categories
at once, you can use **Show More Commits (Temporarily)** from the action
menu. You can permanently change the default number of displayed commits
using System Properties.

See [Interactive Rebase](Rebase-Interactive.md) for details on how to change/rewrite these commits.

#### Note
>
>
>The behavior of how commit times will (or will not) be adjusted can be
>configured by low-level properties
>([smartgit.pushableCommits.preserveAuthorDate](System-Properties.md)).
>


#### Tip
>
>
>To just change the commit message of the last commit (even for a merge
>commit or if the working copy is not clean), invoke **Local\|Edit Last
>Commit Message**.
>
>
