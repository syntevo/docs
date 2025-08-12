# Bugtraq (links to issue trackers)

Git Bugtraq is a [de-facto standard](https://github.com/mstrap/bugtraq) configuration file added into your Git Repository, 
enabling integration between tools such as SmartGit and common web-based Bug Tracking tools such as Jira, GitHub Issues, or Azure DevOps boards.

If you have set up *Bugtraq Configuration* for your repository, SmartGit will detect issue IDs embedded in commit messages and display hyperlinks 
allowing you to quickly open the linked issue Id in the Bug tracking tool's website.

The Bugtraq configuration is stored either in the `.gitbugtraq` file in your repository root (for all users of the repository) or in your repositories' `.git/config` (just for you).

The configuration file consists of a named `bugtraq` section, where a regular expression can be defined to match issue IDs in your commit messages, 
and a URL template used to create the clickable hyperlink to the specific linked Issue id in the website.

Examples of common Bugtraq configurations for popular web issue tracking tools are provided below.
If your web-based issue tracking system is not listed, or if you have customized the Issue linking URLs on your tracking system,
you can determine the `url` template string by clicking on an issue, and then copying the resultant URL from the browser address bar.
Replace the specific issue identifier in the `url` template with a `%BUGID%` token, which SmartGit will use to insert the linked issue id.

For more advanced parsing requirements, Bugtraq supports a multi-step regex processing pipeline to extract the BUGID from commit messages:

``
commit message -> logfilterregex -> loglinkregex -> logregex -> BUGID
``

Please refer to the complete Bugtraq specification at <https://github.com/mstrap/bugtraq> for advanced configuration.

#### Note
> - The `logregex` setting must contain only one matching group '()' matching the issue ID.
> - You can use additional non-matching groups '(?:)' for other parts of your regex (or '(?i)' for case insensitive matching).
> - The [BugTraq `projects`](https://github.com/mstrap/bugtraq?tab=readme-ov-file#bugtraqprojects-optional) setting allows one or more project prefixes to be defined 
    which can then be substituted using a `PROJECT` token in the `url` and `loglinkregex` settings.

## Examples

### Jira Server (On Premise) - repository linked to a single Jira project

Jira uses project-specific prefixes for its issue identifiers.
An example configuration for a repository linked to a single Jira project with prefix `SG`, the *Jira* issue tracker at URL `https://host/jira` looks like the following.

>
>``` ini
> [bugtraq "jira"]
>   url = https://host/jira/browse/SG-%BUGID%
>   logregex = SG-(\\d+)                   
>```

The above example will make only the issue numbers as links (i.e. without `SG-`).
Alternatively, if you want to have the entire issue ID as the link (i.e. with `SG-`), you may use:

>``` ini
> [bugtraq "jira"]
>   url = https://host/jira/browse/%BUGID%
>   loglinkregex = SG-\\d+
>   logregex = \\d+            
>```

### Jira Server (On Premise) - repository linked to a multiple Jira projects

When your repository is linked to multiple *Jira* projects, the `projects` setting allows multiple project prefixes to be detected, e.g.:
>
>``` ini
> [bugtraq "jira"]
>   projects = PRJA, PRJB
>   url = https://host/jira/browse/%PROJECT%-%BUGID%
>   loglinkregex = %PROJECT%-\\d+
>   logregex = \\d+            
>```

So a commit message containing `PRJA-123` would be linked to `https://host/jira/browse/PRJA-123`, 
and a commit message and containing `PRJB-678` would be linked to `https://host/jira/browse/PRJB-678`.

### Jira Cloud

The Jira Cloud issue viewing URL is slightly different to the On-Premises version.

In the below example, we have a single project with prefix `SG` and have registered an organisation with a site name `myorg` on Jira Cloud. 
Here we have not set up a custom domain, so the host has its default of `myorg.atlassian.net`, and have used the `projects` setting to DRY up the Jira project prefix:

>
>``` ini
> [bugtraq "jira"]
>   projects = SG
>   url = https://myorg.atlassian.net/browse/%PROJECT%-%BUGID%
>   loglinkregex = %PROJECT%-\\d+
>   logregex = \\d+
>```

If you have registered a custom domain with Jira cloud, the host will change as per your network administrator's DNS entry.
For example, if we have created a subdomain `jira.myorg.com` in the `myorg.com` company DNS and configured the custom domain in Jira, the URL will be:

>
>``` ini
> [bugtraq "jira"]
>   projects = SG
>   url = https://jira.myorg.com/browse/%PROJECT%-%BUGID%
>   loglinkregex = %PROJECT%-\\d+
>   logregex = \\d+
>```

### GitHub.com issues

GitHub uses numeric-only identifiers on a per-project basis. Substitute `myorg` and `myproject` for your organisation / user and project identifiers - these should be visible on the address bar when viewing your GitHub issues.

e.g. for a repository linked to a single project `myproject` for company `myorg`:

>
>``` ini
> [bugtraq "GitHub Issues"]
>   url = "https://github.com/myorg/myproject/issues/%BUGID%"
>   logregex = \\d+
>```
>

### Azure DevOps boards Workitems

For Azure DevOps (cloud), substitute `myorg` and `myproject` for your (Url Encoded) organisation and project identifiers - these should be visible on the address bar when viewing your Azure Boards work items.

>
>``` ini
> [bugtraq "AzDevOps Issues"]
>   url = "https://dev.azure.com/myorg/myproject/_workitems/edit/%BUGID%"
>   logregex = \\d+
>```
>

### Matching #ids (i.e. hash prefix) at the beginning of the commit message

Another example configuration (e.g. for a trouble ticketing system) where IDs like '#213' should be matched only at the beginning of a commit message.
Note that the `logregex` value needs to be put in quotes, because '#' serves as a comment character in Git configuration files.
>
>``` ini
> [bugtraq "otrs"]
>   url = "https://otrs/index.pl?Action=AgentTicketZoom;TicketID=%BUGID%"
>   logregex = "^#[0-9]{1,5}"            
>```
