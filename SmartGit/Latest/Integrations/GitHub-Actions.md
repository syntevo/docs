# GitHub Actions integration (only Standard window)

SmartGit will display GitHub Actions workflow run results  in the **My History** view of
*Standard* window, if the [GitHub integration](GitHub-integration.md) is properly configured.

## Additional Configuration

By default, SmartGit will query for all GitHub Actions workflows.
To limit the list of workflows, you can use `smartgit.github-actions.`-keys
in your repository's `.git/config`:

* `workflows`: a comma-separated list of GitHub Actions workflow names which should be queried

#### Example
>
>``` text
>[smartgit "github-actions"]
>   workflows = ci
>```
