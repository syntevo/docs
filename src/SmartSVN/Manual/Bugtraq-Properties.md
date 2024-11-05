# Bugtraq-Properties

Use **Properties\|Bugtraq-Properties** to configure the
*Bugtraq-Properties* for the current working copy. Bugtraq-Properties
are a technique for integrating Subversion with issue tracking systems.

A detailed specification for the *Bugtraq-Properties* can be found at:
<http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/doc/issuetrackers.txt>,
username is `guest` with empty password. SmartSVN implements this
specification with the following mapping from UI elements to core
`bugtraq:`-properties as shown in [Mapping from core bugtraq:properties to SmartSVN UI elements](#mapping-from-core-bugtraqproperties-to-smartsvn-ui-elements).



#### Example
>
>
>
>Let's assume your commit messages look like this:
>`SU-12345: Some message`, your issue tracker **URL** is set to
>[`https://host/browse/SU-%BUGID%`](https://host/browse/SU-%BUGID%) and
>**Bug-ID** is set to **Numeric**:
>
>-   If you want `SU-12345` to be rendered as link and the link point to
>    [`https://host/browse/SU-12345,`](https://host/browse/SU-%BUGID%)
>    set **Bug-ID Expression** to `SU-(\d+)` and **Message-Part Expr.**
>    to `SU-(\d+)`.
>-   If you want just `12345` to be rendered as link and the link point
>    to [`https://host/browse/SU-12345,`](https://host/browse/SU-%BUGID%)
>    set **Bug-ID Expression** to `(\d+)` and **Message-Part Expr.**
>    to `SU-(\d+)`.
>-   If you want `SU-12345` to be rendered as link and the link point to
>    [`https://host/browse/SU-SU-12345,`](https://host/browse/SU-%BUGID%)
>    set **Bug-ID Expression** to `SU-(\d+)` and leave **Message-Part
>    Expr.** empty.
>
>



#### Example
>
>
>
>Assuming your commit messages look like this: `Ticket: 5 Some message`
>or `ticket #5: Some message` and you want the `5` to be rendered as a
>link to your issue tracker. In this case, set **Bug-ID Expression** to
>`[Tt]icket:? #?(\d+)` and leave **Message-Part Expr.** empty.
>
>If you want the whole `Ticket #5` part show up as a link, use the same
>**Bug-ID expression** and also set **Message-Part Expr.** to this value.
>
>



#### Example
>
>
>
>Let's say your commit messages look like this: `CF-11: Some message`, or
>`ET-12: Some message`. Then, if you want the `11` and `12` to show up as
>links to your issue tracker, set **Bug-ID Expression** to `\d+` and the
>**Message-Part Expr.** to `(CF|ET)-(\d+)`.
>
>If you want the whole `CF-11` or `ET-12` part to show up as a link, set
>**Bug-ID expression** to `(CF-\d+|ET-\d+)` and leave **Message-Part
>Expr.** empty.
>
>

## Mapping from core bugtraq:properties to SmartSVN UI elements


|                         |                                                                                                                                                                                                                                                     |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `bugtraq:url`           | **URL**                                                                                                                                                                                                                                             |
| `bugtraq:warnifnoissue` | **Remind me to enter a Bug-ID**                                                                                                                                                                                                                     |
| `bugtraq:label`         | **Message Label**                                                                                                                                                                                                                                   |
| `bugtraq:message`       | **Message Pattern**                                                                                                                                                                                                                                 |
| `bugtraq:number`        | is `true` exactly if **Bug-ID is** set to **Numeric**                                                                                                                                                                                               |
| `bugtraq:append`        | is `true` exactly if **Append message to** set to **Top**                                                                                                                                                                                           |
| `bugtraq:logregex`      | For the version with one regular expression this corresponds to **Bug-ID Expression**. For the version with two regular expressions, **Message-Part Expr.** corresponds to the first line and **Bug-ID expression** corresponds to the second line. |

