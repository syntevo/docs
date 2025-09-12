# AI-Generated Commit Messages

SmartGit versions 25 and later offer optional AI-generated assistance when adding commit messages.

This feature can enhance productivity and accuracy when creating new commits by enabling capabilities such as:
- Evaluating the diff for your next commit and creating an AI-generated commit message
- Rewording or correcting typographical errors in a user-entered commit message
- Ensuring that a commit message accurately reflects the changes in the commit
- Enforcing commit message standards defined by your team or organization

All AI-based features are disabled by default, ensuring no data is shared without user consent.
Users must **opt-in** and configure these services.

> A key objective of this initiative is to empower users with full control over how large language
> models (LLMs) interact with their version control workflows.
> You have the freedom to make informed
> decisions about which parts of your codebase can be used with specific LLM or AI services
> that you trust and have access to.

For first time users, please consult these [quick-start tutorials](AI-Commenting-Tutorial.md) on how to use SmartGit's AI features:

- [Getting Started with AI Generated Commenting](AI-Commenting-Tutorial.md#tutorial--getting-started-with-ai-generated-commenting)
- [Using the '@ai' placeholder to Reword Commit Messages](AI-Commenting-Tutorial.md#tutorial--using-the-ai-placeholder-to-reword-commit-messages)
- [Using the 'WIP' placeholder to insert an AI-generated WIP commit message](AI-Commenting-Tutorial.md#tutorial--using-the-wip-placeholder-to-insert-an-ai-generated-wip-commit-message)

SmartGit's AI features do not operate through an assistant like ChatGPT.
Instead, SmartGit interacts directly with AI models via their APIs.
When using a custom or commercial Large Language Model (LLM), an account with an API integration key will be required.

If you wish to configure SmartGit to use different or custom LLMs, or need to customize LLM prompting and other options, please consult the [AI Integration](../Integrations/AI.md) reference documentation.

### Warning
> SmartGit will submit the contents of the staged diff as part of a prompt to the configured Large Language Model (LLM) to obtain AI-generated output.
>
> It is recommended that you evaluate the level of trust and confidentiality appropriate for your repository before enabling SmartGit's AI features.
>
> This consideration may depend on whether the LLM is self-hosted or cloud-hosted, the security and privacy guarantees provided by the LLM service,
> and whether your repository is private or open-source.
>
> As a result, SmartGit's AI commenting feature is disabled by default.

## Enabling AI Commenting Features
SmartGit's AI features are disabled by default and can be enabled the first time the ![AI](../images/AI-Commit-Button.png) button is clicked.
The following options are shown:

 - **Use GitHub models globally** - Adds configuration to use the default LLM in your global `git.config` file, applying to all repositories on your computer.

 - **Use GitHub models for this repository** - Adds configuration to use the default LLM in the current repository's `git/config` file only.

 - **Configure manually** - Opens the [AI Configuration](../Integrations/AI.md) page with instructions on how to add `smartgit-ai-llm` and `smartgit-ai-commit-message`
   sections to your Git configuration files.

 - **Disable AI configuration (selected by default)** - Disables SmartGit AI integration.

## Selecting between AI Models
By default SmartGit uses the public GitHub Large Language Model (LLM) once AI commenting is enabled.

However, if additional AI models are [configured](../Integrations/AI.md), you can use the **down arrow** between the **AI** button and the **Hamburger Menu** in the **Commit View** to select the LLM that SmartGit will use for AI features.

## Commit Message Generation
SmartGit utilizes AI-powered Large Language Models (LLMs) to generate or analyze commit messages based on your working tree modifications or staged changes.

This involves transmitting the complete `git diff` (or `git diff --cached`) to an AI service.

Once enabled, an **AI** button with a drop-down menu appears in the [Commit View](../GUI/Commit-View.md).

This menu lists all configured AI services and indicates the currently active ones.

Clicking the button or selecting a different AI service sends the Git diff to the chosen provider, which generates a commit message and streams it back to SmartGit.

### Staged and Untracked Files

As with any commit staging, generally, only staged files are included in the Git diff submitted to the AI.
However, the diff also depends on which Main Window is being used and the staging preferences:
  - **[Standard Window](../GUI/Standard-Window.md)** - The Git diff automatically includes all untracked files.
  - **[Log Window](../GUI/Log-Window.md) or [Working Tree Window](../GUI/Working-Tree-Window.md)** - The diff will depends on the [Preferences](../GUI/Preferences/index.md) option: `Commands | Log and Working Tree window | Commit View` if nothing is staged.

### Options

By default, the AI-generated commit message is inserted at the current cursor location in the commit message of the **Commit View**.
Interaction between the existing commit message, any manual modifications, and the AI-generated message depends on several options:

### On Manual Intervention

- **Stop** - Stops commit message generation upon any manual change (e.g., typing text or moving the cursor).
- **Continue in Background** - Allows generation to continue and stores the message in a buffer, instead of displaying it immediately.
  The AI button will blink green to indicate that buffered content is available.

### Commit Message Line Wrapping

By default, the commit message description is wrapped at 72 characters.
Wrapping can be disabled using the [Low-level property](../GUI/AdvancedSettings/Low-Level-Properties.md) `ai.commitMessageGeneration.wrapDescription`.

## Commit Message Rewording

SmartGit can optionally reword messages for commits that have not yet been pushed (see hamburger menu); the mechanism is the same as for the Commit Message Generation, and the same configuration is utilized.

There are two different operational modes here:

- Rewording `@ai` messages: For commits containing `@ai` in their message, the `@ai` marker will be replaced by an AI-generated message.
- Rewording `WIP` messages: For commits with the exact message as `WIP` (or `wip`, case-sensitive), the message will be replaced by an AI-generated message and prefixed with `WIP:`, i.e. `WIP: <ai generated message>`.

[Low-level properties](AdvancedSettings/Low-Level-Properties.md) `ai.commitMessageRewording.*` can be used to customize this process.

### Notes
> - You can reset SmartGit's AI configuration by removing all `smartgit-ai-llm` and `smartgit-ai-commit-message` sections from your Git configuration files (global, personal and/or repository).
> - `@ai` and `WIP` placeholders are only substituted when you add a commit - not interactively and not by clicking the AI button.
> - The `WIP` token must be the only text in the commit message - no additional text or whitespace.
> - When `@ai` is immediately followed by `<` (e.g. `@ai<some input`), the marker is trimmed before the commit message is passed to the prompt (i.e. only `some input` will remain).
>   The generated message will completely replace the original `@ai`-prefixed message, not just the `@ai` token.
> - If SmartGit does not substitute the `@ai` or `WIP` tokens, re-enable token substitution by clicking the drop down arrow next to the **AI** icon and the **Hamburger Menu** above the **Commit View**, and selecting the **Reword '@ai'** and **'WIP' commits** options.
> - Use the [low-level property](AdvancedSettings/Low-Level-Properties.md) `ai.commitMessageRewording.aiRegex`
>   to change the `@ai` token.
> - Use the low-level property `ai.commitMessageRewording.wipRegex` to to modify the `WIP` token
>   and `ai.commitMessageRewording.wipPrefix` setting to change the prefix used.

## Errors and Troubleshooting

If errors occur during the interaction with the AI, SmartGit will show that an error has occurred, with details about the error.

Common errors include:

- **404 / Resource Not Found** - Indicates that the `url` setting in the `[smartgit-ai-llm]` git config section may be incorrect, or possibly the LLM API is unavailable.

  Check the LLM provider's API instructions and verify the [integration config setting](../Integrations/AI.md).

  Some APIs require a prefix, e.g., `openai/gpt-4.1` would be an example model configuration for [github.ai](https://github.com/marketplace/models/).

- **The Git diff is too large** - the diff exceeds the [maxDiffSize](../Integrations/AI.md#maxDiffSize) setting in `[smartgit-ai-commit-message]`.

  Increase the `maxDiffSize` setting if needed.
  However, large diffs can be challenging to describe in a concise commit message, whether AI or Human generated.

- **AI generation of the commit message failed - Request body too large for <model>** - The LLM's token limit was exceeded.
  Free/public LLMs may allow ~8,000 tokens; commercial LLMs may allow 100,000+.

### Tips + Notes
> - Align the `maxDiffSize` setting with typical commit sizes for your team and within the token limits of your [chosen LLM provider](https://github.com/taylorwilsdon/llm-context-limits).
>
> - Code has a higher token density than natural language, depending on the programming language.
>
> - Tools like [tiktoken](https://github.com/openai/tiktoken) can help estimate token counts per line or file.
> - Although commercial providers generally bill for usage as a function of input and output token counts, unless your team makes very high frequency
>   and/or commits with very large diffs, using SmartGit to assist with commit messages is unlikely to incur more than a few US$ per month.
