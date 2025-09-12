# Git-Notes Integration *(experimental in 25.1)*

This article explains how to configure and enable [**SmartGit's Notes features**](../GUI/Notes.md) through ordinary Git configuration files.

---

## Contents
- [Enabling Notes features in SmartGit on a repository](#enabling-notes-features-in-smartgit-on-a-repository)
- [A minimal [smartgit-notes] configuration](#a-minimal-smartgit-notes-configuration)
- [`smartgit-notes` section reference](#smartgit-notes-section-reference)
- [Example configurations](#example-configurations)
  - [1 -- Override Classic *commits* notes](#1--override-classic-commits-notes)
  - [2 -- Separate *code-reviews* category with filtering](#2--separate-code-reviews-category-with-filtering)
  - [3 -- Multiple categories side-by-side](#3--multiple-categories-side-by-side)
- [Advanced Configurations](#advanced-configurations)
  - [Configuring automatic note synchronization with remotes](#configuring-automatic-note-synchronization-with-remotes)
  - [Copying Git notes during rewriting activity (e.g. rebase)](#copying-git-notes-during-rewriting-activity-eg-rebase)
  - [Removing Git Notes support from a repository](#removing-git-notes-support-from-a-repository)
- [Configuration best practices](#configuration-best-practices)

---

## Enabling Notes features in SmartGit on a repository

In order for SmartGit notes to be enabled, SmartGit needs to find either:

- The presence of `refs/notes/commits`, which is the default Git notes category ref (e.g. as created by a `git notes add -m '..'` command).
- One or more `[smartgit-notes]` subsections defined in the Git configuration.

If `refs/notes/commits` is found, SmartGit automatically creates an implicit notes category called **"Notes"** that tracks `refs/notes/commits`.

## A minimal [smartgit-notes] configuration

Add one or more subsections under `smartgit-notes` to describe the *categories* of notes you want SmartGit to show:

```ini
[smartgit-notes "<category-id>"]
    # all keys are optional – see reference below
    ref              = <notes-ref>
    graphMessageRegex= <regex>
    color            = <RRGGBB>
```

SmartGit reads these directives from the repository's local `.git/config`, the user-wide `~/.gitconfig`, or the system config -- and reloads changes automatically for the local repo.
A restart is only needed when you edit user or system-wide configs.

## `smartgit-notes` section reference

Each notes category configured in SmartGit requires the following configuration:

- A `[smartgit-notes "<category-id>"]` configuration section, where `<category-id>` is the user-friendly name for the category which will appear in the SmartGit UI.
- One or more of the below keys, customizing the appearance in SmartGit

| Key | Required | Purpose |
|-----|----------|---------|
| **`ref`** | no (defaults to the `<category-id>` of the containing `[smartgit-notes]` section) | Path **relative to `refs/notes/`** that stores the notes for this category. You may also specify the full ref (`refs/notes/xyz`); the leading prefix will be stripped automatically. |
| **`graphMessageRegex`** | no | Java regular expression; must contain exactly one [capturing matching group](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Regular_expressions/Capturing_group) i.e. `(x)`; if present, SmartGit shows the extracted text instead of the generic notes icon. |
| **`color`** | no | Hex RGB triplet (e.g. `FFCC00`), rendered in the log graph for this category. The value is parsed as a 24-bit integer, so **omit the leading `#`**. |

---

## Example configurations

### 1 -- Override Classic *commits* notes

The name and colour of the default `commits` ref category can be overridden in the SmartGit UI by adding a `smartgit-notes` section for the default `ref = commits` category.

```ini
[smartgit-notes "Personal Notes"]
    # same as the default, but defined explicitly
    ref              = commits
    color = 5DADEC   # light-blue in the graph
```

### 2 -- Separate *code-reviews* category with filtering

```ini
[smartgit-notes "reviews"]
    ref               = code-reviews        # stored at refs/notes/code-reviews
    color             = FF8800              # orange
```

### 3 -- Multiple categories side-by-side

```ini
[smartgit-notes "qa"]
    ref               = qa                  # refs/notes/qa
    graphMessageRegex = ^State: (.*)        # extract review state (e.g. \"Pass\" or \"Fail\") directly to graph
    color             = 66CC66              # green

[smartgit-notes "design"]
    ref   = ux-design   # refs/notes/ux-design
    color = CC66CC      # purple
```

---

## Advanced Configurations

### Configuring automatic note synchronization with remotes

By amending the configuration for a remote's `fetch` and `push` settings, it is possible to ensure notes remain synchronized with the remote whenever a push or fetch is performed.

```ini
[remote "origin"]
  url = ...
  ...
  fetch = refs/notes/*:refs/notes/*
  push = refs/notes/*:refs/notes/*
```

Using the _<category>_ name, or the `*` wildcard to specify which categories of note are to be synchronized.

### Copying Git notes during rewriting activity (e.g. rebase)
As notes are attached to specific commit ids, any time the commit history is rewritten, e.g. to squash or other rebase activity,
any notes attached to rewritten commits will become orphaned from the resulting commit.

This orphan note behavior can be changed by adding a _rewriteRef_ configuration for the repository, e.g.:

```ini
[notes]
  rewriteRef = refs/notes/*
```

Will cause any notes on rewritten commits to be copied to the rewritten commit after a rebase.
If there is more than one note in the same category to be copied to the rewritten commit, the contents of the notes will be appended in sequence and attached to the new commit.

### Removing Git Notes support from a repository
Deleting all git notes in a category from a repository does not by itself remove the `refs/notes/<category>` ref from the repository.
As a result, SmartGit will still enable git notes functionality if the `refs/notes/commits` ref is still present in the repository, even if no notes are present.

To completely remove notes support, run the following `git update-ref -d` command in the repo, e.g. to remove the default `commits` category:

`git update-ref -d refs/notes/commits`

---

## Configuration best practices

1. **Global vs. local** -- You can keep common categories (e.g. *commits*) in `~/.gitconfig` but declare project-specific ones in each repo's `.git/config`.
2. **Ref naming** -- Use short, descriptive subsection names; if you omit `ref`, SmartGit will fall back to that name, keeping your config concise.
3. **Color palette** -- Pick sufficiently different colours so each category is recognisable in the log graph.
4. **Regular expressions** -- Keep `graphMessageRegex` simple and anchored (`^...`) to avoid accidental matches that hide or show unexpected commits.

With these settings in place you can toggle the notes display in SmartGit's **Log** and **Standard** windows and enjoy a colour-coded, filtered view of your notes alongside normal commit data.

