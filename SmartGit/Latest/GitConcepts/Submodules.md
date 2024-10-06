# Git Submodules

Often, software projects within your organization are not entirely self-contained, but share
common components with other software projects. Git offers a *submodules* feature that allows you to embed one Git repository into another.

Submodules are especially useful when your organization does not use a Package Management server (such as Maven, npm, or NuGet) 
but requires dependency projects to be embedded or rebuilt within your solutions.

A submodule is a nested repository embedded in a dedicated subdirectory of the working tree (that belongs to the parent
repository). A submodule always references a specific commit of the embedded repository. The definition of the submodule is stored as a
separate entry in the parent repository's git object database.

The link between the working tree entry and the foreign repository is stored in
the `.gitmodules` file of the parent repository. The `.gitmodules` file is usually versioned so that it can be maintained and/or changes are propagated to all users.

Setting submodule repositories involves an initialization process, in
which the required entries are added to the `.git/config` file. The user
may later adjust it, for example to fix SSH login names.

Refer to [Submodules in SmartGit](../GUI/Submodules.md) to see how to work with Submodules inside SmartGit.
