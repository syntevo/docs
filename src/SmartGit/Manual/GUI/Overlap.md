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

| Icon | Type | Description |
| --- | --- | --- |
| <img src="../images/Overlap-Identity-Unfixed.png" alt="Identity Unfixed" width="24" style="vertical-align: middle;"> | Identity | This is the selected commit, and the selection is not fixed to this commit, so it is free to move. |
| <img src="../images/Overlap-Identity-Fixed.png" alt="Identity Fixed" width="24" style="vertical-align: middle;"> | Identity Fixed | This is the selected commit, and the selection is fixed to this commit until it is de-selected or the branch is modified. |
| <img src="../images/Overlap-Pending.png" alt="Pending" width="24" style="vertical-align: middle;"> | Pending | Overlap calculation is pending. |
| <img src="../images/Overlap-No-Overlap.png" alt="None" width="24" style="vertical-align: middle;"> | None | This commit and the selected commit have no modified files in common. |
| <img src="../images/Overlap-Slight.png" alt="Slight" width="24" style="vertical-align: middle;"> | Slight | This commit modifies files in the selected commit, but compared to the total number of files modified, there is only a small overlap. |
| <img src="../images/Overlap-Heavy.png" alt="Heavy" width="24" style="vertical-align: middle;"> | Heavy / Superset | This commit modifies files in the selected commit, and compared to the total number of files modified, there is a lot of overlap. **Superset** is a special form of **Heavy** where the files modified in this commit are a superset of the files modified in the selected commit. |
| <img src="../images/Overlap-Equalset.png" alt="Equal Set" width="24" style="vertical-align: middle;"> | Equal Set | This commit and the selected commit modify exactly the same files. A separate icon for **Equal Set** is only available if `log.graph.overlap.useEqualSetIcon` is set to `true`. Otherwise, the **Heavy** icon is used instead. |
| <img src="../images/Overlap-Subset.png" alt="Subset" width="24" style="vertical-align: middle;"> | Subset | The files modified in this commit are a subset of the files modified in the selected commit. A separate icon for **Subset** is only available if `log.graph.overlap.useSubsetIcon` is set to `true`. Otherwise, the **Heavy** icon is used instead. |
| <img src="../images/Overlap-Shared.png" alt="Shared" width="24" style="vertical-align: middle;"> | Shared | The commits have at least one modification in the same place. Effectively this means that the commits usually can't simply be re-ordered in the feature branch. |
| <img src="../images/Overlap-Conflict.png" alt="Conflict" width="24" style="vertical-align: middle;"> | Conflict | There will likely be a conflict with this commit when trying to rebase the feature branch onto the current develop, because they modify the same file at the same place. |
| <img src="../images/Overlap-Skipped.png" alt="Skipped" width="24" style="vertical-align: middle;"> | Skipped | Overlap calculation was skipped. |
| <img src="../images/Overlap-Error.png" alt="Error" width="24" style="vertical-align: middle;"> | Error | There was an error determining the overlap status. See the tooltip for details. |

## Configuration

The Overlap Column can be enabled and disabled as described in [Graph View](./Graph-View.md). Additionally, there are a few [Low-Level Properties](./AdvancedSettings/Low-Level-Properties.md) to customize it:

- `log.graph.overlap.enabled` - set to `false` to disable the overlap feature completely
- `commitnet.overlap.baseCommits` - the number of base commits to calculate overlap information. It defaults to `100`, but it will never exceed `log.graph.overlap.maxCommits`.
- `log.graph.overlap.cacheSize` - sets the number of cached branches. Set to `1` to effectively disable the cache.
- `log.graph.overlap.intersectionThreshold` - adjusts the threshold at which an overlap is classified as **Heavy** versus **Slight**.
- `log.graph.overlap.maxCommits` - the maximum number of commits for which the overlap is calculated.
- `log.graph.overlap.maxDiffSize` - the maximum size of commit diffs for overlap tooltips in bytes. It defaults to `16777216` bytes and can be increased up to `1073741824` bytes.
- `log.graph.overlap.maxTooltipFilenames` - the maximum number of filenames displayed in tooltips.
- `log.graph.overlap.useEqualSetIcon` - set to `true` to display a separate icon for equal set overlap.
- `log.graph.overlap.useSubsetIcon` - set to `true` to display a separate icon for subset overlap.
