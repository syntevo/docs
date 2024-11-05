# Externals

Use **Properties\|Externals** to define or change externals. An
*external* (officially also referred to as *externals definition*) is a
mapping of a **Local Path** to an **URL** (and possibly a particular
**Revision**) of a versioned resource.

In general, externals are specified by complete URLs, but there are also
shorter representations which can be more flexible. The **URL** input
field allows to switch between the available representations for a given
URL. For a detailed description of externals and valid URL formats,
refer to
<http://svnbook.red-bean.com/nightly/en/svn.advanced.externals.html>.



#### Example
>
>
>
>To include the external `http://server/svn/foo` as directory `bar/bazz`
>at revision 4711 into your project, select directory `bar` and invoke
>**Properties\|Externals**. Click **Add**, enter `bazz` into the **Local
>Path** input field, `http://server/svn/foo` into the **URL** input
>field, `4711` to the **Revision** input field and confirm by **OK**:
>After committing your property change, an update on `bar` will create
>the subdirectory `bar/bazz` with the content from
>`http://server/svn/foo` at revision 4711.
>
>


#### Tip
>
>
>It is safer to always set a **Revision** to externals. In this way you
>can always be sure about which version you are actually working with.
>When you decide to use a more recent revision of the external, you can
>evaluate it beforehand and, if you are satisfied, increase the
>**Revision** number of the external definition.
>
>


#### Note
>
>
>Externals may refer to directories as well as to files. In case of
>files, the referred URL must be part of the same repository to which its
>local parent directory belongs. (The local parent the directory is the
>directory to which the `svn:externals` property belongs.)
>
>
