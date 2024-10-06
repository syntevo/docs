# Distributed Reviews (add-on)

The *Distributed Reviews* add-on allows your team to create a *Pull
Request* from one branch to another and to *comment* on pull requests
and individual commits. Contrary to *centralized* code reviewing systems
like GitHub, no dedicated server is required: all review metadata is
stored in the Git repository itself and distributed the same way as your
primary content/commits. This gives you all the benefits of Git: you can
work offline and you can prepare your pull requests and comments locally
and only push them when ready, or discard them if you change your mind,
without affecting anyone else.

## Initialization

To initialize the Review system for your local repository invoke
**Review\|Configure**.

SmartGit will query all currently configured *remotes* to see whether
any of them already contains a *Review database*. If this is the case,
SmartGit will clone this database and *connect* the local Review system
to it. If none of the remotes contains a Review database, a completely
new database will be created and the [users database](#users) will be
populated from the repository log.

For a *shared* repository (including all its *clones*), the
initialization of a completely new database should only be done once,
e.g. when starting to introduce the Review system for your project. This
will usually happen in one of the clones. After the initialization of
the local repository, invoke **Review\|Configure** and select
**Initialize a Remote** to push your Review database back to the
selected remote, thus initializing this repository as well. From this
point on, **Review\|Configure** can be invoked in all other clones of
the shared repository to clone and connect to the same Review database.

## Workflows

### Using a Pull Request to request a review or integration of a feature

*Pull Requests* are used to signal that you consider a *feature branch*
as 'ready' and request someone else to review and integrate this branch
into the main development line (usually `master` or `develop` in case of
[Git-Flow](Git-Flow.md)).

To create a Pull Request, select your *feature branch* in the
**Branches** view and invoke **Create Pull Request** from the context
menu. In the upcoming dialog, select the **target** branch and a
**Message** describing the purpose of the Pull Request. It's recommended
to specify at least one **Assignee**, who is the right person to review
and integrate this Pull Request. The Pull Request will be highlighted to
all assignees in the **Branches** view (in the Project as well as the
Log window).

Once the Pull Request has been created, it is in *pending state* and
will show up in the **Pull Requests** category of the **Branches** view
as *local only*. It will be published, i.e. sent to the remote
repository, for the next time you invoke **Push**. Alternatively, you
can manually force publishing the Pull Request using **Review\|Sync**.

### Reviewing and integrating a Pull Request

Once a Pull Request is published (i.e. present in the remote
repository), it will be fetched by all other users for their next
invocation of **Pull** or by doing **Review\|Sync** manually. If you are
amongst the **Assignees** of a Pull Request, it will be highlighted to
you in the **Branches** view.

To review or integrate a Pull Request, open the Log and select and
reveal the Pull Request from the **Pull Requests** category. The Pull
Request is represented by a merge commit which connects its source (the
feature branch) with the *merge base* between the source and the Pull
Request's target (probably `master` or `develop`). When selecting this
Pull Request commit in the **Commits** graph, the **Files** view will
show all affected files of the Pull Request and you can drill down to
content changes in the **Changes** view.

-   If the Pull Request is not yet ready for merge and/or there is
    something to object to, you may leave a comment (see section
    [Commenting changes](#commenting-changes)) and **Reject** the Pull
    Request. At the same time, you will probably want to assign the Pull
    Request back to the author or someone else who you think can best
    deal with your comments. Comments may be applied to the Pull Request
    commit itself (either to the commit of the affected files' changes)
    or to individual commits of the Pull Request, whatever suits your
    needs better.
-   If the Pull Request is fine, you may **Integrate** the Pull Request
    from the **Branches** view context menu. The **Integrate** dialog is
    similar to [Git-Flow's Finish Feature dialog](Git-Flow.md#finish-feature):
    you can select how to integrate the commits and some optional cleanup tasks.
    Alternately, you may just **Approve** the Pull Request and assign it
    to someone who should finally **Integrate** the Pull Request.
-   If you don't feel to be the right assignee for the Pull Request at
    all, you may simply **Assign** it to someone else who you think can
    deal with it better.

In either case it's recommended to add an optional **Comment** which
explains the reason for the reassignment. Such *Pull Request Comments*
will show up in the **Branches** view directly below the Pull Request
and they will be displayed in the **Commit** view as well, when
selecting the corresponding Pull Request commit.

When you are done with the integration (or review), be sure to **Sync**
your activity with the remote repository.

### Commenting changes

A main feature of the Review system is attaching comments to changes.
Usually, you will apply comments while doing a review of a Pull Request,
however you can comment on arbitrary changes (commits) as well. Contrary
to other reviewing systems, like GitHub, there is no difference between
comments on Pull Request commits and comments on any other commits and
thus the procedure is identical in both cases:

-   To comment on a *commit* in general, use **Add Review Comment** from
    the graph context menu.
-   To comment on an individual change in the **Changes** view, use
    **Add Review Comment** from the context menu on the corresponding
    line.

Comments will show up in the **Commits** graph, the **Files** table and
**Changes** view. The **Comments** table will show all comments
currently present in the repository and allows to **Jump To** a comment,
or **Edit** or **Delete** a comment.

### Inspecting a Pull Request history

Pull Requests include the information on all *head* commits they had
ever been 'on'. Especially, the current *head* of a Pull Request will
change when *Rebasing* a Pull Request, e.g. to keep the corresponding
*feature* branch up-to-date with `master`. By having access to all
'historical' heads, you will also have access to all (historical)
comments for the Pull Request, thus being able to understand the history
and development of a Pull Request.

By default, only the most recent head will show up in the Log **Graph**
when toggling the pull request in the **Branches** view. To view details
for the pull request, select the pull request commit in the **Graph**
and switch to the **Commit** view. Here you will also be able to display
older heads by clicking the **Version** links.

### Closed Pull Requests

After integrating or closing a pull request, the pull request will still
be present in the Review database, but by default be hidden from the
**Branches** view. To display *closed* pull requests, select
**Review\|Show Closed Pull Requests**.

As long as a pull request is still present in the database, SmartGit
maintains *refs* pointing to all of its heads, thus preventing Git from
garbage collecting the corresponding commits, see [Historic Commit Refs](#historic-commit-refs). Only by invoking **Delete** on a *closed*
pull request, it will be removed from the database and correspondings
*refs* will be deleted.

## Users

## Database structure

The entire review metadata is stored in a couple of special refs of your
Git repository: the latest version of your local metadata is referenced
by `refs/meta/smartgit/reviews`, the latest (fetched) metadata for each
configured remote is referenced by
`refs/meta/smartgit/remotes/<remote-id>/reviews`. `<remote-id>`s are
unique identifiers of remotes and are defined in `.git/config`. Using
IDs instead of the remotes' names avoids problems when renaming a
remote.

The metadata refs are pointing to an *orphan* tree structure which
stores the metadata as a set of many small text files. The tree and file
structure has been defined in a way to avoid possible content conflicts
which would require a manual resolution by the user. (This could happen
e.g. if two users have locally modified the same comment). The root of
the metadata tree consists of following categories:

-   a `README` file which gives information about the purpose of this
    directory tree;
-   a `commit` category which contains comments attached to commits. The
    naming scheme for comments affecting the commit in general (not a
    particular file) is `comments/<commit>/h/<comment-id>/<file-sha>`.
    The scheme for comments affecting a particular file is
    `comments/<commit>/f/<file-path>/<comment-id>/<file-sha>`;
-   a `ref` category which contains pull requests. The naming scheme for
    a pull request is `ref/<ref>/h/<pull-request-id>/<file-sha>`;
-   a `note` category which contains comments on pull requests. The
    naming scheme for a pull request comments is
    `note/<pull-request-id>/h/<comment-id>/<file-sha>`.
-   a `global` category which contains information on [users](#users).

Thus, every comment or pull request is represented in the file system by
its *ID*. From the user perspective a comment as well as pull request is
exactly one *entity*. From a more low-level perspective all these
entities are treated the same way and one entity actually comprises a
set of *immutable* files which represent different versions of the
entity and which have their own *hash* as filename.

If an entity is modified, this will result in the deletion of the file
`<old-file-sha>` and the creation of a new file `<new-file-sha>` in the
entities' directory. `<old-file-sha>` as well as `<new-file-sha>`
contain the entire old/new state of the entity and in addition
`<new-file-sha>` will have a `replaces: <old-file-sha>`-information
attached, so SmartGit will be able to interpret the new file as being a
replacement of the old file.

### Conflict Resolution

The *immutable files* design may look overly complex, however it has the
crucial advantage of getting rid of conflicts on the core file-system
(or *syntactical*) level, and instead moving these conflicts up to the
*semantical* level.

*Syntactical* conflicts would occur e.g. when pulling or pushing review
metadata and encountering the same file with modified content in both
versions. Thus, the user would be forced to solve a conflict in such a
core metadata file. The move up to the *semantical* level happens by
simply having two versions of the entity alive, which will be stored in
different `<file-sha>`-files.

Even better, changes which would have resulted in conflicts on the
*syntactical* level, may be mergeable on the *semantical* level: e.g. if
one users assigns a pull request to `A` and another user assigns the
pull request to `B`, it will be 'merged' the safe way to have the pull
request be assigned to `A` as well as `B`. This is similar for the
content of a comment: if changed concurrently to `X` as well as `Y`, it
will finally show up as `X` and `Y`. SmartGit knows about these
'diverged' versions of one entity and it will highlight this fact to the
user, where necessary.

The resolution of these 'conflicts' is done by the user when editing the
entity: in our example, it was unclear whether `A` or `B` should be the
assignee, so either of these users might have a look at the pull request
and if he does not feel a suitable assignee, he may remove himself from
the list. In case of the diverged comment `X` and `Y`, keeping both
comment versions might be fine. If not, one of them can simply be
removed and the other one fixed to include some additional information
from the removed one.

### Local Review Data

From the difference between `refs/meta/smartgit/reviews` and
`refs/meta/smartgit/remotes/<remote-id>/reviews`, SmartGit will derive
which pull requests and comments ('entities') are *local*.

After pushing regular commits to a certain remote or when invoking
**Review\|Sync**, SmartGit will include only those entities for which
their referred commits (or refs) are already present in the
corresponding remote. In this way, you can create local commits together
with local review data and push them only all at once. Before pushing
local review data, SmartGit will squash all your local review tree
commits into a single commit: this especially means that additions
followed by deletions of certain entities or some back and forth while
editing entities will be skipped. Thus, similar as for 'normal' Git
commits, you have freedom in how to assemble your review data; only the
final result will matter.

### Historic Commit Refs

SmartGit maintains a list of special refs
`refs/meta/smartgit/commits/<sha>` for all commits which are
representing pull request heads (current heads as well as historic
heads) and for all commits to which a comment is assigned. This happens
to (1) make such commits *pushable* and *pullable* and (2) to preserve
them from being garbage-collected by Git: while on the client-side, the
*reflog*-files are usually preventing a garbage collection, this is by
default not the case on the server-side.

By default, historic commit refs will be removed, once the corresponding
entity will be removed from the database. To disabling pruning of such
commits, you have to unset the `prune-commit-refs` option in the review
database:

-   Create a new clone of your repository, initialize the review
    database for this clone and use this clone for subsequent operations
-   Checkout `refs/meta/smartgit/reviews`:



``` text
git checkout refs/meta/smartgit/reviews         
```



Now the working tree will contain the entire content of the review
database; you may see top-level directories like `ref`, `commit` or
`global`.

-   Create top-level directory `options` (if it does not exist yet)
-   From the repository root, invoke following command (on Windows, you
    have to use *git bash*):



``` text
git rm options/prune-commit-refs
git commit -m "configuration changed to prune obsolete commit refs"
git update-ref refs/meta/smartgit/reviews `git rev-parse HEAD` 
```



-   Finally, sync this change using SmartGit's **Review\|Sync**.

Once this change has been pulled to a different clone for which
Distributed Reviews are enabled, obsolete refs won't be removed anymore
from now on. To confirm that the option actually works, you may invoke
following command *before* adding and *after* removing a comment
locally:



``` text
git show-ref | grep -c refs/meta/smartgit/commits        
```



If the displayed number remains increased after having removed the
comment, you are done.

## Disposing your local Review Database

Sometimes it may be desirable to reinitialize your local review database
from the server's database. For that, it's necessary to first dispose
your local database using **Review\|Configure** and select **Dispose
Database** there.


#### Note
> To dispose the review database from command line (not recommended),
> invoke:
> 
> `git update-ref -d refs/meta/smartgit/reviews`

## Disposing all Distributed Reviews data from your project

To get rid of Distributed Reviews data not just for your local clone, but also for the remote repository and all clones from this repository, following steps are required:

- on the server, delete all `refs/meta/smartgit/*`-refs
  - usually there are no packed refs on the server, hence you can simply delete these refs from the file system
  - alternatively, if you do not have access to the server's file system, you may use `git push --delete <remote> <ref>` to delete them remotely
- on every clone, invoke **Review\|Configure** and select **Dispose Database**

## Customizing the pull request integration message

The default message which will be set for the **Integrate Pull Request**
dialog can be customized by using a message template. The message
template will be specified using [system property](System-Properties.md) `smartgit.reviews.integrateMessageTemplate`.
Following variables can be used:

-   `${id}:` the short pull request ID
-   `${message}:` the entire pull request message (including new lines)
-   `${source}:` the pull request source branch
-   `${target}:` the pull request target branch
-   `${creatorName}:` the name of the user who has created the pull
    request
-   `${creatorEmail}:` the email address of the user who has created the
    pull request
-   `${creationTime}:` the creation time of the pull request

To introduce line breaks in the message, use `\n` in the message
template.

  
