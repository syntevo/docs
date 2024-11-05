# Locks

Since Subversion 1.2, explicit file locking is supported. File locking
is especially useful when working with binary files, for which merging
is not possible.

For each file, its lock state is displayed in the file table column
**Lock** and additionally the **Name** icon can contain corresponding
overlay icons, as shown in [Additional File States](Directory-Tree-and-File-Table.md#additional-file-states).
For a list of possible lock states, refer to [Lock States](#lock-states).

The 'Self' state can be filled in by SmartSVN when scanning the local
working copy. Please note that this state can change when scanning the
repository (see [Refresh](#refresh)), as the lock
might actually be 'Stolen' or 'Broken'.

## Lock States


|            |                                                                                                                                |
|------------|--------------------------------------------------------------------------------------------------------------------------------|
| (Empty)    | The file is not locked.                                                                                                        |
| Self       | The file is locked for the local working copy.                                                                                 |
| Stolen     | The file was locked for the local working copy but in the meanwhile it has been stolen by someone else in the repository.      |
| Broken     | The file was locked for the local working copy, but in the meanwhile it has been unlocked (by someone else) in the repository. |
| (Username) | The file is currently locked by the named user.                                                                                |


## Refresh

With **Locks\|Refresh** SmartSVN will scan the selected files or all
files within the selected directory in the repository for locks. The
result is displayed in the file table column **Lock**. This column is
automatically made visible, if necessary.

You can combine scanning the repository for locks with refreshing the
[Remote State](Remote-State.md#RemoteState-commands.remote-state) in
the [Preferences](Preferences.md). You can also schedule a repeated refresh
of the repository lock information in the [Project Settings](Project-Settings.md#locks)
.

## Lock

With **Locks\|Lock** you can lock the selected files in the repository.
You can enter a **Comment** to explain why you are locking these files.

The option **Steal locks if necessary** will lock the requested files
regardless of their current lock state (in the repository). With this
option it may happen that you 'steal' the lock from another user, which
can lead to confusion when the other user continues working on the
locked file. Hence you should use this option only if necessary (e.g. if
someone is on holiday and has forgotten to unlock important files).

Keep **Update to HEAD before** selected to perform an update to HEAD.
Only the latest revision of a file can be locked.

## Unlock

With **Locks\|Unlock** you can unlock the selected files, or all files
within the selected directory (recursively) in the repository.

The option **Break locks** will unlock the requested files even if they
are not locked locally. With this option it may happen that you 'break'
the lock of another users, which can lead to confusion if that other
user is still working on the locked file.

## Show Info

**Locks\|Show Info** shows information on the lock state (in repository)
of the selected file.

**State** shows the current lock state (see [Lock States](#lock-states)). **Token ID** is the SVN Lock Token ID,
which is normally not relevant for the user. **Owner** is the name of
the user who currently owns the lock. **Created At** is the time when
the lock has been set. **Expires At** is the time when the lock will
expire. **Needs Lock** indicates whether this file needs locking, i.e.
the 'Needs Lock ' property has been set (see [Change 'Needs Lock'](#change-needs-lock)). **Comment** is the lock
comment, as entered by the user at the time of locking.

## Change 'Needs Lock'

With **Locks\|Change 'Needs Lock'** files can be marked/unmarked to
require locking. This is useful to indicate to users that they should
lock the file before working with it. One aspect of this indication is
that SmartSVN will set files which require locking (due to this
property) to read-only when checking out or updating.
