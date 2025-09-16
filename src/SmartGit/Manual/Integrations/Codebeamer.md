# codebeamer

SmartGit supports integration with external issue trackers through the use of the `.gitbugtraq` configuration file.
This allows you to associate Git commits with tracker items from systems like codebeamer.
By configuring `.gitbugtraq` appropriately, you can enable SmartGit to recognize references to tracker items in commit messages and convert them into clickable links.

This enables [Tracing of Source Code Changes to Requirements, Task, Issues, Bugs and other codebeamer tracker items](https://codebeamer.com/cb/wiki/11101) as described in the codebeamer documentation.

## Tracing commits to tracker items

Once this integration is in place, any commit that contains a valid codebeamer reference, as defined in the [Bugtraq configuration](../Integrations/Bugtraq-links-to-issue-trackers.md), will be rendered in SmartGit with an active link.
Clicking this link will open the associated tracker item directly in your default web browser, streamlining the traceability between commits and issue tracker entries.

## Preparation

To enable the linking from SmartGit to PTC codebeamer tracker items, we need to set up a [Bugtraq configuration](../Integrations/Bugtraq-links-to-issue-trackers.md) in the repository.

```
# An example content of .gitbugtraq to put in the repository root directory.
# It could instead be added as an additional section to $GIT_DIR/config.
# (note that '\' need to be escaped).

[bugtraq]
  url = https://training.codebeamer.com/issue/%BUGID%
  loglinkregex = "CB\\d+"
  logregex = \\d+
```

> [!NOTE]
> The [Bugtraq configuration](../Integrations/Bugtraq-links-to-issue-trackers.md) offers extensive customization options, allowing you to tailor the integration to your specific needs.
> While this example uses PTC codebeamer, the same approach can be applied to many other issue tracking tools that support similar URL and pattern-matching schemes.

## Details

In the current configuration, references to codebeamer tracker items follow the format `CB1234`, where `1234` is the actual ID of the tracker item in codebeamer.
When a commit message includes such a reference (e.g., "Fixed issue CB1234"), SmartGit interprets it using the rules defined in the `.gitbugtraq` file and generates a hyperlink like `https://<codebeamerserver>/issue/1234` to the corresponding issue in codebeamer.
