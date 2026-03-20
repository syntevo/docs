# Overlap

The **Overlap Column** in SmartGit is an optional column for the [Graph View](./Graph-View.md) visualizing similarity between commits using **symbols** and **tooltips** to do so.

It is active for the **feature branch** when using **[Git-Flow](../DevelopmentProcesses/Git-Flow.md)** or **[GitFlow Light](../DevelopmentProcesses/Git-Flow-Light.md)**, and displays the dependencies between the commits in the feature branch, as well as the dependencies of these commits to the commits in the develop branch which are ahead of the feature branch. 

## Usage

The **Overlap Column** provides a quick overview of the dependencies between commits, without having to examine all the commits in detail.

It can be thought of as an additional dimension in the **Graph View** that visualizes dependencies between commits which go beyond the strict dependency imposed by the commit graph itself.

The **Overlap Column** can help answer questions such as:

- When reordering commits in a feature branch, where are conflicts likely to occur?
- Which commits should probably be squashed?
- Which commits have unexpected dependencies and are therefore prime candidates for splitting up?
- Which file is causing the most conflicts when finishing the branch?
- Is the branch ready for review, or are there still commits reverting earlier changes?
- Does the branch consist of separate changes that could be handled as separate features instead?

## Types of Overlap

- **Shared** - the commits have at least one modification in the same place. Effectively this means that the commits usually can't simply be re-ordered in the feature branch.
- **Conflict** - there will likely be a conflict with this commit when trying to rebase the feature branch onto the current develop, because they modify the same file at the same place.
- **Equal Set** - this commit and the selected commit modify exactly the same files.
- **Subset** - the files modified in this commit are a subset of the files modified in the selected commit.
- **Superset** - the files modified in this commit are a superset of the files modified in the selected commit.
- **Heavy** - this commit modifies files in the selected commit, and compared to the total number of files modified, there is a lot of overlap.
- **Slight** - this commit modifies files in the selected commit, but compared to the total number of files modified, there is only a small overlap.
- **None** - this commit and the selected commit have no modified files in common.

## Configuration

The Overlap Column can be enabled and disabled as described in [Graph View](./Graph-View.md). Additionally, there are a few [Low-Level Properties](./AdvancedSettings/Low-Level-Properties.md) to customize it:

- `log.graph.overlap.enabled` - set to `false` to disable the overlap feature completely
- `log.graph.overlap.cacheSize` - sets the number of cached branches. Set to `1` to effectively disable the cache.
- `log.graph.overlap.intersectionThreshold` - adjusts the threshold at which an overlap is classified as **Heavy** versus **Slight**.
- `log.graph.overlap.maxCommits` - the maximum number of commits for which the overlap is calculated.
- `log.graph.overlap.maxTooltipFilenames` - the maximum number of filenames displayed in tooltips.