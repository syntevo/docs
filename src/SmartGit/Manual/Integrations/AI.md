# AI Integration

> #### Note
>
> The AI integration is experimental in version 25.1 and may change in future updates.
>
> - Version 25.1.021: Commit Message Rewording and some Generation fixes
> - Version 25.1.019: Mistral support and some fixes
> - Version 25.1.015: Support for `promptFile` and some bugfixes
> - Version 25.1.013: Revised Git configuration, additional interaction modes and options.
> - Version 25.1.012: GitHub LLM support, Root URLs changed(!), improved error processing, improved default prompt (mainly for `gpt-4o-mini`).
> - Version 25.1.010: Initial versions

SmartGit offers optional integration with AI services to enhance its functionality.
All AI-based features are disabled by default, ensuring no data is shared without user consent.
Users must **opt-in** and configure these services explicitly. 

> A key objective of this initiative is to empower users with full control over how large language
> models (LLMs) interact with their code versioning. You have the freedom to make informed 
> decisions about which parts of your codebase can be used alongside specific LLM or AI services 
> that you trust and have access to.

The AI features in SmartGit do not operate through an AI Assistant like ChatGPT.
Instead, SmartGit directly interacts with AI models using their APIs.
An API account will be required to use these services.

## Commit Message Generation

SmartGit utilizes AI-powered Large Language Models (LLMs) to generate or analyze commit messages based on your working tree modifications or staged changes.
This involves transmitting the complete `git diff` (or `git diff --cached`) to an AI service.
Once enabled, you'll find an AI button with a drop-down menu in the [Commit View](../GUI/Commit-View.md).
This menu lists all configured AI services, indicating the currently active one.
Pressing the button or selecting a different AI will send the Git diff to the chosen service, which then generates a commit message and streams it back to SmartGit.

### Staged and Untracked Files

- If there are staged files, only these files will be included in the Git diff.
- Otherwise:
  - If you are using the [Standard Window](../GUI/Standard-Window.md), the Git diff will automatically include all your untracked files.
  - If you are using the [Log Window](../GUI/Log-Window.md) or [Working Tree Window](../GUI/Working-Tree-Window.md),
    it depends on the [Preferences](../GUI/Preferences/index.md) option: Commands -> Log and Working Tree window -> Commit View -> If nothing is staged.

### Options

By default, the generated commit message will be inserted at the current cursor location. However, the interaction between the existing commit message, any modifications you make, and the AI-generated message depends on various options:

#### On Manual Intervention

- **Stop** will stop an active commit message generation upon any manual intervention (typing text or changing the cursor location)
- **Continue in Background** will allow the commit message generation to continue and store the AI message in a buffer instead of displaying it immediately. A buffered message will cause the AI button icon to blink green, providing options when clicked to proceed with the message.
- **Continue with Description** will continue writing the commit description as long as you are only writing the subject line (first line). This allows concurrent editing of the subject and description. This mode is especially efficient when used with `Submit on Focus`. 

#### Automatic Triggers

The following options require the `autoTransferOptions` Git config to be configured (see below).
These options aim to improve concurrency between you and the AI working together and reduce delays where you would have to wait for the AI to complete its operation.

- **Submit on Stage** will (re-) submit the currently staged Git diff as soon as files (or parts of files) are staged or unstaged.
- **Submit on Focus** will submit the current Git diff once the Commit Message text area receives the focus and is empty (in the case of staged changes, these will have precedence).

By default, the commit message description is wrapped at 72 characters.
Wrapping can be disabled using the [Low-level property](../GUI/AdvancedSettings/Low-Level-Properties.md) `ai.commitMessageGeneration.wrapDescription`.

### Error Handling

If errors occur during the interaction with the AI, the icon will display a red cross, and additional error details will be provided in a tooltip.

## Commit Message Rewording

SmartGit can optionally reword messages for commits that have not yet been pushed (see hamburger menu); the mechanism is the same as for the Commit Message Generation, and the same configuration is utilized.

There are two different operational modes here:

- Rewording `@ai` messages: For commits containing `@ai` in their message, the `@ai` marker will be replaced by an AI-generated message.
- Rewording `WIP` messages: For commits with the message exactly as `WIP` (or `wip`), the message will be replaced by an AI-generated message and prefixed with `WIP: `.

[Low-level properties](AdvancedSettings/Low-Level-Properties.md) `ai.commitMessageRewording.*` can be used to customize this process.

## Supported Services

SmartGit supports integration with the following AI services:

**Cloud-based Services:**
- [GitHub Models](https://github.com/marketplace/models)
- [OpenAI](https://platform.openai.com/docs/overview)
- [Anthropic](https://www.anthropic.com/)

**On-premise/Self-hosted Services:**
- [Ollama](https://ollama.com/)

## Configuration

You can configure AI settings in your repository's `.git/config` or your global `.gitconfig`.
A minimal setup looks like this:

```
[ai-commit-message "..."]
    llm = ...

[ai-llm "..."]
    type = ...
    url = ...
    model = ...
```

`ai-llm` configuration is a general-purpose configuration independent of the specific application.
`ai-commit-message` links to a specific `llm` and contains configuration for the specific application of generating commit messages.

### `ai-llm` Configuration Options

Each `ai-llm` entry has an _id_ that will be linked from other configuration sections using the `llm` key and can have the following specific settings:

#### type (mandatory)

Defines the service type. Available options:
- `github`
- `openai`
- `anthropic`
- `ollama`

#### url (mandatory)

Indicates the API's root URL.
They are pre-defined for cloud services; verify with your administrator for self-hosted services.

#### model (mandatory)

Specifies the model name as recognized by the service, e.g., `o3-mini` for OpenAI's corresponding model.

#### apiKey (partially mandatory, depending on the type)

The API key required to authenticate with the service's API. API keys are typically necessary for cloud services:

- [Generate OpenAI API Key](https://platform.openai.com/settings/organization/api-keys)
- [Generate Anthropic API Key](https://console.anthropic.com/settings/keys)

For the _GitHub Models_, GitHub provides [free, rate-limited access to certain models](https://docs.github.com/en/github-models/prototyping-with-ai-models#rate-limits).
Once you have set up SmartGit's [GitHub Integration](./GitHub-integration.md), you can begin using these models with minimal configuration (see below).
If you have a paid GitHub Copilot subscription, you’ll have access to more models.
Check the available [GitHub Models](https://github.com/marketplace/models).

#### parameters

Allows additional model-specific parameters defined in JSON format (see examples below).

#### enabled

Can be used to forcefully disable the usage of this configuration; this is especially useful when defining LLMs in your global `~/.gitconfig`.

### `ai-commit-message` Configuration Options

An `ai-commit-message` corresponds to a _commit message generation_ option as available on the GUI.
Each entry has an _id_ that will be used for display on the GUI and can have the following specific settings:

> #### Note
>
> `ai-commit-message` can be configured explicitly to allow further customization. For convenience, you can omit their configuration. If there is no `ai-commit-message` entry present, SmartGit will automatically create default configurations for every configured `ai-llm` entry.

#### llm (mandatory)

Link to the LLM to be used.

#### mode

Defines the mode of how the generated commit message will be applied to the existing commit message (if present):

- `merge` will _merge_ both messages. How this is done depends on the above _On Manual Intervention_ options.
- `replace` will forcefully replace the existing message with the generated message. The old message will be stored in the commit message history (see hamburger menu).
- `prefix-selection` will prefix the existing commit message with the generated message. This is especially useful if your prompt is not exactly about commit message generation, but possibly about a specific part of the message (see examples below).

#### maxDiffSize

Sets the maximum permitted Git diff size for AI submission, defaulting to a conservative value to avoid inadvertently sharing large parts of your codebase. Ensure it remains within the model's context window size; otherwise, parts of your diff won't be processed, and/or the model may return confusing results.

#### prompt and promptFile

By default, SmartGit sends a predefined prompt for the commit message generation, which may evolve over time based on user feedback.
The `prompt` option allows you to customize the default AI prompt used for generating commit messages for experimentation or tailored message styles.
The prompt may include one or more of the following variables:

- `${gitDiff}` - this variable will be substituted with the actual Git diff
- `${commitMessage}` - this variable will be substituted with the current commit message

For large prompts, writing them in a Git config file may be cumbersome due to the syntax.
In such cases, you may consider placing the prompt into a separate file using `promptFile`.
Resolution of paths follows the same logic as the [Git Config Includes](https://git-scm.com/docs/git-config#_includes).

#### debug

Enable logging of communication with the AI by setting `debug = true`.
Logs will be saved to [SmartGit's settings directory](../Installation/Installation-and-Files.md#default-path-of-smartgits-settings-directory) following a specific naming pattern beginning with `ai-`.

#### enabled

Can be used to forcefully disable the usage of this configuration; this is especially useful when defining LLMs in your global `~/.gitconfig`.

### Global Configuration Options

Global settings apply to all AI configurations. For the `ai-commit-message` category, the following are configured as follows:

```
[ai-commit-message]
   option = value
   ...
```

#### autoTransferOptions

Set `autoTransferOptions = true` to enable additional, potentially resource-intensive options in the Commit Message button popup, see above.

### Global versions of local options:

For the following entry-specific options, as described above, their global counterparts will also be honored:

- `maxDiffSize`
- `enabled`
- `debug`

## Example Configurations

Below configurations will work out-of-the-box once you have entered your `apiKey`.

### GitHub gpt-4o-mini

```
[ai-llm "gh-4o-mini"]
    type = github
    model = gpt-4o-mini
    url = https://models.inference.ai.azure.com
```

### GitHub o3-mini

> #### Note
>
> As of February 2025, advanced models such as `o3-mini` will require a GitHub Copilot Business Account.

```
[ai-llm "gh-o3-mini"]
    type = github
    model = o3-mini
    url = https://models.inference.ai.azure.com
```

### Mistral codestral

```
[ai-llm "codestral"]
	type = mistral
	model = codestral-latest
	url = https://api.mistral.ai/v1
	apiKey = ...
```

### OpenAI o3-mini

```
[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    apiKey = ...
```

### OpenAI o1-mini

```
[ai-llm "o1-mini"]
    type = openai
    model = o1-mini
    url = https://api.openai.com/v1
    apiKey = ...
```

### OpenAI GPT-4o

```
[ai-llm "gpt-4o"]
    type = openai
    model = gpt-4o
    url = https://api.openai.com/v1
    apiKey = ...
```

### Anthropic Claude Sonnet 3.5

```
[ai-llm "Claude 3.5"]
    type = anthropic
    model = claude-3-5-sonnet-20241022
    url = https://api.anthropic.com/v1
    apiKey = ...
```

## Advanced Example Configurations

Below configurations provide examples for custom AI services and/or illustration of advanced options.
They require specific adjustments to get working configurations.

### DeepSeek on Ollama with Debugging

```
[ai-llm "DeepSeek R1 70B"]
    type = ollama
    model = deepseek-r1:70b
    url = ...
```

### Custom Prompt with OpenAI o3-mini

```
[ai-commit-message "o3-mini"]
    llm = o3-mini 
    promptGenerateCommitMessage = \
      Summarize the following Git diff in one concise sentence:\n\
      \n\
      Use imperative language.\n\
      Provide only the commit message without any explanatory notes.\n\
      \n\
      ${gitDiff}

[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    apiKey = ...
```

### OpenAI o3-mini "high"

```
[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    apiKey = ...
    parameters = "{ \"reasoning_effort\" : \"high\" }"
```

### Proofreading using GPT-4o

```
[ai-commit-message "gpt-4o proofread"]
  llm = gpt-4o
  mode = replace
  prompt = \
    Correct typos and grammar in the markdown following AND stay as close as possible to the original AND do not change the markdown structure AND preserve the detected language AND do not include additional comments in the response, but purely the correction:\n\
    \n\
    ${commitMessage}

[ai-llm "gpt-4o"]
    type = openai
    model = gpt-4o
    url = https://api.openai.com/v1
    apiKey = ...
```

### Verification using o3-mini

```
[ai-commit-message "o3-mini verify"]
    llm = o3-mini
    mode = prefix-selection
    prompt = \
      Please examine the provided commit message whether it is an appropriate description of the provided Git diff.\n\
      Just response with "[GOOD]", "[ACCEPTABLE]" or "[BAD"].\n\
      \n\
      Commit Message:\n\
      \n\
      ```\n\
      ${commitMessage}\n\
      ```\n\
      \n\
      Git Diff:\n\
      \n\
      ${gitDiff}

[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    apiKey = ...
```

Alternatively, using `promptFile`:

```
[ai-commit-message "o3-mini verify"]
    llm = o3-mini
    mode = prefix-selection
    promptFile = .gitai-commit-message

[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    apiKey = ...
```

The file `.gitai-commit-message` would be located next to the Git configuration file and contain the following content:

~~~
Please examine the provided commit message whether it is an appropriate description of the provided Git diff.
Just response with "[GOOD]", "[ACCEPTABLE]" or "[BAD"].

Commit Message:

```
${commitMessage}
```

Git Diff:

${gitDiff}
~~~
