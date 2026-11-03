# Commits

A *commit* is a set of file changes stored in a repository along with a commit message.
The **[Commit command](../GUI/Local-Operations-on-the-Working-Tree.md#commit)** is used to store working tree changes (which have been staged) in the local repository, thereby creating a new commit.

## Commit Graph

Repositories generally<sup>1</sup> start with an initial root commit, and each subsequent commit will be directly based on one or more parent commits.
This creates a 'commit graph' (technically a Directed Acyclic Graph (DAG) consisting of of commit nodes), with each commit being a direct or indirect descendant of the initial commit.
Hence, a commit is not just a set of changes; due to its fixed location in the commit graph, it also represents a unique repository state.

> [!NOTE]
> <sup>1</sup> It is possible for a Git repository to contain more than one root commit (`git checkout --orphan`) and therefore contain multiple unrelated commit graphs.
> The wisdom of having more than one root commit needs to be balanced against creating separate repositories for each project.

Therefore:

- The initial commit has no parent commits.
- Normal commits have exactly one parent commit.
- *Merge commits* have two or more parent commits.

{% capture commit_graph_structure_setup %}
```bash
git init -b main
echo Example repository > README.md
git add README.md
git commit -m "the initial commit"
echo Shared work > shared.txt
git add shared.txt
git commit -m "a branched commit"
git switch -c side
echo Work on side > side.txt
git add side.txt
git commit -m "a normal commit"
git switch main
echo Work on main > main.txt
git add main.txt
git commit -m "another normal commit"
git merge --no-ff side -m "a merge commit"
```
{% endcapture %}

{% include git_example.html
  title="A repository with a merge commit"
  image="images/commit-graph-structure.png"
  alt="Two branches diverge after the branch point and join in a merge commit with two parents."
  width=290
  height=104
  setup=commit_graph_structure_setup
%}

Each commit is identified by its unique *SHA*-ID, and Git allows *checking out* every commit using its SHA.
However, with SmartGit you can visually select the commits to check out instead of entering unwieldy SHAs manually.
Checking out sets the HEAD and working tree to the commit.
After modifying the working tree, committing your changes will create a new commit whose parent is the one that was checked out.
Newly created commits will also be *heads* in the DAG, because no other commits descend from them.

## Putting it all together

The following sequence shows how commits, branches, pushing, fetching, and merging interact.
Create the initial repository once, then apply each later step in the same working directory.
The setup creates a local bare remote named `origin.git` and a working clone named `repo`.

<ol class="git-walkthrough">

{% capture commit_graph_initial_refs_commands %}
```bash
git init --bare -b main origin.git
git clone origin.git repo
cd repo
echo A > a.txt
git add a.txt
git commit -m "A"
echo B > b.txt
git add b.txt
git commit -m "B"
echo C > c.txt
git add c.txt
git commit -m "C"
git push --set-upstream origin main
```
{% endcapture %}

{% capture commit_graph_initial_refs_description %}
Start with commits `A`, `B`, and `C`.
Both `main` and `origin/main` point to `C`, and `HEAD` is attached to `main`.
Run this setup in an empty directory; the remaining steps continue inside `repo`.
{% endcapture %}

{% include git_step.html
  id="commit-graph-initial-refs"
  label="1. Initial repository"
  caption="main and origin/main both point to C."
  description=commit_graph_initial_refs_description
  image="images/commit-graph-initial-refs.png"
  alt="main and origin/main both point to C."
  width=227
  height=64
  commands=commit_graph_initial_refs_commands
%}

{% capture commit_graph_after_commit_commands %}
```bash
echo D > d.txt
git add d.txt
git commit -m "D"
```
{% endcapture %}

{% capture commit_graph_after_commit_description %}
Continue from step 1.
Create commit `D`, a child of `C`.
Local `main` is now one commit ahead of `origin/main`.
{% endcapture %}

{% include git_step.html
  id="commit-graph-after-commit"
  label="2. After committing D"
  caption="main points to D; origin/main stays at C."
  description=commit_graph_after_commit_description
  image="images/commit-graph-after-commit.png"
  alt="main points to D; origin/main stays at C."
  width=207
  height=84
  commands=commit_graph_after_commit_commands
%}

{% capture commit_graph_after_push_commands %}
```bash
git push origin main
```
{% endcapture %}

{% capture commit_graph_after_push_description %}
Continue from step 2.
Push `D` to the remote.
Its `main` advances to `D`, and the local remote-tracking ref `origin/main` also moves to `D`.
{% endcapture %}

{% include git_step.html
  id="commit-graph-after-push"
  label="3. After pushing D"
  caption="main and origin/main both point to D."
  description=commit_graph_after_push_description
  image="images/commit-graph-after-push.png"
  alt="main and origin/main both point to D."
  width=228
  height=84
  commands=commit_graph_after_push_commands
%}

{% capture commit_graph_after_fetch_commands %}
```bash
git clone ../origin.git ../colleague
cd ../colleague
echo E > e.txt
git add e.txt
git commit -m E
git push origin main
cd ../repo
git fetch origin
```
{% endcapture %}

{% capture commit_graph_after_fetch_description %}
Continue from step 3.
A colleague creates `E` on top of `D` and pushes it.
The first commands below simulate that work in a separate clone.
Fetching then updates `origin/main` in `repo` without moving local `main`.
{% endcapture %}

{% include git_step.html
  id="commit-graph-after-fetch"
  label="4. After fetching E"
  caption="origin/main points to E; local main stays at D."
  description=commit_graph_after_fetch_description
  image="images/commit-graph-after-fetch.png"
  alt="origin/main points to E; local main stays at D."
  width=202
  height=104
  commands=commit_graph_after_fetch_commands
%}

{% capture commit_graph_after_fast_forward_commands %}
```bash
git merge --ff-only origin/main
```
{% endcapture %}

{% capture commit_graph_after_fast_forward_description %}
Continue from step 4.
Merge `origin/main` into local `main`.
Since there are no new local commits, Git fast-forwards `main` to `E` without creating a merge commit.
{% endcapture %}

{% include git_step.html
  id="commit-graph-after-fast-forward"
  label="5. After fast-forwarding main"
  caption="main and origin/main both point to E."
  description=commit_graph_after_fast_forward_description
  image="images/commit-graph-after-fast-forward.png"
  alt="main and origin/main both point to E."
  width=226
  height=104
  commands=commit_graph_after_fast_forward_commands
%}

</ol>

See [Fast-forward merge](Merging.md#fast-forward-merge) for more details.
