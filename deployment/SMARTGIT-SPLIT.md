# Documentation deployments

`.github/workflows/deploy.yml` assembles `latest`, `smartgit/*`, and `legacy`
once, renders Mermaid once, and builds two Jekyll sites:

| Pages project | Public hostname | Content |
| --- | --- | --- |
| `docs` | `docs.syntevo.com` | Product chooser, SmartSVN, SmartSynchronize, DeepGit |
| `smartgit-docs` | `docs.smartgit.dev` | SmartGit Latest and every historical version |

Both deployments use the existing branch selection: `main` for production and
`develop` for previews. They share the `CLOUDFLARE_ACCOUNT_ID` and
`CLOUDFLARE_API_TOKEN` GitHub Actions secrets. The account token needs Cloudflare
Pages Edit access for both projects.

The source documents and authoring branches retain their product directories.
The SmartGit overlay and packager serve its version index at `/`, manuals at
`/Latest/Manual/` and the version directories, and How Tos at `/Latest/HowTos/`.
The packager updates links, canonicals, and the sitemap, selects and flattens
aliases from `_redirects`, and retains `/SmartGit/...` compatibility redirects.
The Syntevo overlay excludes SmartGit; its chooser links directly to the new
hostname. Shared assets and the existing analytics identity are retained.

## Old-host redirect

Keep the old hostname's DNS/TLS and this Cloudflare Single Redirect in the
`syntevo.com` zone so existing application Help links and bookmarks continue
to work:

```text
(http.host eq "docs.syntevo.com" and
 (http.request.uri.path eq "/SmartGit" or
  starts_with(http.request.uri.path, "/SmartGit/")))
```

Use status **301**, enable **Preserve query string**, and set the dynamic target
expression to:

```text
concat("https://docs.smartgit.dev", substring(http.request.uri.path, 9))
```

This removes `/SmartGit` while retaining the rest of the path. The other
products and the old root remain on `docs.syntevo.com`.
