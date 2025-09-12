# GitHub Actions Integration (Standard Window Only)

SmartGit will display GitHub Actions workflow run results in the **My History** view of the [**Standard Window**](../GUI/Standard-Window.md), if the [GitHub integration](GitHub-integration.md) is correctly configured.

## Additional Configuration

By default, SmartGit will query for all GitHub Actions workflows.
To limit the list of workflows, you can use `smartgit.github-actions.` keys in your repository's `.git/config`:

- `workflows`: a comma-separated list of GitHub Actions workflow names which should be queried

### Example

``` ini
[smartgit "github-actions"]
   workflows = ci
```
