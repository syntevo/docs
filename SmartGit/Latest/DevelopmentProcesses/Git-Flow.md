---
redirect_from:
  - /SmartGit/Latest/Git-Flow
  - /SmartGit/Latest/Git-Flow.html
---
# Git-Flow

## Overview

Git-Flow is a well-known branching strategy popularized by Vincent Driessen in 2010 ([see "successful branching model"](http://nvie.com/posts/a-successful-git-branching-model/)). It is a relatively complicated strategy often used in repositories for systems where patching (`hotfixing`) of production releases is required while at the same time new feature development is ongoing.

SmartGit allows a repository to be configured for the Git-Flow strategy. This enables additional features that support GitFlow by wrapping the low-level Git commands into the SmartGit user interface, simplifying the steps needed to adhere to Git-Flow branching practices.

In Git-Flow, there are two primary long-lived branches (i.e., always expected to be present in a Git-Flow repository):
- `develop`
- `main` (historically also referred to as `master`)

**Note:** Although branch names can be changed, it is strongly recommended that the default names `develop` and `main` be retained when using Git-Flow.

### Develop Branch

The 'develop' branch contains ongoing development work.

It includes new commits merged from feature branches and fixes that have not been yet been released to the `main` branch (i.e., `develop` will have commits ahead of `main`).

Establishing continuous integration and deployment (CI/CD) pipelines from the `develop` branch is common practice so that recently added features can be tested in an appropriate environment.

### Main Branch

The `main` branch represents the stable release line. The HEAD commit represents the latest stable release of the software.
Updates to the `main` branch are infrequent occur when a new product version is finally released.

## Other branches

In Git-flow, only the `main` and `develop` are guaranteed to be present. Other branches will exist only temporarily.

### Feature Branches

For each new improvement to the ongoing development line, a separate `feature` branch is created by branching off the current HEAD of `develop`.
(By default, the naming convention of new features is `feature/my-feature`, where `my-feature` is a short name or work item number describing the new feature or a combination of the two).

This temporary branch works independently on the improvement (known as a 'feature').
The size of work (i.e., the number of files changed, added and deleted, and the number of commits needed to complete a feature) varies from team to team. Still, often, a feature represents a User Story, Task or other work item tracked in a tool such as Jira, Asana or Azure DevOps.

In Git-Flow, reserving the feature branch name in the team's remote repository is common by creating the `feature` branch in both the remote and local repositories simultaneously. Users in the team working on the feature will make commits to the feature branch and then push them to the corresponding feature branch on the remote repository.

Once the user or team responsible for the feature believes the work is complete, the 'feature' branch is merged or rebased into the
[develop](#develop-branch) branch. 

However, before integration, it is common to open a pull request between the `feature`branch and `develop` to allow for review and feedback.

After the feature branch changes are successfully integrated into `develop`, the feature branch is usually deleted.
This ensures that the only open branches in a repository with names prefixed by `feature` are those currently in development. 

``` text
o ... [> develop] merged feature A
| \
|  o [feature/feature-A] a commit to implement feature A
|  |
o  | ... interim commit into [develop]
| /
o  ... commit forked from [develop] to create branch [feature/feature-A]
```

### Release Branches

A temporary 'release' branch is created from the `develop` to prepare a planned software release. The 'release' branch
is usually forked when all features for the upcoming release are implemented and developed in a 'feature-freeze' state. 
This allows the release to be 'hardened' by fixing bugs without impacting ongoing development. 
When the`release` branch is ready for an official release, it is tagged and merged into both the [main](#main-branch) and the
[develop](#develop-branch) branch. A new release build is created for customers (e.g., 'version 4'). After
merging into `main`, the `release` branch is typically deleted.

**TODO** need better branch labelling on these diagrams. Below from Left to Right is `develop`, `release-4_0`, and `main`

``` text
o ... [> develop] ... the fix applied on the release 4_0 branch is reverse merged back into develop.
| \
|  \   o ... [main] ... release 4_0 (merge commit)
|   |/ |
|   o  | ... <tag/release-4_0_0> hardening commit on release 4_0 (e.g. bug-fix)
|   |  |
o  /   | ... feature commit on `develop` for a future release (not for 4_0)
| /    |
o      | ... feature commit on `develop` intended for upcoming release 4_0
|      |
|      o ... release 3_0_9
|     /|
```

### Hotfix Branches

If a serious bug is detected after a release, a 'hotfix' branch is created from the latest release state (HEAD of the [main](#main-branch) branch). The branch should be prefixed with `hotfix/`, followed by the fixed release number and identifier for the issue. 

After fixing the bug(s) in this hotfix branch, the state will be tagged and merged into both:
- The [main](#main-branch), to create a new build to be made available to your customers (e.g., 'version 4.0.1').
- The [develop](#develop-branch) branch, so that the bug is resolved and doesn't reappear in the next release.

The hotfix branch is typically deleted after merging.

``` text
o ... [> develop] reverse merge of hotfix 4_0_1 to prevent regression of the bug
| \
|  \   o ... [main] commit which fixes the bug, tagged, and new release 4.0.1 built
|   |/ |
|   o  | ... [hotfix/4_0_1]<tag/release 4_0_1> fork from [main] and new commit which contains the fix
|   |  |
o    \ | ... [develop] new feature commit in develop for a future release
|     \|
|      o ... [main]<tag/release 4_0> ... version released to customers which has subsequently been found to contain a bug
|     /|
```

### Support Branches

When the repository represents software where multiple versions (including legacy versions) need to be actively supported, 
it may be necessary apply fixes to legacy releases. This introduces additional discipline and complexity to the repository.

**Note:**
According to the Git-Flow documentation,support branches are still in the  'experimental' state.

By convention, support branches should follow the naming convention: `support/version.patch`

For example, your `main` branch may have an older commit tagged as 'release_3.0' which still requires support, even though
the head of `main` now represents the latest release (e.g., 'release_4.0'). 

The principle remains the same: a `support/3.0.1` branch be forked from the legacy release commit or tag, and the bug should be fixed in that branch.
However, the hotfix on the legacy release will **not** be directly merged back into `main`. Instead, another long-lived branch (e.g., `release 3.x`) 
will need to be created, from which the patched support release will be generated. This `release` branch should remain until the software version is no longer supported, at which point it can be deleted. (In some support variations of Git-Flow,  multiple named `release` branches are created instead of using `main`).

**Note:**
Common sense should be applied when deciding whether or not to merge the hotfix made in the support branch back into `develop` or merge the hotfix into more recent product releases (which could trigger new releases for all subsequent versions).
The divergence between legacy support releases and the current version in the repository means that changes made in the support branch may no longer be relevant to the current release.

However, if a commit from a support branch needs to be integrated into the latest release, the recommended approach is to:
- open a [hotfix](#hotfix-branches) branch from the relevant commit/tag on `main`.
- [cherry-pick](Cherry-Pick.md) the hotfix commit from the support branch.
- Merge or rebase the hotfix into `main` and create a new release.
- Reverse-merge the hotfix back into `develop` to prevent regression of the bug.
- Delete the hotfix branch.

Different teams may be responsible for new feature development and maintaining existing software versions in large organizations.
For example, the development team may create and own feature branches. In contrast, release, hotfix, and support branches may be managed by the release manager, with the support of an operations or support team.

## Git-Flow Commands

### Configure

Before starting to use Git-Flow, run the configuration command. You can use the default branch names or change them according to your needs. This will
write the Git-Flow configuration to your repository's `.git/config` file.

You can rename your **Develop** and **Main** branches here, though keeping the defaults is strongly recommended. If you have multiple remote repositories configured, you can use the **Remotes** section to select which remote repository Git-Flow should use. In the **Prefixes** section, you can specify the **Feature**-, **Release**-, **Hotfix**-, and **Support**-branches prefix. It is recommended that a sub-directory be used per category. A prefix can also be specified for for **Version Tags**, though no prefix is generally preferred to maintain simple tag names like `4.6.1`.

**TODO** Do these need to be here? [Release](#release-branches) or [Hotfix](#release-branches). 

If a `.gitflow` file exists in the root of your working tree, the default values will be read from this file. When cloning a repository
containing this file, Git-Flow will be initialized automatically, ensuring a quick Git-Flow setup for your team-members, even if you are using a non-default branch naming scheme. The format of this `.gitflow` file is the same as a Git-Flow-configured `.git/config`.

### Start Feature

This command initiates work on a new [feature](#feature-branches). After providing a name for the feature,
a corresponding feature branch will be forked off the `develop` branch, and the new feature branch will be checked out.


#### Info
>
>
>If the `develop` branch is currently check out, the **Flow** toolbar button defaults to this command.
>
> You can configure a custom prefix for features by the Git config option `gui.prefixStartFeature`.


### Finish Feature

Once the necessary changes for the feature have been committed, you can integrate them into the main development line using this command. There are
three ways to do this:
- Creating a merge commit (preserving feature commits).
- Squashing the commits into one commit.
- Using rebase (recreating the feature commits on top of the `develop` branch).
>
When merging or squashing, you need to enter the commit message for the new commit. Usually, you need to push the `develop` branch later.


#### Info
> To change the merge message template, define the [System Property](System-Properties.md) `gitflow.finishFeature.message`.


### Integrate Develop

If new commits were added to `develop` after the feature branch was created, you can use this command to integrate those changes into the feature branch. 
You can choose between `merge` (creating a merge commit) or `rebase` (recreating your feature branch commits on top of the latest `develop` commit).

The default operation is determined from your **Pull** defaults which are configured in the **Pull** dialog itself. Rebasing might not be
available in case of merge commits, though.

### Start Hotfix

To prepare a new bugfix release version based on the latest release (i.e., the `main` branch's HEAD), use this command without including new
changes from the `develop` branch. This will create a hotfix branch from the `main` branch using the given hotfix name.

### Finish Hotfix

Once changes for the bugfix release are ready, you can make them public with this command. This will create
a tag for the hotfix, merge it to the `main` and `develop` it. The 
actual commit that will be tagged when finishing a hotfix depends
on [System Property](System-Properties.md)
`gitflow.tagLastHotfixCommitInsteadOfMaster.`

### Start Release

Use this command to prepare a release independent of further changes in the `develop` branch. This will create a release branch from the
`develop` branch using the given release name.

### Finish Release

Use this command if you have prepared changes for the release and want to make it publicly available. This will create a tag for the release,
merge it into the `main` and `develop` branch. The actual commit which will be tagged when finishing a hotfix depends on [System Property](System-Properties.md)
`gitflow.tagLastReleaseCommitInsteadOfMaster.`

### Start Support Branch

Use this command to create a support branch from the `main` branch. There is no corresponding **Finish Support** command available, as
support branches live forever.

## Migrating from the 'main-release-branch' workflow

A common workflow and repository structure is to have a `main` branch where all development occurs. When it's time to release the software, a `release` branch is forked off from the main. This `release` branch represents the software's stable (production-ready) state at its current version. It lives indefinitely, and all bug-fixing for this specific software version happens only in that `release` branch. Occasionally, the `release` branch is merged back into `main`.

### Migration

Let's assume a project with an active `main` and release branches `release-1` ... `release-4` for the already released versions *1 ... 4*
of the software. A good time to switch to Git-Flow would be immediately before the release of upcoming version *5*:

-   Fork `develop` from `main` and instruct all  team members to continue their development in `develop`. Directly committing to
    `main` is no longer allowed.
-   When the development of version *5* reaches a feature-freeze state, start a [Release branch](#release-branches) called `release/5`.
    Continue working on version *6* in `develop`, bring `release/5` to production quality, and finally 'finish' the release.

The mapping from the *old* `main` to the Git-Flow `develop` branch is straightforward. The interesting point is how to proceed with
bug-fixes for already released versions.

#### Old release branches become 'support' branches

The old branches `release-1` ... `release-4` are actually [Support branches](#support-branches) and should be renamed to
`support/release-1` ... `support/release-4`.

### Usage

Once the branches have been migrated, you can adopt the Git-Flow branching model, which no longer uses long-living *release*-branches.

#### Hotfix branches are used instead of a 'current-release' branch

WHen the first issue for version *5* needs to be fixed, start a [hotfix branch](#hotfix-branches) called `hotfix/5.0.1` and apply the
fix there. The `hotfix/5.0.1` branch will remain open until you release bug-fix version *5.0.1*. The hotfix is *finished* at that point, resulting in a corresponding merge commit in `main`. If a new issue arises in version *5*, create a new hotfix branch called `hotfix/5.0.2`, which will automatically fork off from the `5.0.1` merge commit in `main`. This way, your `main` branch will proceed from version *5* release to *5.0.1*, *5.0.2*, etc.

If there is a serious issue in version *5.0.2*, that needs to be immediate fixing while `hotfix/5.0.3` is already in progress, follow these steps:

-   Start another hotfix branch called `hotfix/5.0.2a`, which forks from `5.0.2` commit in `main`, just like `hotfix/5.0.3`.
-   Apply the fix.
-   Finish the `hotfix/5.0.2a` immediately (and make the 5.0.2a version of the software public).

Now, `main` will contain the top-most `5.0.2a` commit, derived from the `5.0.2` commit. When `hotfix/5.0.3` is finished, the resulting `5.0.3`
commit in `main` will be derived from the `5.0.2a` and include the changes from both versions, *5.0.2a* and *5.0.3*. This will be released as version *5.0.3*.

#### Maintaining older versions

Hopefully, changes to older released versions will be minimal. If changes are necessary, apply them to the corresponding `support/release-` branches. Decide if these changes should also be included in the current release. If they should, [cherry-pick](Cherry-Pick.md) the commits into the latest `hotfix/5.0.x` branch (there should only be one such branch). In this way, the changes will eventually make it to `main` and `develop` when the hotfix is 'finished'.

### Customizing Git-Flow behavior

Git-Flow's behavior can be customized in several ways. The best reference for available options is the [source code](https://github.com/petervanderdoes/gitflow-avh). You will frequently find calls to `gitflow_override_flag_boolean`, such as:

```
gitflow_override_flag_boolean   "release.finish.nodevelopmerge" "nodevelopmerge"
```

To set this config option, use the Git command line:

```
git config gitflow.release.finish.nodevelopmerge 1
```

Alternatively, adjust the `.git/config`:

```
[gitflow "release.finish"]
	nodevelopmerge = 1
```
