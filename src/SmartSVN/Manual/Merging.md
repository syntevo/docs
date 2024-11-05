# Merging

Merging is used to incorporate changes from one 'development line' into
another.


#### Note
>
>
>Subversion's merging has been improved for various major Subversion
>releases. For certain merge features, there are minimum requirements on
>the server version. Also, merging may behave differently depending on
>the server version.
>
>

Two very common use cases of merging are *release branches* and
*feature* branches:

-   A *release branch* is typically forked off from the main development
    line ( *trunk*) after the 'release' of a new version (of the
    software project, of the website, etc). With the 'release' the
    corresponding version typically goes into 'production use ' and has
    to gain on stability while the development continues on the *trunk*.
    Therefore a release branch will only receive problem fixes (bug
    fixes) from *trunk* by merging them to the branch.
-   A *feature branch* is a line of development that is being worked on
    in parallel to the *trunk*, for the purpose of developing a new
    'feature' which is brought back to the *trunk* after completion. A
    *feature branch* is frequently merged from *trunk* to stay up to
    date with the *trunk* changes, and once the implementation of the
    'feature' has been finished, all relevant changes are merged back to
    the *trunk*.

For more in-depth information on these use cases, for examples and for
general information, refer to <http://svnbook.red-bean.com/>.


#### Warning
>
>
>As merging can often turn out to be rather tricky, a few recommandations
>will be given here:
>
>-   Do only recursive merges and try to always merge on the same 'merge
>    root', preferably *trunk* itself or the root of a branch.
>-   Avoid merging into a working copy which contains mixed revisions.
>    Therefore do an
>    [Update](Update.md#Update-commands.update), preferably to
>    **HEAD**, beforehand.
>-   Avoid merging into non-recursively (or incompletely) checked out
>    working copies. To do so, run an [Update     More](Update-More.md#UpdateMore-commands.update-more) on
>    your merge root, selecting all files and directories and the
>    **Recurse into subdirectories** option.
>
>
