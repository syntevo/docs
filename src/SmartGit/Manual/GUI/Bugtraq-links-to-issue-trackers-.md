# Bugtraq (links to issue trackers)

Git Bugtraq is a [de-facto standard](https://github.com/mstrap/bugtraq) configuration file added into your Git Repository, enabling integration between tools such as SmartGit and common web-based Bug Tracking tools such as JIRA, GitHub Issues, or Azure DevOps boards.

If you have set up *Bugtraq Configuration* for your repository, SmartGit will detect issue IDs embedded in commit messages and display hyperlinks allowing you to quickly open the linked issue Id in the Bug tracking tool's website.

The Bugtraq configuration is stored either in the `.gitbugtraq` file in your repository root (for all users of the repository) or in your repositories' `.git/config` (just for you).

The configuration file consists of a named `bugtraq` section, where a regular expression can be defined to match issue IDs in your commit messages, and a URL template used to create the clickable hyperlink to the specific linked Issue id in the website.

In most web issue tracking tools, you can determine the url template by clicking on an issue, and then copying the resultant URL from the browser address bar.
You can then substitute the specific issue id with the `%BUGID%` token as per the below examples.
For more details refer to the complete Bugtraq specification at <https://github.com/mstrap/bugtraq>.

#### Note
> The `logregex` must contain only one matching group '()' matching the issue ID.
> You can use additional non-matching groups '(?:)' for other parts of your regex (or '(?i)' for case insensitive matching).

## Examples

#### JIRA - repository linked to a single JIRA project
> An example configuration for the *JIRA* issue tracker at URL
> `https://host/jira` for a project called 'SG' looks like the following.
>
>``` text
> [bugtraq "jira"]
>   url = https://host/jira/browse/SG-%BUGID%
>   logregex = SG-(\\d+)                   
>```

The above example will make only the issue numbers as links (i.e. without `SG-`).
Alternatively, if you want to have the entire issue ID as the link (i.e. with `SG-`), you may use:

>``` text
> [bugtraq "jira"]
>   url = https://host/jira/browse/%BUGID%
>   loglinkregex = SG-\\d+
>   logregex = \\d+            
>```

#### JIRA - repository linked to a multiple JIRA projects

When your repository is linked to multiple *JIRA* projects, a configuration could look like:

>
>``` text
> [bugtraq "jira"]
>   projects = PRJA, PRJB
>   url = https://host/jira/browse/%PROJECT%-%BUGID%
>   loglinkregex = %PROJECT%-\\d+
>   logregex = \\d+            
>```

So a commit message containing `PRJA-123` would be linked to `https://host/jira/browse/PRJA-123`, 
and a commit message and containing `PRJB-678` would be linked to `https://host/jira/browse/PRJB-678`.

#### Matching #ids (i.e. hash prefix) at the beginning of the commit message

Another example configuration (e.g. for a trouble ticketing system) where IDs like '#213' should be matched only at the beginning of a commit message.
Note that the `logregex` needs to be put in quotes, because '#' serves as a comment character in Git configuration files.
>
>``` text
> [bugtraq "otrs"]
>   url = "https://otrs/index.pl?Action=AgentTicketZoom;TicketID=%BUGID%"
>   logregex = "^#[0-9]{1,5}"            
>```

#### GitHub.com issues

GitHub uses numeric-only identifiers. Substitute `myorg` and `myproject` for your organisation / user and project identifiers - these should be visible on the address bar when viewing your GitHub issues.

>
>``` text
> [bugtraq "GitHub Issues"]
>   url = "https://github.com/myorg/myproject/issues/%BUGID%"
>   logregex = \\d+
>```
>

#### Azure DevOps boards Workitems

For Azure DevOps (cloud), substitute `myorg` and `myproject` for your (Url Encoded) organisation and project identifiers - these should be visible on the address bar when viewing your Azure Boards work items.

>
>``` text
> [bugtraq "AzDevOps Issues"]
>   url = "https://dev.azure.com/myorg/myproject/_workitems/edit/%BUGID%"
>   logregex = \\d+
>```
>

