---
redirect_from:
  - /SmartGit/Latest/Manipulating-branches-tags
  - /SmartGit/Latest/Manipulating-branches-tags.html
---

# Manipulating Branches and Tags

In Git, Branches and Tags provide human-readable pointers / references to specific commits in a repository. 
The key differentiation is that `Tags` will remain pointed to a specific commit, whereas `Branches` will move to point to the most recent HEAD commit when a new commit is added to a branch.

## Adding, Renaming and Deleting Branches and Tags

You can add, rename and delete branches and tags both from the main window and from the [Log](../Log.md) window.

### Working Tree window

The **Branches** view on the working tree window has various context menu entries for adding, renaming and deleting selected branches and tags.
These commands can also be invoked via the entries in the **Branch** menu.

Use **Branch \| Add Tag** or **Branch \| Add Branch** to create a tag or branch at the current HEAD.

### Log Window

On the Log window, you can add a branch or tag on a commit by selecting the commit in the Log graph and invoking **Add Branch** or **Add Tag**
in the commit's context menu. Similarly, you can delete a branch or tag by selecting the commit to which the branch or tag pointer is attached
and invoking **Delete** in the commit's context menu.

Via the context menu of the Log window's **Branches** view, you can add and delete branches and tags as well. In addition to that, the
**Branches** view also allows you to rename branches.
 
### Signing of Tags

Git uses SHA1 hashing, including embedding the parent commit(s) in each new commit.
This approach provides some guarantees of tamper-proofing of the commit tree (similar to [Merkle Trees](https://en.wikipedia.org/wiki/Merkle_tree)).

However, Git does not natively provide authentication guarantees of the authors of a commit.

A common solution is to digitally sign a tag on your commits to prove authenticity and authorship of your commits (especially in public / open source repositories).

To sign an (annotated) tag, you need to have a [GPG program](https://en.wikipedia.org/wiki/GNU_Privacy_Guard) and private key configured in the [repository settings](../Repository-Settings.md).
External parties can then verify your authoriship by sharing the public key or fingerprint with them.
