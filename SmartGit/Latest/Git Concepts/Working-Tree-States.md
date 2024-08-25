# Working Tree States

There are some particular situations where commits cannot be performed,
for instance when a merge has failed due to a conflict. In this case,
there are two ways to finish the merge: Either by resolving the
conflict, staging the file changes and performing the commit on the
working tree root, or by reverting the whole working tree.
