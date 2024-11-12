# TeamCity integration (only Standard window)

SmartGit will display TeamCity build results in the **My History** view of
*Standard* window, if configured.

## Configuration

The integration is configured in the repository's `.git/config`,
using `smartgit.teamcity.`-keys:

* `url`: the root URL of your TeamCity server
* `project`: the TeamCity project name for your Git repository
* `buildConfigurations`: a comma-separated list of TeamCity build configuration names which should be queried

#### Example
>
>``` text
>[smartgit "teamcity"]
>   url = https://server:8443
>   project = SmartGit
>   buildConfigurations = tests,tests-gitimpl,tests-jgit
>```
