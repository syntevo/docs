# Git-Notes Integration *(experimental in 25.1)*

This document explains how to enable **SmartGit’s Git-Notes features** through ordinary Git configuration files.

---

## Contents
- [Minimal setup](#minimal-setup)
- [`smartgit-notes` section](#smartgit-notes-section)
  - [Keys](#keys)
  - [Colour format](#colour-format)
- [Default behaviour when no section is present](#default-behaviour)
- [Example configurations](#example-configurations)
- [Configuration best practices](#configuration-best-practices)

---

## Minimal setup

Add one or more subsections under `smartgit-notes` to describe the *categories* of notes you want SmartGit to show:

```ini
[smartgit-notes "<category-id>"]
    # all keys are optional – see below
    ref              = <notes-ref>
    graphMessageRegex= <regex>
    color            = <RRGGBB>
```

SmartGit reads these directives from the repository’s local `.git/config`, the user-wide `~/.gitconfig`, or the system config – and reloads changes automatically for the local repo. A restart is only needed when you edit user or system-wide configs.

---

## `smartgit-notes` section

### Keys

| Key | Required | Purpose |
|-----|----------|---------|
| **`ref`** | no (defaults to the subsection’s name) | Path **relative to `refs/notes/`** that stores the notes for this category. You may also specify the full ref (`refs/notes/xyz`); the leading prefix will be stripped automatically. |
| **`graphMessageRegex`** | no | Java regular expression; if present, SmartGit shows the extracted text instead of the generic notes icon. |
| **`color`** | no | Hex RGB triplet (e.g. `FFCC00`), rendered in the log graph for this category. The value is parsed as a 24-bit integer, so **omit the leading `#`**. |

#### Colour format

The value is interpreted as hexadecimal *RRGGBB* and converted to a 24-bit integer (e.g. `FF0000` → red) — anything else will be ignored.

---

## Default behaviour

When *no* `[smartgit-notes]` subsection is configured, SmartGit still tries to be helpful: if it finds a commit on `refs/notes/commits`, it automatically creates an implicit category called **“Notes”** that tracks `refs/notes/commits`. If that ref does not exist, the Git-Notes feature remains disabled.

---

## Example configurations

### 1 – Classic *commits* notes (explicit)

```ini
[smartgit-notes "commits"]
    # same as the default, but defined explicitly
    color = 5DADEC   # light-blue in the graph
```

### 2 – Separate *code-reviews* category with filtering

```ini
[smartgit-notes "reviews"]
    ref               = code-reviews        # stored at refs/notes/code-reviews
    graphMessageRegex = ^Review[ed]?:        # show only when the commit
                                             # message starts with “Review:”
    color             = FF8800              # orange
```

### 3 – Multiple categories side-by-side

```ini
[smartgit-notes "qa"]
    ref   = qa          # refs/notes/qa
    color = 66CC66      # green

[smartgit-notes "design"]
    ref   = ux-design   # refs/notes/ux-design
    color = CC66CC      # purple
```

---

## Configuration best practices

1. **Global vs. local** – You can keep common categories (e.g. *commits*) in `~/.gitconfig` but declare project-specific ones in each repo’s `.git/config`.
2. **Ref naming** – Use short, descriptive subsection names; if you omit `ref`, SmartGit will fall back to that name, keeping your config concise.
3. **Colour palette** – Pick sufficiently different colours so each category is recognisable in the log graph.
4. **Regular expressions** – Keep `graphMessageRegex` simple and anchored (`^…`) to avoid accidental matches that hide or show unexpected commits.

With these settings in place you can toggle Git-Notes columns in SmartGit’s **Log Window** and enjoy a colour-coded, filtered view of your notes alongside normal commit data.

---

LLP:
- log.graph.draw.iconNotes -> for users
- gitnotes.showInvisibleNotes -> probably just for testing
- gitnotes.allowRemovingAllNotes -> definitely just for testing