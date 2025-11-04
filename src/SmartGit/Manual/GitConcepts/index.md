# Git Concepts

This section aims to help you get started with Git and gives you an understanding of the fundamental concepts of the Git version control system.

If you are new to Git but are familiar with version control systems such as Subversion, please read our article [Git for SVN Users](Git-for-SVN-users.md).

**Topics:**

- [Distributed Version Control Systems](#distributed-version-control-systems)
- [A typical repository lifecycle when using Git](#a-typical-repository-lifecycle-when-using-git)
- [Common Terms used in Git](CommonTerms.md)
- [Working with Branches](Branches.md)
- [Adding new Commits](Commits.md)
- [Merging branches](Merging.md)
- [Rebasing](Rebasing.md) for fine level control over the commit history of a branch
- [Cherry Picking](Cherry-Picking.md) specific commits into your current branch
- [Reverting Commits](Reverting.md)
- [Working Tree States](Working-Tree-States.md)
- [The Git Index](The-Index.md)
- [Working with Submodules](Submodules.md)
- [Working with Remote Repositories](GitRemotes.md)
  - [Fetching](GitFetch.md)
  - [Pulling](GitPull.md)
  - [Pushing](GitPush.md)

## Distributed Version Control Systems

Unlike previous centralized version control systems such as Subversion (SVN), Visual Source Safe (VSS), or Concurrent Versions System (CVS), Git is a Distributed Version Control System (DVCS).

Git offers several advantages over traditional Centralized Version Control Systems (CVCS), such as:

- Users receive their own copy of a source repository (through a cloning process) on their local computer, allowing for version control even when offline.
- Commits can be created in the local repository and then pushed to the remote repository when you are ready.
- Git has a streamlined mechanism for reviewing requests to bring new commits on a feature or hotfix branch into an existing branch, called a pull request (PR).
- Switching between branches in Git is much easier than in CVCS systems.
- While CVCS version control systems are centered around one central repository, Git allows you to connect your repositories to multiple remotes simultaneously, providing greater flexibility in how you share or merge your code.

## A typical repository lifecycle when using Git

Although every repository usage is unique, some common activities will occur at some point in the lifetime of on most repositories:

- A repository owner (e.g., a team lead or senior developer) will create a new, empty repository on a Git server such as [GitHub](../Integrations/GitHub-integration.md), [GitLab](../Integrations/GitLab.md), [Bitbucket](../Integrations/Bitbucket-integration.md), or [Azure DevOps](../Integrations/Azure-DevOps.md).
  We'll refer to this remote repository as `origin`.
- Access to the `origin` repository will be configured (e.g., private or public access, identifying users who may read and contribute to the repository).
  The `origin` repository can then be cloned locally.
- The repository owner will identify the default branch in the repository (usually called `main`, or historically `master`) and will often protect the default branch from direct changes.
  Contributors are expected to push changes to another branch in the same repository or a fork of the repository and issue a pull request for review and approval.
- It is common for the initial commit(s) in a repository to include:
    - A `README.md` file providing a brief outline of the repository's purpose.
    - A `.gitignore` file that tells Git which files in the Working Directory should NOT be checked into the repository (in software development, compiled and executable files and 3rd party library binaries are generally excluded).
    - For a software project, files used by your chosen DevOps Tool's build and release pipelines, that enable continuous integration (CI) and continuous deployment (CD) practices.
      This includes automatically triggering new builds when changes are made to a branch or creating and deploying new releases when branches are merged into the default branch.
      Additional configuration outside of the repository will be required.
    - The inital commit may also include a baseline version of the software, documenation, or other artifacts being developed that require version control.
- For software projects, the team will often set ground rules for the software development processes used in the repository, such as:
    - Using an established branching process such as GitFlow or GitHub Flow.
    - Determining naming standards for new branches (e.g., branch names might contain the headline name of an Agile story or contain a ticket number referencing an item in a project management tool).
    - Setting minimum quality standards (e.g., any automated tests, documentation, and code review tasks) required by contributors before a pull request can be issued to add new commits into the default branch.
- Each user or team member contributing to the repository (Contributor) can now clone the repository to their local computers.
  This will create a Working Tree containing all the files in the default branch, and an internal `.git` folder.
  **Do NOT add or edit any files in the `.git` folder** -- this is used internally by Git to manage your local repository.
- Contributors will identify the next deliverable piece of work they will work on and create a new branch for this work, following any branch naming rules identified for the repository.
- Contributors will use their favorite tools and Integrated Development Environments (IDEs) to develop new software versions, documentation, designs, or other types of content in the Working Directory.
  This will result in changes to existing files tracked by Git, and adding new files not yet known to Git.
- Once Contributors are satisfied that this piece of work is complete, a typical sequence is to:
    - Stage the next commit, ensuring that all modified, new, and deleted files are included in the next commit (the Git Index).
    - Commit the staged changes, providing a commit message describing the changes (and possibly identifying the story, feature or ticket associated with this work).
      Git will add audit information of the user creating the commit, add the timestamp, and calculate the new commit's hash.
    - The Contributor will push the new commit(s) back to the remote repository.
      By default, Git will push the changes to the tracked branch; however the contributor can choose to push to a different branch on the remote or create a new branch on the remote.
      By convention, it is advisable to keep the branch naming consistent between the remote and the local repository to prevent confusion or mistakes.
    - The Contributor can now create a pull request on the remote repository between the newly-pushed branch (source branch) and the target branch (e.g., the default branch, such as `main`).
    - Other contributors in the repository will be notified of the pull request and can review the changes made in the commit.
      They may either agree to accept the changes (by merging or rebasing them into the target branch) or request that the Contributor make changes to the source branch before it is accepted.
    - Another common reason branches cannot be merged is due to a merge conflict.
      For example, another Contributor may have added a commit to the target branch that conflicts with the changes made in the source branch.
      In this case, someone will need to resolve the conflict, creating an additional commit to resolve the conflict.
      This resolving commit must then be pushed to the source branch.
    - Once the review is accepted, an authorized user of the repository will complete the pull request, which will add the changes made in the source branch to the target branch.
    - Other users who have cloned the `origin` repository can now [pull from the remote repository](../GUI/Repository/Synchronizing-with-Remote-Repositories.md#pull) to get your latest pushed changes.

And that's it -- the basics of working with Git!

To make working with Git easier, **SmartGit** wraps the concepts above in an easy-to-use graphical user interface (GUI), in order to simplify working with Git repositories.

## Related How-Tos

- [Staging, unstaging and the Index Editor](../../HowTos/Workflows/Staging-unstaging-and-the-Index-Editor.md): Learn how to use the Git Index to stage specific files or chunks within files for your commits
- [How to resolve conflicts](../../HowTos/Workflows/How-to-resolve-conflicts.md): Step-by-step guide to resolving merge conflicts using SmartGit's Conflict Solver
- [How to perform a cherry-pick](../../HowTos/Workflows/How-to-perform-a-cherry-pick.md): Apply changes from specific commits to your current branch
- [Setting up submodules](../../HowTos/Workflows/Setting-up-submodules.md): Detailed instructions for adding and managing Git submodules in SmartGit
- [Modifying the History](../../HowTos/Workflows/Modifying-the-History.md): Advanced techniques for modifying commits, including rebasing and reordering commits
