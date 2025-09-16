# OpenAI Codex Integration

SmartGit offers basic hyperlink integration with the [OpenAI Codex Agent](https://openai.com/codex/), enabling you to launch Codex for the selected repository and branch directly from within SmartGit.

Once correctly configured, an **Open in Codex** option will appear when you right-click a branch in the **Branches** view.

> [!NOTE]
> At time of writing, OpenAI Codex only supports integration with GitHub repositories.
> SmartGit will open your default browser -- if you have multiple browser identities, switch the identity which you use to access Codex before invoking the **Open in Codex** option in SmartGit.
> Only branches which track a known branch on the remote can be accessed by Codex.

## Setup

To enable the integration, you need to define the appropriate Codex environment in your repository's `.git/config` file.
For example:

```
[smartgit-codex-agent]
    environment = aaaabbbbccccddddeeeeffff00001111
```

Replace the `environment` value (aaaabbbbccccddddeeeeffff00001111) with your actual Codex environment ID.
You can find this ID in the URL when editing the corresponding Codex environment in your [ChatGPT settings](https://chatgpt.com/codex/settings/environments) -- it's the hexadecimal string shown in the address bar.
