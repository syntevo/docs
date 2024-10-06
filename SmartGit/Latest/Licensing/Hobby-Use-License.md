# Hobby-Use License

The Hobby-Use license limits repository access to specific conditions. Every accessed repository (including submodules) must satisfy at least one of these conditions.

## Single-author repositories

If there is only a single author and committer in the repository (both, names *and* email addresses must be unique), the repository can be accessed without restrictions. There is a certain tolerance for the first couple of commits, i.e. authors for these commits may be different from the main author.

#### Note
> To see all authors of your repository, you may invoke `git shortlog -sne`.

#### Note
> Authors registered in the _reflog_ considered, too. Hence, in case of problems, try to run `git gc`.

#### Note
> If your repository contains more authors than tolerated *by accident* (e.g. if you have changed your name or email too often), you may consider to convert the repository to a single author using SmartGit's command line option `--convert-repository-to-single-user`. **Use with care! This will rewrite your entire repository.**

## Public repositories

If the repository is publicly accessible, public commits will be *certified* on-the-fly. The local HEAD is restricted to not diverge too far from such certified commits.

If the HEAD has diverged too far, SmartGit will try to re-certify on-the-fly. If it's not possible to find a public commit close enough to the HEAD commit, the repository can't be used anymore from within SmartGit.

#### Important
> The certification requires a connection to our servers. Be sure to push your commits frequently to keep them public and thus certifiable.

### Rate limits

To protect our infrastructure, the certification-process is rate-limited to 5 requests per minute (unfortunately no hourly limits can be configured for Cloudflare).
* For the Log window this rate limit usually imposes no problems because it's unlikely that you are opening more than 5 not-yet-certified repositories within one minute.
* For the Working Tree window, opening a repository with multiple submodules may exceed the rate limit
  * If you are not interested in your repository's submodules, in the **Preferences**, section **Low-level Properties** you can set `refresh.scanIntoSubmodules` to `false`. This prevents scanning into submodules and thus will not require certificates for these repositories.


#### Note
>
>If you are running into the rate limit, be patient and give SmartGit some pauses between certificate-batches. This will be the fastest way to get multiple certificates and prevents you from becoming blocked.
