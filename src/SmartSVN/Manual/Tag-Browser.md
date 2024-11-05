# Tag Browser

Use **Tag+Branch\|Tag Browser** to display all tags and branches of your
project in a hierarchical structure. The hierarchy denotes which
tags/branches have been derived (i.e. copied) from other branches.

**Tags** and **Branches** display the tags or branches location as
specified with the [Configure Layout](Configure-Layout.md#ConfigureLayout-commands.configure-layout)
command. The subsequent table will contain tags and branches found
herein. A tag or branch has a **Name**, a **Revision** at which it had
been created and optionally a **Removed At** revision at which it had
been removed.

The tag browser is built upon information from the [Log Cache](Log-Cache.md#LogCache-log-cache) . With **Refresh** you
can refresh the cache and rebuild the tag/branch-structure.

Tags/branches can be deleted by **Remove** which will remove the
corresponding directory from the repository.

From the **Options**-button you can select to show both **Branches and
Tags**, **Branches only** or **Tags only**. **Recursive View** specifies
whether the table shall also display tags/branches which have been
*indirectly* derived from the currently selected branch in the tree.
Select **Removed Tags and Branches** to also display tags/branches which
have been deleted within the Repository. The corresponding items will
contain a red minus within their icon to denote the deletion.

The **Branch** drop-down button allows to sort the branches either **by
Name** or **by Revision**.


#### Tip
>
>
>You can invoke the Tag Browser also from tag or branch name input fields
>by clicking the ellipsis button to the right (**...**) or using
>*\<Ctrl>+\<Space>*-keystroke.
>
>
