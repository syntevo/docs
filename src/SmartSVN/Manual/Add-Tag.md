# Add Tag

Use **Tag+Branch\|Add Tag** to create a copy ('Tag') of your local
working-copy in the `tags` directory of your repository. **Name** will
be the name of the tag and **Location** shows the corresponding
location. You can create two kinds of tags:

-   **Working Copy** tags are a snapshot of your current working copy.
    This means that the base revision of the tag will be the revision of
    the tag root directory.  
    -   If the working copy contains local changes, SmartSVN will ask
        you whether to tag **With local changes** or tag **Only
        Pristine**.
        -   When selecting **With local changes**, SmartSVN will (1)
            include local changes of your working copy and (2) for every
            file tag the exact revision as it is present in the working
            copy. This especially means that the tag may contain mixed
            revision.
        -   When selecting **Only Pristine** neither local changes nor
            mixed revisions will be included for the tag. This means
            that if your tag root directory is at revision *X* and a
            file is at revision *Y*, SmartSVN will nevertheless tag the
            file as it is present in revision *X*.
    -   If the working copy does not contain local changes, SmartSVN
        will for every file tag the exact revision as it is present in
        the working copy. This especially means that the tag may contain
        mixed revision. If there are actually mixed revisions, SmartSVN
        will warn you before creating the tag.
-   **Repository Revision** tags are 'server-side' tags which represent
    a snapshot of the repository at a given revision.


#### Tip
>
>
>**Repository Revision** tags can be useful if your working copy contains
>local changes but you don't want them to be part of the tag. However, in
>this case you should make sure that your working copy actually
>corresponds to the revision which you plan to tag, i.e. you should do an
>[update](Update.md#Update-commands.update) to that revision
>beforehand and make sure that there are no switched directories.
>
>

By default, SmartSVN will **Abort** if the specified tag already exists.
Select **Replace existing one** to create the tag anyway, replacing the
already existing tag.

Use **Externals Revisions** to specify how to handle [externals revisions](Externals.md#Externals-commands.externals) . For
details refer to [Copy To Repository](Copy-To-Repository.md#CopyToRepository-commands.copy-wc-url).


#### Note
>
>
>This command is similar to **Modify\|Copy Local to Repository** (see
>[Copy To Repository](Copy-To-Repository.md#CopyToRepository-commands.copy-wc-url)),
>but is tailored to the special case of 'Tagging'.
>
>
