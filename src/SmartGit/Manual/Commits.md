# Commits

A *commit* is a set of
changes that is stored in the repository along with a commit message.
The [Commit command](Local-Operations-on-the-Working-Tree.md#commit) is
used to store working tree changes in the local repository, thereby
creating a new commit.

## Commit Graph

Since every repository starts with an initial commit, and every
subsequent commit is directly based on one or more parent commits, a
repository forms a 'commit graph ' (or technically speaking, a directed,
acyclic graph of commit nodes), with every commit being a direct or
indirect descendant of the initial commit. Hence, a commit is not just a
set of changes, but, due to its fixed location in the commit graph, also
represents a unique repository state.

Normal commits have exactly one parent commit, the initial commit has no
parent commits, and the so-called *merge commits* have two or more
parent commits.



``` text
o ... a merge commit
| \
|  o ... a normal commit
|  |
o  | ... another normal commit
| /
o  ... yet another normal commit which has been branched
|
o ... the initial commit
```



Each commit is identified by its unique *SHA*-ID, and Git allows
*checking out* every commit using its SHA. However, with SmartGit you
can visually select the commits to check out, instead of entering these
unwieldy SHAs by hand. Checking out will set the HEAD and working tree
to the commit. After having modified the working tree, committing your
changes will produce a new commit whose parent will be the commit that
was checked out. Newly created commits are called *heads* because there
are no other commits descending from them.

## Putting It All Together

The following example shows how commits, branches, pushing, fetching and
(basic) merging play together.

Let's assume we have commits `A`, `B` and `C`. `master` and
`origin/master` both point to `C`, and `HEAD` points to `master`. In
other words: The working tree has been switched to the branch *master*.
This looks as follows:



``` text
o [> master][origin/master] C
|
o B
|
o A
```



Committing a set of changes results in commit `D`, which is a child of
`C`. `master` will now point to `D`, hence it is one commit ahead of the
tracked branch `origin/master`:



``` text
o [> master] D
|
o [origin/master] C
|
o B
|
o A
```



As a result of a Push, Git sends the commit `D` to the origin
repository, moving its `master` to the new commit `D`. Because a remote
branch always refers to a branch in the remote repository,
`origin/master` of our repository will also be set to the commit `D`:



``` text
o [> master][origin/master] D
|
o C
|
o B
|
o A
```



Now let's assume someone else has further modified the remote repository
and committed `E`, which is a child of `D`. This means the `master` in
the origin repository now points to `E`. When fetching from the origin
repository, we will receive commit `E` and our repository's
`origin/master` will be moved to `E`:



``` text
o [origin/master] E
|
o [> master] D
|
o C
|
o B
|
o A
```



Finally, we will now merge our local `master` with its tracking branch
`origin/master`. Because there are no new local commits, this will
simply move `master` *fast-forward* to the commit `E` (see [Fast-forward Merge](Merge.md#fast-forward-merge)).



``` text
o [> master][origin/master] E
|
o D
|
o C
|
o B
|
o A
```


