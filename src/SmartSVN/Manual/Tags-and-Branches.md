# Tags and Branches

SmartSVN simplifies the handling of 'Tags' and 'Branches'. Both 'Tags'
and 'Branches' are no native SVN concepts, but can easily be handled by
the help of [Copy To Repository](Copy-To-Repository.md#CopyToRepository-commands.copy-wc-url)
and [Copy Within Repository](Copy-Within-Repository.md#CopyWithinRepository-commands.copy-url-url).
SmartSVN provides special support for managing tags and branches, which
are based upon these copy commands.

Commands related to the management of tags and branches are available
from the **Tag+Branch** menu. Various other commands support tags and
branches alternatively for entering raw URLs.

# Layout

The *Tag-Branch-Layout* defines the project's root URL (within the
repository) and where the *trunk*, *tags* and *branches* of the project
are stored. It affects the presentation of and the working with URLs for
various commands. When invoking a tag/branch-aware command on a
directory for which no layout can be found, SmartSVN will prompt you to
configure a corresponding layout in the **Configure Tag-Branch-Layout**
dialog.


A Tag-Branch-Layout is always linked with a corresponding **Project
Root**. A **Project Root** is simply the URL of the top-most directory
of a *project*. Any directory can be defined as a *project root* as the
definition of what a *project* is, is completely up to you.

The first decision for a **Project Root** is whether to enable or
disable Tag-Branch-Layouts for it. Many SVN projects are organized using
tags and branches. In this case choose **Use the following layout** to
configure the layout. If the corresponding project is not organized by
tags and branches, choose **Do not work with tags and branches for this
project root** to switch Tag-Branch-Layouts off.

**Trunk** specifies the root directory of the project's trunk.
**Branches** and **Tags** specify the directory patterns of the branch
and tag root directories, respectively. All paths are relative to the
**Project Root**. Enter the values `trunk`, `branches/*` and `tags/*`
here if you want to use the recommended SVN standard layout.

#### Example
>
>The Subversion project itself is located at
><http://svn.collab.net/repos/svn/>. Hence for the corresponding SmartSVN
>project, **Project Root** must be set to
>`http://svn.collab.net/repos/svn/`. Subversion's Trunk URL is
><http://svn.collab.net/repos/svn/trunk>, i.e. `trunk` is the relative
>path and must be set for **Trunk**. Branches are located in
><http://svn.collab.net/repos/svn/branches>, e.g.
>`http://svn.collab.net/repos/svn/branches/1.5.x` is the root of the
>'1.5.x' branch. I.e. **Branches** must be set to `branches/*`. This is
>similar for **Tags**.
>
>It's also possible to use multiple branch or tag patterns. In this case,
>when entering, for example, a branch, you have to specify not only the
>branch name, but the relative path to the common root of all branches.
>
>**Example**
>
>A project may also contain *shelves* which can be interpreted as
>'personal branches '. For instance, the **Project Root** is located at
>`svn://server/svn/proj`. The 'normal' branches are located in
>`svn://server/svn/proj/branches` and the shelves are located in
>`svn://server/svn/proj/shelves/[username]`, e.g.
>`svn://server/svn/proj/shelves/bob/my-shelve`. Hence, for **Branches**
>the following patterns should be used: `branches/*, shelves/*/*`.
>
>Now, when e.g. creating a branch 'b1' with **Tag+Branch\|Add Branch**,
>you have to enter `branches/b1`, so SmartSVN knows that the branch
>should be created in the `branches` directory.
>
>For example, when switching to Bob's 'my-shelve' with
>**Modify\|Switch**, you have to enter `shelves/bob/my-shelve`, so
>SmartSVN knows that it should switch to a branch within the
>`shelves/bob` directory.
>
>SmartSVN uses the proposed standard layout for new projects. If you want
>to configure another default layout, open one project which contains the
>desired layout, select **Tag+Branch\|Configure Layout** and use **Make
>this configuration the default** here.
>
