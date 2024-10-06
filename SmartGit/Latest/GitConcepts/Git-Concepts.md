---
redirect_from:
  - /SmartGit/Latest/Git-Concepts
  - /SmartGit/Latest/Git-Concepts.html
---
# Git Concepts

This section aims to help you get started with Git and gives you an understanding of the fundamental concepts of the Git version control system.

If you are new to Git but are familiar with version control systems such as Subversion, please read our article [Git for SVN Users](Git-for-SVN-users.md).

## Distributed Version Control Systems

Unlike previous centralized version control systems such as Subversion (SVN), Visual Source Safe (VSS), or Concurrent Versions System (CVS), Git is a Distributed
Version Control System (DVCS).

Git offers several advantages over traditional Centralized Version Control Systems (CVCS), such as:
- Users receive their own copy of a source repository (through a cloning process) on their local computer, allowing for version control even when offline.
- Commits can be created in the local repository and then Pushed to the remote repository when you are ready.
- Git has a streamlined mechanism for reviewing requests to bring new commits on a feature or hotfix branch into an existing branch, called a Pull Request (PR).
- Switching between branches in Git is much easier than in CVCS systems.
- While CVCS version control systems are centered around one central repository, Git allows you to connect your repositories to multiple remotes simultaneously, providing greater flexibility in how you share or merge your code.

## A typical repository lifecycle when using Git

Although every repository usage is unique, some common activities will occur at some point in the lifetime of on most repositories:

- A repository owner (e.g., a team lead or senior developer) will create a new, empty repository on a Git Server such as GitHub, GitLab, BitBucket, or Azure DevOps **TODO** Links. We'll refer to this remote repository as `origin`.
- Access to the `origin` repository will be configured (e.g., private or public access, identifying users who may read and contribute to the repository). The `origin` repository can then be cloned locally.
- The repository owner will identify the default branch in the repository (usually called `main`, or historically `master`) and will often protect the default branch from direct changes. Contributors are expected to push changes to another branch in the same repository or a fork of the repository and issue a Pull Request for review and approval.
- It is common for the initial commit(s) in a repository to include:
  - A `README.md` file providing a brief outline of the repository's purpose.
  - A `.gitignore` file that tells Git which files in the Working Directory should NOT be checked into the repository (in software development, compiled and executable files and 3rd party library binaries are generally excluded).
  - For a software project, files used by your chosen DevOps Tool's build and release pipelines, that enable continuous integration (CI) and continuous deployment (CD) practices. This includes automatically triggering new builds when changes are made to a branch or creating and deploying new releases when branches are merged into the default branch. Additional configuration outside of the repository will be required.
  - The inital commit may also include a baseline version of the software, documenation, or other artifacts being developed that require version control.
- For software projects, the team will often set ground rules for the software development processes used in the repository, such as:
  - Using an established branching process such as GitFlow or GitHub Flow.
  - Determining naming standards for new branches (e.g., branch names might contain the headline name of an Agile story or contain a ticket number referencing an item in a project management tool).
  - Setting minimum quality standards (e.g., any automated tests, documentation, and code review tasks) required by contributors before a Pull Request can be issued to add new commits into the default branch.
- Each user or team member contributing to the repository (Contributor) can now clone the repository to their local computers. This will create a Working Tree containing all the files in the default branch, and an internal `.git` folder. **Do NOT add or edit any files in the `.git` folder** - this is used internally by Git to manage your local repository.
- Contributors will identify the next deliverable piece of work they will work on and create a new branch for this work, following any branch naming rules identified for the repository.
- Contributors will use their favorite tools and Integrated Development Environments (IDEs) to develop new software versions, documentation, designs, or other types of content in the Working Directory. This will result in changes to existing files tracked by Git, and adding new files not yet known to Git.
- Once Contributors are satisfied that this piece of work is complete, a typical sequence is to:
  - Stage the next commit, ensuring that all modified, new, and deleted files are included in the next commit (the Git Index)
  - Commit the staged changes, providing a commit message describing the changes (and possibly identifying the story, feature or ticket associated with this work). Git will add audit information of the user creating the commit, add the timestamp, and calculate the new commit's hash.
  - The Contributor will push the new commit(s) back to the remote repository. By default, Git will push the changes to the tracked branch; however the contributor can choose to push to a different branch on the remote or create a new branch on the remote. By convention, it is advisable to keep the branch naming consistent between the remote and the local repository to prevent confusion or mistakes.
  - The Contributor can now create a pull request on the remote repository between the newly-pushed branch (source branch) and the target branch (e.g., the default branch, such as `main`).
  - Other contributors in the repository will be notified of the Pull Request and can review the changes made in the commit. They may either agree to accept the changes (by merging or rebasing them into the target branch) or request that the Contributor make changes to the source branch before it is accepted.
  - Another common reason branches cannot be merged is due to a merge conflict. For example, another Contributor may have added a commit to the target branch that conflicts with the changes made in the source branch. In this case, someone will need to resolve the conflict, creating an additional commit to resolve the conflict. This resolving commit must then be pushed to the source branch.
  - Once the review is accepted, an authorized user of the repository will complete the Pull Request, which will add the changes made in the source branch to the target branch.
  - Other users who have Cloned the `origin` repository can now [pull from the remote repository](Synchronizing-with-Remote-Repositories.md#pull) to get your latest pushed changes.

And that's it - the basics of working with Git!

To make working with Git easier, it is strongly recommended that use [SmartGit](**TODO**) to simplify working with Git repositories.


## Table of Common Terms used in Git

**TODO** Sort the table alphabetically once done.

| Term  | Definition |
| ------------- | ------------- |
| Init  | (`git init`) is the command to create a new repository. You generally have the option of creating new repositories either on the remote, or locally. If you create the repository locally with a Git Init, you will need to connect to an empty remote repository to push your first commit(s) in your local repository to the remote. |
| Clone  | Cloning (`git clone`) is the command used to create a local copy of an existing repository. |
| Pull Request  | A Pull Request (PR) is a request issued to merge changes made on one branch (e.g., changes made on a feature branch) into another branch (e.g., into a main or release branch). Pull Requests allow an ideal opportunity for code reviews |
| [Branch](Branches.md)  | A Branch is a named reference to a particular commit in a repository. When new commits are added to a branch, the branch will now point to the later commit. |
| Checkout | Checkout (`git checkout`) is the Git command to switch between or create new branches. |
| Tracking Branch | When you checkout a remote branch to your local repository, the local branch will *track* the remote repository and branch where it originated. As time progresses, this will allow you to merge changes to the tracked branch made by others, into your local branch.  |
| Staging | Staging is the process of identifying the files that have been changed (added, edited, or deleted) in your Working Tree and which are to be included in the next commit. Git tracks staged files in the Git [index](The-Index.md). If you forget to stage a change or newly added file, it will be omitted from the commit!|
| [Commit](Commits.md) | Commits (`git commit`) is a unit or record of changes made to the files in a repository. So a branch consists of a sequence of commits. |
| Local Repository | The local repository is a (clone of a) repository stored on your local system (in the `.git` folder). You should not make changes to the local repository directly. Instead, you make changes to files in your Working Tree. |
| Remote Repository | The repository from which your local repository copy has been cloned. The remote is often referred to as `origin` by convention. |
| Rebase | Rebasing (git rebase) provides an alternative to merging two branches by creating or appending equivalent commits representing the changes made in the source branch to the target branch. This removes the appearance of branching from the commit history. In visualization tools, rebased commits appear as a linear sequence of commits on the branch. |
| Squash Commits | Git allows creating a new, single, consolidated commit from a series of smaller commits, essentially the ‘rewriting’ history in a branch. This can be useful for removing an unnecessarily ‘noisy’ commit history from your repository; however, it has the downside of losing some of the audit trails of when and who made changes. |
| Merge (Commit) | A merge commit is a new commit added when two branches are merged. The log will retain information about both branches, and visualization tools will be able to show commits made on the divergent branches and where they branched off and merged. |
| Fast Forward | Fast forwarding is a technique Git uses to apply new commits to an existing branch by simply appending each commit to the branch in sequence. e.g., Fast forwarding can be used when `pulling` changes from a remote branch (if no local changes have been made), or when rebasing a branch from new commits held in a side branch. Fast forwarding has an advantage over squash and merge commits in that no new commits are needed. Fast forwarding cannot happen without new commits in both source and destination branches. |
| Cherry-Pick | Cherry picking (`git cherry-pick`) is an advanced feature that pulls a specific, existing commit into the current branch. Although cherry-picking can help pick specific features off side branches into a new release, extreme caution is needed to ensure all dependent commits are cherry-picked in sequentially. |
| [Working Tree](Working-Tree-States.md) | The working tree is the folder on your local system where you can change files in a repository and then stage and commit these changes. |
| Commit Hash | A Commit Hash (also known as a commit Id) is a unqiue SHA-1 hash of the contents of a commit, which will be invariably be unique (unless the commit data, including timestamps and metadata are all identical). |
| Merge Conflict | A merge conflict occurs when changes are made by different Contributors, on different commits, to the same file, and Git is unable to automaticaly resolve the conflict. This will prevent two branches from being merged together until the conflict has been resolved, and a new commit created on one of the conflicting branches which resolves the conflict.|
| Bare Repository | A Bare Repository is a Git repository without a Working Tree. Usually, you will want a working directory, so Bare Repositories are generally only of interest to hosting providers like GitHub. *Note: A Bare Repository is not the same as an empty repository.* |
| Secure Shell (SSH) | SSH is an encrypted network protocol historically used to authenticate and communicate between local and remote repositories.  **TODO** See SSH |
| HTTPS | HyperText Transfer Protocol Secure is an alternative protocol that Git can use to connect local and remote repositories.|
| Credential Manager | A Git Credential Manager is a secure tool that assists in retaining a user's credentials as required to access remote repositories. Credential Managers simply provide HTTPS access to remote repositories so that users aren't prompted for authentication on each git command.|
| Large File Storage | Git LFS is an extension that stores large binary files (BLOBs) separately from your repositories. This is useful because Git cannot track 'differences' between binary files in the same way it can with text files such as source code or wiki documents. Adding BLOBs directly to your Git repository can bloat the storage required and impact performance of commands between local and remote repositories.|
| [Submodules](Submodules.md) | Submodules allow a common repository (e.g., a library project) to be referenced by one or more 'parent' repositories. This enables the reuse of common code without maintaining separate copies of the common repository. |
