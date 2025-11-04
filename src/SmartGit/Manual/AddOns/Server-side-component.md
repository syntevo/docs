# Server-side Component

The Distributes Reviews server-side component is **optional**, and is useful where your team does not have access to an interactive Pull Request review system such as GitHub, GitLab, or Azure DevOps.
Once installed and configured, it will track changes to the review meta data and send appropriate emails to affected users.

## Installation

Unzip the contained files from the bundle to a new directory on the same server which is also hosting your Git repositories, let's assume this will be `/opt/reviewserver`.
Make sure that `post-receive.sh` is executable -- if not, make it executable using `chmod +x post-receive.sh`.

> [!NOTE]
> If the selected directory is not writable by the *system Git account*, i.e. the account which will be used to write to the Git repositories, the log file location in `log4j.properties` must be adjusted.

Adjust the configuration file `/opt/reviewserver/config.email` for your environment.
All **mandatory** parameters have to be supplied.

Finally, following `post-receive` hook has to be set up for all repositories which should be tracked:

```
#!/bin/bash
/opt/reviewserver/post-receive.sh "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

## Notifications

### Events

Emails will be sent for following events:

- Creation of a pull request (`prCreated`)
- Assignment of a pull request (`prAssigned`)
- Editing the message of a pull request (`prEdited`)
- Updating the base commit of a pull request, e.g. by rebasing onto a more recent commit (`prUpdated`)
- Closing of a pull request (`prClosed`)
- Deletion of a pull request (`prDeleted`)
- Integration of a pull request (`prIntegrated`)
- Reviewing a pull requests (`prReviewed`)
- Other (unexpected) modifications of a pull request (`prModified`)

### Style Files, Entities and Their Attributes

For every event, `template/email` contains a corresponding style file which can be adjusted to your needs.
Valid entities and their attributes are which can be used in styles files are:

- The affected repository name `repo.name`
- Details of the current (new, updated):
  `pr.{name, source, target, integrationCommit, assignees, createdAt, createdBy, updatedAt, updatedBy, text, sourceHead, targetHead, rawAttributes}`
  Note that not all attributes will be available for every type of event.
  For instance, `pr.updatedAt` is not available for `prCreated`, the creation of a pull request.
- Details of the old pull request, similar as above: `prOld.{name ... rawAttributes}`
  Note that all of these attributes will only be available for pull requests which have been existing before, what is not the case for the `prCreated` event.
- For `prReviewed`, details about the review:
  `review.{reviewer, kind, text, commentCount}`
- For `prReviewed`, detailed information about all affected comments: `comments.{path, text}`.
- The SHA of the meta-ref commit `meta.commit`; this will usually just be interesting for debugging purposes.

### Roles

The role mapping `config.roles` defines which events should be delivered to which kinds of users (*roles*):

- Creator of the pull request (`creator`)
- Assignee(s) of the pull request (`assignee`)
- Last updater of pull request (`updater`)
- Curator of the affected repository (`curator`); curators are defined in the user mapping `config.users`.

### User Mapping

The user mapping `config.users` specifies one or more *curators* for a specific repository using lines like:

```
curator.<repo>: curator1@domain1 [,curator2@domain2 ...]
```

where `<repo>` is the path name of the repository (as present in the file system).

In addition to *repository-specific* curators, *global* curators can be defined by a trailing line like:

```
curator: curator1@domain1 [,curator2@domain2 ...]
```

### (Debug) Logging

The server component's log can be found in `log.txt.0` files.
The (debug) log level can be configured in `logger.properties`.

> [!EXAMPLE]
> ```
> ...
> # Root level:
> .level= INFO
>
> smartgit.reviewserver.level=FINE
> ...
> ```

## Related How-Tos

- [How to set up a Git server](../../HowTos/Workflows/How-to-set-up-a-Git-server.md): Learn about setting up a Git server with bare repositories, user permissions, and SSH authentication - essential background for hosting the server-side component
