# Git-Flow

## Overview

Git-Flow is a high-level command set wrapping low-level Git commands to
support the "successful branching model" (see
<http://nvie.com/posts/a-successful-git-branching-model/>). It reduces
the workflow steps necessary for the user.

To achieve this, Git-Flow assigns a special meaning to its branches. For
Git-Flow, there are two main branches which live forever, the 'develop'
and 'master' branch.

### Develop Branch

The single 'develop' branch (named by default `develop`) contains the
ongoing development line. It contains all finished improvements and
fixes.

### Master Branch

The single 'master' branch (named by default `master`) contains the
stable release line. Its HEAD represents the latest stable release.

Other branches usually exist only for a certain period of time.

### Feature Branches

For each new (non-trivial) improvement which should be added to the
ongoing development line, a separate 'feature' branch is created (named
by default, e.g. `feature/my-feature`). This temporary branch will be
used to work independently on this particular improvement ('feature').
If one thinks the feature is done, the commits from the 'feature' branch
are integrated (either merged or rebased) into the
[develop](#develop-branch) branch and the feature branch will usually be
deleted. This way all feature branches in a repository indicate the
features which are currently worked on.



``` text
o ... [> develop] merged feature A
| \
|  o ... a feature commit
|  |
o  | ... a develop commit
| /
o  ... another develop commit
```



### Release Branches

To prepare a (planned) software release, a temporary 'release' branch is
created from the [develop](#develop-branch) branch. The 'release' branch
is usually forked when all features for the upcoming release have been
implemented and the develop branch is in 'feature-freeze' state. Thus,
it makes the release independent of further improvements of the develop
branch and hence allows to 'harden' the release by fixing bugs. When the
state of this branch is ready for official release, it will be tagged
and merged into both the [master](#master-branch) and the
[develop](#develop-branch) branch, this way creating a new release build
to be made available to your customers (e.g. 'version 4'). After
successful merging, the release branch usually is deleted.



``` text
o ... [> develop] merged release 4_0
| \
|  \   o ... [master] ... release 4_0
|   |/ |
|   o  | ... <tag/release-4_0_0] a release-preparing commit (e.g. bug-fix)
|   |  |
o  /   | ... a develop commit for a future release
| /    |
o      | ... another develop commit
|      |
|      o ... release 3_0_9
|     /|
```



### Hotfix Branches

If after an official release a serious bug is detected, a 'hotfix'
branch will be created from the latest release state (the HEAD of the
[master](#master-branch) branch). After fixing the bug(s) in this hotfix
branch, the state will be tagged and merged into both the
[master](#master-branch) and the [develop](#develop-branch) branch, this
way creating a new build to be made available to your customers (bugfix
release, e.g. 'version 4.0.1'). After successful merging, the hotfix
branch usually is deleted.



``` text
o ... [> develop] merged hotfix 4_0_1
| \
|  \   o ... [master] ... release 4_0_1
|   |/ |
|   o  | ... <tag/release-4_0_1] a serious bug-fix
|   |  |
o    \ | ... a develop commit for a future release
|     \|
|      o ... release 4_0
|     /|
```



### Support Branches

Support branches are still in 'experimental' state, according to the
Git-Flow documentation. Nevertheless, they are used if you have multiple
older releases (e.g. 'version 3.0.\*') which are still supported while
the head of the master represents the latest release (e.g. 'version
4.0.\*'). Changes in support branches may be unique to the support
branch, because the code in the latest release is not present anymore or
the bug/improvement has been implemented there already. If a commit from
a support branch should still be integrated into the latest release,
open a [hotfix](#hotfix-branches) branch,
[cherry-pick](Cherry-Pick.md)
the commit and finish the hotfix.

Usually, feature branches are created by developers, whereas release,
hotfix and support branches are created by the release manager.

## Git-Flow Commands

### Configure

Use this command before starting to use Git-Flow. You can use the
default branch naming or change it according to your needs. This will
write the Git-Flow configuration to `.git/config` of your repository.

Here you can change the name of your **Develop Branch** and **Master
Branch**, though it's strongly recommended to keep the defaults. In case
you have multiple remote repositories configured, you can use
**Remotes** to select which of the remote repositories should be used by
Git-Flow. In the **Prefixes** section you can specify which prefix
should be used for **Feature**-, **Release**-, **Hotfix**- and
**Support**-branches. Having a sub-directory per category, is
recommended. **Version Tags** specifies the prefix for tags which will
be created when finishing a [Release](#release-branches) or
[Hotfix](#release-branches). Usually, it will be fine to use no prefix,
as this will give you nice and simple tag names, like `4.6.1`.

If there is a `.gitflow` file in the root of your working tree, the
default values will be read from this file. When cloning a repository
which already contains the `.gitflow` file, Git-Flow will be initialized
automatically. This allows a quick Git-Flow configuration for each of
your team-members even if you use a non-default Git-Flow branch naming
scheme. The format of this `.gitflow` file is the same as for a Git-Flow
configured `.git/config`.

### Start Feature

Use this command to start the work on a new
[feature](#feature-branches). After providing a name for the feature,
the corresponding feature branch will be forked off the `develop` branch
and this new feature branch will be checked out.


#### Info
>
>
>If the `develop` branch is currently check out, the **Flow** toolbar
>button defaults to this command.
>

> You can configure a custom prefix for features by the Git config
> option `gui.prefixStartFeature`.



### Finish Feature

Use this command if you have committed your changes necessary for the
feature and want to integrate them into main development line. There are
3 ways of doing this: by creating a merge commit (your feature commits
will be preserved), by creating a simple commit (all your feature
commits will be squashed into one commit) or by using rebase (your
feature commits will be re-created on top of the `develop` branch). When
merging or squashing, you need to enter the commit message for the new
commit. Usually, you need to push the `develop` branch later.


#### Info
> To change the merge message template, define the [System Property](System-Properties.md) `gitflow.finishFeature.message`.



### Integrate Develop

If new commits were created in the `develop` branch after you've created
a feature branch, you may use this command to get the changes from the
`develop` branch into your feature branch. You have the choice between
using merge (which will create a merge commit in your feature branch) or
rebase (your feature branch commits will be re-created on top of the
latest develop commit).

The default operation is determined from your **Pull** defaults which
are configured in the **Pull** dialog itself. Rebasing might not be
available in case of merge commits, though.

### Start Hotfix

Use this command to prepare a new bugfix release version from the latest
release version (HEAD of the `master` branch) without using any new
changes from the `develop` branch. This will create a hotfix branch from
the `master` branch using the given hotfix name.

### Finish Hotfix

Use this command if you have prepared some changes for the new bugfix
release version and want to make it publicly available. This will create
a tag for the hotfix, merge it to the `master` and `develop` branch. The
actual commit which will be tagged when finishing a hotfix depends
on [System Property](System-Properties.md)
`gitflow.tagLastHotfixCommitInsteadOfMaster.`

### Start Release

Use this command to prepare a release, independent of further changes in
the `develop` branch. This will create a release branch from the
`develop` branch using the given release name.

### Finish Release

Use this command if you have prepared changes for the release and want
to make it publicly available. This will create a tag for the release,
merge it into the `master` and `develop` branch. The actual commit which
will be tagged when finishing a hotfix depends on [System Property](System-Properties.md)
`gitflow.tagLastReleaseCommitInsteadOfMaster.`

### Start Support Branch

Use this command to create a support branch from the `master` branch.
There is no corresponding **Finish Support** command available, as
support branches live forever.

## Migrating from the 'master-release-branch' workflow

A common workflow and repository structure is to have a `master` in
which all development takes place and once it comes to a release of the
software, a `release`-branch is forked off from the master. This
`release`-branch represents the stable (production-ready) state of the
software at its current version, lives forever and all bug-fixing for
this specific software version happens in that `release`-branch only.
From time to time the `release` branch is merged into the `master`.

### Migration

Let's assume a project which has an active `master` and release branches
`release-1` ... `release-4` for the already released versions *1 ... 4*
of the software. A good occasion to switch to Git-Flow will be
immediately before the release of upcoming version *5*:

-   Fork `develop` from `master` and tell all your team-members to
    continue their development in `develop`. Directly committing to
    `master` is not allowed anymore.
-   When the development of version *5* is in feature-freeze state,
    start a [Release branch](#release-branches) called `release/5` ,
    continue with work on the next version *6* in `develop`, bring
    `release/5` to production quality and finally 'finish' the release.

The mapping from the *old* `master` to the Git-Flow `develop`-branch is
straight-forward. The interesting point now is how to proceed with
bug-fixes for already released versions:

#### Old release branches become 'support' branches

The old branches `release-1` ... `release-4` are actually [Support branches](#support-branches) and should be renamed to
`support/release-1` ... `support/release-4`, hence.

### Usage

Once the branches have been migrated, you now can adopt the Git-Flow
branching model, which does not know about long-living
*release*-branches anymore.

#### Hotfix branches are used instead of a 'current-release' branch

Once the first problem needs to be fixed for version *5*, start a
[hotfix branch](#hotfix-branches) called `hotfix/5.0.1` and apply the
fix there. The `hotfix/5.0.1` branch will remain open until you decide
to officially release bug-fix version *5.0.1*. Only then, this hotfix
will be *finished* what results in a corresponding merge commit in
`master`. Once a new problem needs to be fixed in version *5* series,
create a new hotfix from `hotfix/5.0.2` which will automatically be
forked off the `5.0.1` merge commit in `master`. In this way, your
master will proceed from version *5* release, to *5.0.1*, *5.0.2*, ...

If there is a serious problem in e.g. version *5.0.2*, which needs to be
fixed immediately and `hotfix/5.0.3` is already in progress, do the
following:

-   start another hotfix branch `hotfix/5.0.2a`, which is forked off
    from `5.0.2` commit of `master`, as `hotfix/5.0.3` is,
-   apply the fix and
-   finish the `hotfix/5.0.2a` immediately (and make the 5.0.2a version
    of the software public)

Now, `master` will contain a top-most `5.0.2a` commit, derived from
`5.0.2` commit. When finishing `hotfix/5.0.3`, the resulting `5.0.3`
commit in `master` will be derived from the `5.0.2a` and have the
`hotfix/5.0.3` merged in, i.e. it will represent the changes from both
versions, *5.0.2a* and *5.0.3*. That's exactly what you would like to
release now as *5.0.3* version.

#### Maintaining older versions

Hopefully, you won't need to apply many changes to older released
versions. If you still need to, apply these changes to the corresponding
`support/release-` branches and decide whether these changes should go
into the current release as well: if not, you are all set now. If they
should,
[cherry-pick](Cherry-Pick.md)
the corresponding commits into the latest `hotfix/5.0.x` branch. There
should be one such branch only, anyway. In this way, the changes will
make it to `master` and `develop` later, when the hotfix is 'finished'.

### Customizing Git-Flow behavior

Git-Flow's behavior can be customized in various ways. The best reference of all available options is the [source code](https://github.com/petervanderdoes/gitflow-avh). You will frequently find calls to `gitflow_override_flag_boolean` there, for example:

```
gitflow_override_flag_boolean   "release.finish.nodevelopmerge" "nodevelopmerge"
```

To set this config option, you can use Git command line:

```
git config gitflow.release.finish.nodevelopmerge 1
```

or - equivalently - adjust the `.git/config`:

```
[gitflow "release.finish"]
	nodevelopmerge = 1
```
