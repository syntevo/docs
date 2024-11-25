---
redirect_from:
  - /SmartGit/Manual/GUI/Repository
  - /SmartGit/Manual/Repository-Related
  - /SmartGit/Manual/Repository-Related.html
---

# Working with Repositories

This section describes common SmartGit actions you'll need to use when working with Git Repositories on your local system.

**Contents:**

- [SmartGit's Repositories View](../Repositories-View.md)
- [Opening a Repository](#opening-a-repository)
- [Cloning a Remote repository](Clone.md)
- [Working with Files and Directories within Repositories](Repositories-Directories-and-Files.md)
- [Managing Remotes](Managing-Remotes.md)
- [Synchronizing changes with Remotes](Synchronizing-with-Remote-Repositories.md)
    - [Pull and Fetch](Synchronizing-with-Remote-Repositories.md#pull)
    - [Push](Synchronizing-with-Remote-Repositories.md#push)
- [Repository Settings](Repository-Settings.md)
    - [Setting user identity information in the User Tab](Repository-Settings.md#user-tab)
    - [Fetch and Pull Options](Repository-Settings.md#fetch-and-pull-tab)
    - [Push Options](Repository-Settings.md#push)
    - [Signing Options](Repository-Settings.md#signing-tab)
    - [Tag Grouping Settings](Repository-Settings.md#tag-grouping)
- Working with [Submodules](Submodules.md) and [Subtrees](Subtrees.md)
- [The Garbage Collector](#the-garbage-collector)

## Opening a Repository

Use **Repository \| Add or Create** to either open an existing local repository (e.g., initialized or cloned with the Git command line client) or to initialize a new repository.

Specify the local directory you want to open. If the specified directory is not yet a Git repository, you can initialize it.

## Settings

Once you have a opened a repository, use [**Repository \| Settings**](Repository-Settings.md) to configure repository-specific settings.

## The Garbage Collector

The Git Garbage Collector performs housekeeping tasks such as deleting commits which are no longer referenced in the repository, such as:

- commits which have been rebased
- commits which have been amended and rewritten to a new commit
- commits which have been squashed

The Git Garbage Collector usually runs in the background, however, you can choose to explicitly execute the **Run Garbage Collector** command to force the garbage collector (`git gc`) to run immediately.

You can view commits eligible for garbage collection in SmartGit's Log by selecting the **Recyclable Commits** option in the *Branches* view of the [Log Window](../Log-Window.md).
