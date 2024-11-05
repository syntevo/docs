# Mark Replaced

Use **Modify\|Mark Replaced** to mark modified files or a directory as
*replaced*, see [Common Primary File States](Directory-Tree-and-File-Table.md#common-primary-file-states)
for details.

Marking modified files or a directory as *replaced* does not affect the
contents of the files or directories, but only the meaning of the commit
and the history of the directory/files. This can be useful to express
that the content of a directory/files is not related to its previous
revision. The [Log](Log.md) of such a directory/files will not go beyond
the replacement revision, meaning that the directory/files has been
created at that revision.



#### Example
>
>
>
>For example, we have a Java interface `Person.java` and one implementing
>class `PersonImpl.java`. As the result of a refactoring, we are getting
>rid of the interface `Person.java` and rename the class
>`PersonImpl.java` to `Person.java`. This results in a *removed* file
>`PersonImpl.java` and a *modified* file `Person.java`.
>
>When simply committing these changes, this would mean that the class
>`PersonImpl.java` has been removed and the interface `Person.java` has
>been changed to a class `Person.java`, with no history except of that
>one of the interface.
>
>Taking a closer look at this situation, it would be better to do a
>commit meaning that the interface `Person.java` has been removed and the
>class `PersonImpl.java` has been renamed to `Person.java`. At least that
>was the intention of our refactoring and it would also mean to preserve
>the history of `PersonImpl.java` for `Person.java`.
>
>To achieve this, we will use **Mark Replaced** on `Person.java` and then
>we will use **Move** on `Person.java` and `PersonImpl.java`, performing
>a 'post-move' between both files (for details refer to
>[Move](Move.md#Move-commands.move)), yielding a *removed*
>`PersonImpl.java` and a *replaced* `Person.java`, which has its history
>(**Copy From**) set to `PersonImpl.java`.
>
>
