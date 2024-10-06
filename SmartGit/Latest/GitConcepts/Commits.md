---
redirect_from:
  - /SmartGit/Latest/Commits
  - /SmartGit/Latest/Commits.html
---
# Commits

A *commit* is a set of file changes stored in a repository along with a commit message.
The **[Commit command](Local-Operations-on-the-Working-Tree.md#commit)** is
used to store working tree changes (which have been staged) in the local repository, thereby
creating a new commit.

## Commit Graph

As every repository starts with an initial 'genesis' commit, and each subsequent commit is directly based on one or more parent commits. 
This creates a 'commit graph ' (technically a Directed Acyclic Graph (DAG) consisting of of commit nodes), with each commit being a direct or
indirect descendant of the initial commit. Hence, a commit is not just a set of changes; due to its fixed location in the commit graph, it also represents a unique repository state.

Therefore:
- The initial commit has no parent commits.
- Normal commits have exactly one parent commit.
- *Merge commits* have two or more parent commits.

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
can visually select the commits to check out instead of entering 
unwieldy SHAs manually. Checking out sets the HEAD and working tree
to the commit. After modifying the working tree, committing your
changes will create a new commit whose parent is the one that was checked out. 
Newly created commits will also be *heads* in the DAG, 
because no other commits descend from them.

## Putting It All Together

The following example shows how commits, branches, pushing, fetching, and
(basic) merging interact.

Let's assume we have commits `A`, `B`, and `C`. Both **`master`** and
**`origin/master`** point to `C`, and **`HEAD`** points to **`master`**. In
other words. the working tree has been switched to the branch **master**.
This looks as follows:

``` text
o [> master][origin/master] C
|
o B
|
o A
```

Committing a set of changes results in commit `D`, which is a child of
`C`. **`master`** now points to `D`, meaning it is one commit ahead of the
tracked branch **`origin/master`**:

``` text
o [> master] D
|
o [origin/master] C
|
o B
|
o A
```

<div class="mermaid">
%%{init: { 'logLevel': 'debug', 'theme': 'default', 
  'gitGraph': {'rotateCommitLabel': false, 'mainBranchName': 'main'}, 
  'themeVariables': {
     'commitLabelFontSize': '1.1em'
   } } }%%
gitGraph BT:
  commit id: "A"
  commit id: "B"
  commit id: "[origin/master] C"
  commit id: "[HEAD master] D"
</div>

As a result of a Push, Git sends commit `D` to the origin
repository, moving **`master`** to the new commit `D`. Because a remote
branch always refers to a branch in the remote repository,
**`origin/master`** of our repository will also be set to commit `D`:

``` text
o [> master][origin/master] D
|
o C
|
o B
|
o A
```

Let's assume someone else has modified the remote repository
and committed `E`, a child of `D`. This means the **`master`** in
the origin repository now points to `E`. When fetching from the origin
repository, we will receive commit `E`, and our repository's
**`origin/master`** will be moved to `E`:

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

Finally, we will now merge our local **`master`** with its tracking branch
**`origin/master`**. Because there are no new local commits, this will
simply move **`master`** *fast-forward* to the commit `E` (see [Fast-forward Merge](Merge.md#fast-forward-merge)).

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