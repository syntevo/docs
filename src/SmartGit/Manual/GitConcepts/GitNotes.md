# Git Notes

This article explains how Git implements the _notes_ feature.

See also:
- [SmartGit Notes features](../GUI/Notes.md)
- [Setting up and Configuring Git Notes in SmartGit](../Integrations/GitNotes-Integration.md)

## Background

An often overlooked feature in Git is `git notes`, which allows text or binary meta-data to be attached to a commit.
As notes are linked to an existing commit, and do not affect the commit history of the working branch, notes can be added and removed after the commit is created without modify the branch's commit history.

Git notes works by creating a parallel `/refs/notes/<category>` reference in the repository, where `<category>` is the customizable 'type' of note that is to be added.

If no refs category is specified, Git will default `<category>` to **commits** (the category default can be overridden with the `GIT_NOTES_REF` environment variable or by setting the `core.notesRef` config value).

Each time a note is added or removed from `<category>`, a commit is added into `/refs/notes/<category>`.

For example:

`git notes add -m "Build released on 2025-03-22"`

will do the following:

- Create a new ref in the repository for the default 'commits' category `refs/notes/commits` (if it does not already exist).
- Create a new commit on this ref `refs/notes/commits`.
  Commits on the notes refs are orphaned from your usual code base branch refs.

Using the `--ref <category>` option allows you to add a note to the specified category ref, e.g.

`git notes --ref reviews add -m "Please remove unused imports on MyFile.java"`

#### Note
> - Like tags, by default, notes are not pushed or fetched by default when you synchronize your branches to a remote.
>   Notes will require manual synchronization with the remote, OR configuration changes need to be made to automatically synchronize notes with the remote.
>   e.g. Manually push notes in the default _commits_ category to the _origin_ remote:
>  `git push origin refs/notes/commits`
>
>  It is often simpler to [configure the repo to automatically push and fetch all notes](../Integrations/GitNotes-Integration.md#configuring-automatic-note-synchronization-with-remotes).
>
>  Similarly all note category refs can be fetched from the remote:
>  `git fetch origin 'refs/notes/*:refs/notes/*'`
>
> - There are certain limitations with the git notes design which should be understood:
>   - Only one note can be attached per refs Category per commit.
>     Additional notes metadata can be attached to a different commit, or different category, OR, the existing note will need to be amended to include the new metadata.
>   - As with any file under version control, conflicts can occur when two or more independent note changes or additions have been made to the same commit and refs category.
>     Please consult the available [notes merge strategies](https://git-scm.com/docs/git-notes#Documentation/git-notes.txt-merge) to choose an appropriate resolution strategy in your repository.
>   - As commits are rewritten during rebasing operations such as squash, notes associated with rewritten commits will become orphaned and will not be associated with the rebased commit.

Please refer to SmartGit's configuration guide for any of the following advanced settings:
- [Advanced Configurations](#advanced-configurations)
  - [Configuring automatic note synchronization with remotes](../Integrations/GitNotes-Integration.md#configuring-automatic-note-synchronization-with-remotes)
  - [Copying Git notes during rewriting activity (e.g. rebase)](../Integrations/GitNotes-Integration.md#copying-git-notes-during-rewriting-activity-eg-rebase)
  - [Removing Git Notes support from a repository](../Integrations/GitNotes-Integration.md#removing-git-notes-support-from-a-repository)

