## OpenAI Codex Integration

SmartGit offers a basic integration with the [OpenAI Codex Agent](https://openai.com/codex/), enabling you to launch Codex for a specific repository and branch directly from within SmartGit.

Once properly configured, an **Open in Codex** option will appear in the *Branches* view.

### Setup

To enable the integration, you need to define the appropriate Codex environment in your repository's `.git/config` file. For example:

```
[smartgit-ai-codex]
    environment = 8f3c9b2d5e7a1c4e6d9f2a0b3c8e6f1d
```

Replace the `environment` value with your actual Codex environment ID. You can find this ID in the URL when editing the corresponding Codex environment in your [ChatGPT settings](https://chatgpt.com/codex/settings/environments) -- it's the hexadecimal string shown in the address bar.
