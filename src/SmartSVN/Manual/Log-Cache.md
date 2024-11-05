# Log Cache

The Log Cache is the local data storage for the *Transactions*. It is
also used by other SmartSVN commands, for instance the [Log](Log.md). It
stores and supplies the raw log information as received from the server
and can supply them to various commands later on. This can increase log
performance significantly and also leads to reduced network traffic.

When *Log* information is requested for the first time for a certain
repository, you can choose which parts of the repository should be
indexed by the Log Cache. In general it is recommended to select
**Create cache for whole repository at** to let SmartSVN index the whole
repository. The reason for this is that logs of a certain 'module' can
have links to other modules, due to the way Subversion's *Copy*
mechanism works. Sometimes repositories can be very large and you may be
interested only in a few modules of the whole repository. In this case
it may be more efficient to select **Create cache only for module at**
and select the corresponding module. However, this can lead to
incomplete logs due to the reasons stated above. For some repositories
you might want to use create no Log Cache at all. In this case choose
**Skip cache and perform logs directly**.

SmartSVN automatically keeps the Log Cache(s) up-to-date. All
log-related commands always query the repository for the latest logs,
before querying the Log Cache. In the same way, every manually or
automatically triggered refresh of the Transactions will update the
corresponding caches.

Log results (for instance used by the Log command) from the Log Cache
are in general identical to results obtained when querying the server
directly. However there can be differences for following situations:

-   Server-side access restrictions on already cached revisions are
    changed afterwards. This happens for instance, when using and
    modifying *AuthzSVNAccessFile* for *HTTP* repositories.
-   Log information for already cached revisions are changed on the
    server afterwards. This happens for instance when changing the
    repository's database directly or by changing *revision properties*,
    e.g. when another user has performed [Change Commit Message](Log.md#modify-menu).

In such cases, you should rebuild the Log Cache as described in [Manage Log Caches](#manage-log-caches).

## Manage Log Caches

In the [Project Window](Project-Window.md#ProjectWindow-project-window) use
**Project\|Manage Log Caches** to manage the local Log Caches.

The list shows all known **Root URLs** and the corresponding **Log
Type**. For **Log Type** set to **Local Log Cache** there exists a local
Log Cache for the **Root URL** against which logs will be performed.
Otherwise, for **Direct Logs onto Repository**, the logs will be
performed directly against the repository.

Log Caches are created on demand for a new **Root URL** and the choice
whether to use a **Local Log Cache** or **Direct Logs onto Repository**
has to be done when a log is first requested for that URL. This choice
will be remembered and typically doesn't need to be changed afterwards.
If necessary anway, you can use **Delete** for the corresponding **Root
URL**. This will discard the **Log Type** choice and get rid of the Log
Cache in case of **Local Log Cache** choice. Hence, subsequent log
requests for this URL (or child URLs) will bring the Log Cache
initialization dialog again.

Select **Rebuild** for a **Local Log Cache** to rebuild it from
repository log information. In general it's recommended to rebuild
caches completely by selecting **All** unless you know that only log
information **Starting with** a certain revision had been changed.

## Storage

The Log Cache information is stored in the subdirectory `log-cache` in
SmartSVN's settings directory. For every Log Cache, there is a separate
subdirectory containing the server name and repository path. This is
typically sufficient to quickly locate the cache for a specific
repository. In case there are multiple subdirectories with the same
name, only differing and the trailing number, you can have a look at the
contained `urls` files. They show the exact location for which the Log
Cache has been built.

If you encounter problems when rebuilding the cache, or if you need to
get rid of the cached information for a certain repository, you can
remove the corresponding subdirectory. Alternatively, you can remove the
whole `log-cache` in order to get rid of all cached log information. You
should never change these files while SmartSVN is running, otherwise the
results will be unpredictable.
