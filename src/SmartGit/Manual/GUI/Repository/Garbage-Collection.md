# Garbage Collection

Git garbage collection removes unreachable objects and optimizes the local repository.
SmartGit usually runs these maintenance tasks automatically in the background.
Use **Run Garbage Collector** if you want to trigger the cleanup manually.

## Garbage Collector dialog

The dialog offers several options:

- **Also prune recently created objects**
- **Optimize repository more aggressively (may take a while)**
- **Expire reflog now (will also delete stashes!)**
- **Delete old LFS files from local storage (lfs prune)**

Use the aggressive option only when you explicitly want a slower but more thorough optimization run.

If **Expire reflog now (will also delete stashes!)** is enabled and the repository currently contains stashes, SmartGit shows an additional dangerous confirmation.
This is important because expiring the reflog at once also removes those stashes!

The **Delete old LFS files from local storage (lfs prune)** option is only available for repositories with Git-LFS enabled.

## Inspecting recyclable commits

You can inspect commits that are candidates for garbage collection in the **Log Window**.
In the **Branches** view, select **Recyclable Commits**.
