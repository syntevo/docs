# Manipulating branches/tags

## Adding, Renaming and Deleting Branches and Tags

You can add, rename and delete branches and tags both from the main
window and from the [Log](Log.md) window.

### Working Tree window

The **Branches** view on the working tree window has various context menu
entries for adding, renaming and deleting selected branches and tags.
These commands can also be invoked via the entries in the **Branch**
menu.

Use **Branch \| Add Tag** or **Branch \| Add Branch** to create a tag or
branch at the current HEAD.


#### Info
> To sign an (annotated) tag, you need to have the GPG program and key
> configured in the  [repository settings](Repository-Settings.md).



### Log Window

On the Log window, you can add a branch or tag on a commit by selecting
the commit in the Log graph and invoking **Add Branch** or **Add Tag**
in the commit's context menu. Similarly, you can delete a branch or tag
by selecting the commit to which the branch or tag pointer is attached
and invoking **Delete** in the commit's context menu.

Via the context menu of the Log window's **Branches** view, you can add
and delete branches and tags as well. In addition to that, the
**Branches** view also allows you to rename branches.

 
