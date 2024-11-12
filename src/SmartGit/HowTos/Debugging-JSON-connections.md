# Debugging JSON connections

For the majority of its integrations (JIRA, GitHub, Bitbucket, GitLab,
...), the corresponding platform will be accessed over a REST API which
is based on JSON. In case of parsing problems, it may be helpful to
debug log sent and received JSON objects. To do so:

1.  create a temporary debug output directory on your hard disk, which
    is writable for SmartGit (e.g. `c:/temp/json`)

2.  add following line to [smartgit.properties](../Latest/System-Properties.md) for
    which you will replace `<absolute-path-to-debug-directory>` by your
    directory's path (on Windows, be sure to use forward-slashes instead
    of back-slashes)

    ``` java
    smartgit.json.debugDir=<absolute-path-to-debug-directory>
    ```

    Example:

    ``` java
    smartgit.json.debugDir=c:/temp/json
    ```

3.  optionally, you can also specify to log *sent* and *received* HTTP
    headers to the debug output file:

    ``` java
    smartgit.json.debugHeaders=true
    ```

	#### Note
	> The debug log of *sent* headers will also include `Authorization`
	> and similar headers which contain your username/password or similar
	> credentials. Thus, be sure to remove the debug output files from
	> your disk as soon as you have finished the debugging.

4.  shutdown SmartGit

5.  get rid of `logs/log.txt*` from [SmartGit's Settings](../Latest/System-Properties.md) directory (it's the same directory where `smartgit.properties` is located)

6.  restart SmartGit to have the changes take effect

7.  invoke the problematic operation:
    -   in case of parsing problems, SmartGit will report the debug
        output file for the failed operation in the error message

8.  check the debug output directory for sent and received JSON objects:
    -   for a single request, there may be `in.pretty` and `in.raw` files containing the received content,
        an `out` file containing the sent content and an `err` file containing the received error;
	there may also be several `graphql.*`-files
    -   all files belonging to the same request will be labeled by a
        unique timestamp  
    -   depending on the server side and error, not all of these files may be present
	
9.  if asked so, send all files compressed to smartgit@syntevo.com, be sure to also include SmartGit's log files!
    -   copy over `logs/log.txt*` from the Settings directory to the temporary debug output directory
    -   compress all files into a single archive using either ZIP, 7z or TAR-GZ

## Replicating problems with curl from command line: example "Debug why Create GitHub Pull Request fails"

1.  On the GitHub website, go to your account **Settings**, **Developer
    settings**, **Personal access tokens** and create a personal access
    token which has at least all **repo** scopes.

2.  In SmartGit, **Preferences**, **Hosting Providers**, open
    the **GitHub** configuration and paste this token into the **Token**
    input field.

3.  Verify that the tokens work, e.g. by clicking the GitHub icon in
    the **Branches** view (Log window) which should start refreshing and
    displaying pull requests.

4.  Confirm that **Create Pull Request** still fails with your token.

5.  Exit SmartGit.

6.  Enable JSON debug logging, as explained above.

7.  Open SmartGit and retry to **Create Pull Request**; this should
    result in an ".out.json" file like:

    ``` java
    https://api.github.com/repos/someone/priv/pulls
    {"head":"someone:feature\/XYZ-123","title":"file added","body":"","base":"master"}
    ```

8.  Copy this file to another temporary directory and rename it to
    `body.json`, like `c:/temp/curl/body.json` and remove the first line
    which is the actual URL to be opened:

    ``` java
    {"head":"someone:feature\/XYZ-123","title":"file added","body":"","base":"master"}
    ```

9.  From command line, `cd` to this directory and invoke:

    ``` java
    curl -k -H "Authorization: token <token>" -H "Content-Type: application/json" --data @body.json <url> > out.log
    ```

    For the above command, replace `<token>` by your personal access
    token and `<url>` by the URL you had removed from the JSON file
    before. For example, a real call might look like:

    ``` java
    curl -k -H "Authorization: token 69460770e6251fea183b229c9a89fac616c641f9" -H "Content-Type: application/json" --data @body.json https://api.github.com/repos/someone/priv/pulls > out.log 2> err.log
    ```

10. Check `out.log` and `err.log` to see the results.

## GitHub: replicating problems with the GraphQL explorer

SmartGit (since version 22.1) is using GitHub's GraphQL API to access metadata from GitHub. The JSON `out`-file (see above) will contain the sent GraphQL query. For example:

```
{"query":"query {
  viewer {
    id
  }
}
"}
```

You can now log into [GitHub's GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer) and run the query there to see whether the error is reproducible. For that, you will have to only copy over the actual query term of the JSON logging, or with other words drop the leading `{"query":"` and trailing `"}`. For the above example, this is what you will enter into the GraphQL Explorer:

```
query {
  viewer {
    id
  }
}
```

