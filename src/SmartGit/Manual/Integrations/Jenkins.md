# Jenkins Integration (Standard Window Only)

SmartGit will display Jenkins job results in the **My History** view of the **Standard Window**, if configured.
Currently, *free style projects* and *multibranch pipelines* are supported.

## Configuration

The integration is configured in the repository's `.git/config`, using `smartgit.jenkins.` keys:

- `url`: the root URL of your Jenkins server

At least one project type must be configured:

- `freeStyleProjects`: a comma-separated list of free style project names which should be queried
- `multiBranchPipelines`: a comma-separated list of multibranch pipeline project names which should be queried

> [!EXAMPLE]
> Example configuration:
>
> ``` ini
> [smartgit "jenkins"]
>    url = http://localhost:8080
>    freeStyleProjects = tests,tests-gitimpl,tests-jgit
> ```
