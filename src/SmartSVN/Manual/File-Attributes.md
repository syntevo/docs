# File Attributes

## File attributes with SVN counterparts


|               |                         |                                                                                                                                                                                                                                       |
|---------------|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Name          | (same)                  | File name                                                                                                                                                                                                                             |
| Revision      | (same)                  | Current revision of the file                                                                                                                                                                                                          |
| Local State   | Schedule                | Textual representation of the local state of the file                                                                                                                                                                                 |
| Lock          | Lock Owner              | Lock state of the file (see [Locks](Locks.md#Locks-commands.locks))                                                                                                                                                         |
| Last Rev.     | Last Changed Rev.       | Revision in which this file has been committed                                                                                                                                                                                        |
| Last Changed  | Last Changed Date       | Time of the last commit of the file                                                                                                                                                                                                   |
| Text Updated  | Text Last Updated       | Time of the last (local) update of the file's text; this attribute is set when the content of a file has been changed by an SVN command.                                                                                              |
| Props Updated | Properties Last Updated | Time of the last (local) update of the file's properties; this attribute is set when the properties of a file have been changed by an SVN command.                                                                                    |
| Last Author   | Last Changed Author     | Last author, i.e. who performed the last commit on the file                                                                                                                                                                           |
| Type          | svn:mime-type           | The file's type (see [MIME-Type](MIME-Type.md#MIME-Type-commands.mime-type))                                                                                                                                                |
| EOL           | svn:eol-style           | End-Of-Line Type of the file (see [EOL-Style](EOL-Style.md#EOL-Style-commands.eol-style))                                                                                                                                   |
| Keyw.         | svn:keywords            | Keyword substitution options of the file (see [Keyword Substitution](Keyword-Substitution.md#KeywordSubstitution-commands.keyword-substitution))                                                                            |
| Needs Lock    | svn:needs-lock          | Whether the file should be locked before working (see [Change 'Needs Lock'](Locks.md#change-needs-lock))                                                                                                     |
| Executable    | svn:executable          | Whether the file has the Executable-Property set (see [Executable-Property](Executable-Property.md#Executable-Property-commands.executable-property))                                                                       |
| Merge Info    | svn:mergeinfo           | Whether the file has the Merge Info-Property set (see [Merge Info](Merge-Info.md#MergeInfo-commands.mergeinfo)): **None** for no Merge Info set, **Empty** for an empty Merge Info or **Present** for non-empty Merge Info. |
| Copy From     | Copy From URL/Rev       | Location and URL from which this file has been copied (locally). This value is only present if the file is in *Copied* state                                                                                                          |


## File attributes without SVN counterparts


|                    |                                                                                                                                                                      |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Remote State       | Remote state of the file (see [Remote State](Remote-State.md#RemoteState-commands.remote-state))                                                           |
| Ext.               | The file's extension                                                                                                                                                 |
| Relative Directory | Parent directory of the file relative to the selected directory                                                                                                      |
| File Time          | The local time of the file                                                                                                                                           |
| Attrs.             | Local file attributes: *R* for read-only and *H* for hidden                                                                                                          |
| Size               | The local size of the file                                                                                                                                           |
| Branch             | The tag/branch to which the file is currently [switched](Switch.md#Switch-commands.switch). For details, refer to  [Tag-Branch-Layout](Tags-and-Branches.md). |
| Change Set         | The [Change Set](Change-Sets.md#ChangeSets-commands.changeset) to which the file belongs.                                                                  |



#### Tip
>
>
>Certain table columns require access to additional file system files
>when scanning the file system and therefore slow down scanning. The note
>within the **View\|Table Columns** dialog tells you which columns these
>are.
>
>
