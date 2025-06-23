# AI Integration

This article describes how to configure SmartGit to integrate with supported AI services and tailor tokenization and prompting to suit the needs of your organization and repository.

- [Supported Services](#supported-services)
- [Git configuration settings](#configuration)
- [Configuration Best Practices](#configuration-best-practices)
- [Example LLM Model Configurations](#example-configurations)
- [Advanced Example Configurations](#advanced-example-configurations)

Once AI integration has been configured correctly, please refer to 
  - [AI Assisted Commit Messages](../GUI/AI-Commit-Messages.md) for usage within SmartGit.
  - [AI Commit Message Tutorial](../GUI/AI-Commenting-Tutorial.md) for quickstart tutorials on using SmartGit's AI Commenting features.

#### Note
>
> AI integration in SmartGit is experimental in version 25.1 and may be subject to change in future updates.

## Supported Services

SmartGit supports integration with the following AI services:

**Cloud-based Services:**
- [GitHub Models](https://github.com/marketplace/models)
- [OpenAI](https://platform.openai.com/docs/overview)
- [Anthropic](https://www.anthropic.com/)
- [Mistral](https://mistral.ai/)

**On-premise/Self-hosted Services:**
- [Ollama](https://ollama.com/)

## Configuration

AI settings can be configured in a repository's local `.git/config`file, user (global) `.gitconfig` file, or your system-wide `.gitconfig` files.

#### Tip
> SmartGit shows the location of the user and system git config files on your file system in the **Edit \| Preferences \| Commands \| Git Config** [preferences settings](../GUI/Preferences/Commands.md).

#### Note
> SmartGit will automatically detect and reload changes made to the local repository's `.git/config` file.
> However, you may need to restart SmartGit for changes to take effect in the user or system git configuration files.

A minimal setup in a git configuration file contains an `ai-llm` section like this:

```
[ai-llm "<id>"]
    type = <type>
    url = <url>
    model = <model>
```

Optionally, a commit message section allows customization of SmartGit's commit message ai features.

```
[ai-commit-message "<name>"]
    llm = <id>
```

Where:
- `ai-llm` configuration is a general-purpose configuration used across all SmartGit AI features.
- `ai-commit-message` links to a specific `llm` section (via the _id_ key) and contains configuration specifically for SmartGit's AI-generated commit message features.

Suppose you don't provide any _ai-commit-message_ sections. In that case, SmartGit will display the available _ai-llm_ and assume default settings, such as prompts, when invoking the LLM for commit message generation.

### `ai-llm` Configuration Options

Each `ai-llm` configuration section has an _id_ that can be linked from other configuration sections using the `llm` key, and can have the following specific settings:

#### type (mandatory)

This identifies the service type, which allows SmartGit to integrate via API with the correct protocol. Available options:
- `github`
- `openai`
- `anthropic`
- `ollama`
- `mistral`

#### url (mandatory)

The `url` setting indicates the AI service's API's root URL.
They are pre-defined for cloud services; verify with your administrator for self-hosted services.

- **GitHub** -  `https://models.github.ai/inference`
- **Anthropic** - `https://api.anthropic.com/v1`
- **OpenAI** - `https://api.openai.com/v1`
- **Azure** - `https://models.inference.ai.azure.com`
- **Mistral** - `https://api.mistral.ai/v1`

#### model (mandatory)

Specifies the model name as recognized by the service, e.g., `gpt-4.1` for GPT 4.1 or `o3-mini` to select between the corresponding models.
Please consult your LLM service provider for a list of models offered.

#### Note
> - Pricing for commercial AI services varies depending on factors such as the model type selected, the size of the prompt, 
>   the size of the diff submitted, and the volume of output generated.
> - Some hosting services may require an LLM vendor prefix, e.g., `openai/gpt-4.1`, which would be an example of a GitHub model selection.

#### urlQueryParams

The _urlQueryParams_ allows you to specify additional URL query parameters which should be appended to the final endpoint.

#### parameters

The _parameters_ setting allows for additional model-specific parameters defined in JSON format (see examples below).

#### enabled

Can be used to disable the usage of this LLM configuration forcefully; this is especially useful when defining LLMs in your global `~/.gitconfig`.

### `ai-commit-message` Configuration Options

An `ai-commit-message` corresponds to a _commit message generation_ option as available on the GUI.
Each entry has an _id_ that will be used for display on the GUI and can have the following specific settings:

> #### Note
>
> The `ai-commit-message` can be configured to allow further customization. For convenience, you can omit their configuration. 
> If there is no `ai-commit-message` entry present, SmartGit will automatically create default configurations for every configured `ai-llm` entry.

#### llm (mandatory)

Link to the LLM to be used.

#### mode

Defines the mode of how the generated commit message will be applied to an existing user-supplied commit message (if present):

- `merge` will _merge_ both messages. This is done depending on the opetions mentioned above under _On Manual Intervention_.
- `replace` will forcefully replace the existing message with the generated message. 
   The old message will be stored in the commit message history (see hamburger menu).
- `prefix-selection` will prefix the existing commit message with the generated message. 
   This is especially useful if your prompt is not exactly about commit message generation, but possibly about a specific part of the message (see examples below).

#### maxDiffSize

Sets the maximum permitted Git diff size for AI submission, defaulting to a conservative value to avoid inadvertently sharing large parts of your codebase. 
Ensure it remains within the model's context window size; otherwise, parts of your diff won't be processed, and/or the model may return confusing results.

#### diffContextLines

Sets the number of diff context lines to be used when generating diffs (`git diff --unified=<n>`). If not specified, Git's default will be used. 

#### prompt and promptFile

By default, SmartGit sends a predefined prompt for the commit message generation, which may evolve based on user feedback.
The `prompt` option allows you to customize the default AI prompt used for generating commit messages, enabling experimentation or tailoring message styles.
The prompt may include one or more of the following placeholder variables:

- `${gitDiff}` - this variable will be substituted with the actual Git diff
- `${commitMessage}` - this variable will be substituted with the current commit message

For large prompts, writing them in a Git config file may be cumbersome due to the syntax.
In such cases, you may consider placing the prompt into a separate file using `promptFile`.
The resolution of paths follows the same logic as the [Git Config Includes](https://git-scm.com/docs/git-config#_includes).

#### debug

Enable logging of communication with the AI by setting `debug = true`.
Logs will be saved to [SmartGit's settings directory](../Installation/Installation-and-Files.md#default-path-of-smartgits-settings-directory), 
following a specific naming pattern beginning with `ai-`.

#### enabled

This setting can be used to disable the use of this configuration forcibly; this is especially useful when defining LLMs in your user `~/.gitconfig` file.
If all _ai-commit-message_ configurations are disabled, the AI button above the **Commit View** in SmartGit will be hidden.

#### apiKey

By default, SmartGit will prompt you for the [API Key](#api-keys) and save it in its password store. Alternatively, you can configure the API key in plain text here.

### Global Configuration Options

Suppose you provide an _ai-commit-message_ section with no _<name>_ value. In that case, any settings beneath it will be regarded as global settings
and will be applied to all other _ai-commit-message_ configurations.

```
[ai-commit-message]
   option = value
   ...
```

The following settings can be placed in the global _ai-commit-message_ section:

- `maxDiffSize`
- `enabled`
- `debug`

#### API keys

API keys are typically required for API authentication when using commercial, secured on-premises, or cloud services that enforce access control.

Please consult your LLM service provider's instructions on how to obtain an API key for their API, for example:

- [Generate OpenAI API Key](https://platform.openai.com/settings/organization/api-keys)
- [Generate Anthropic API Key](https://console.anthropic.com/settings/keys)

For the _GitHub Models_, GitHub provides [free, rate-limited access to certain models](https://docs.github.com/en/github-models/prototyping-with-ai-models#rate-limits).

Once you have set up SmartGit's [GitHub Integration](./GitHub-integration.md), you can begin using these models with minimal configuration (see below).

If you have a paid GitHub Copilot subscription, you’ll have access to additional models.
Please refer to this link for available [GitHub Models](https://github.com/marketplace/models).

## Configuration Best Practices

- If you wish to enable AI integration for multiple repositories, it's advisable to include a common core configuration in your user `~/.gitconfig` file.

- However, you may find it better to leave the `ai-commit-message` configurations in your repository's `.git/config` files,
  as this will allow you to fine-tune prompts and other settings specific to each repository.

- As more elaborate configurations may consist of multiple sections and values, it is good practice to place this core configuration into a dedicated file, 
  such as `~/.gitai`, and include this file from your `~/.gitconfig`:

```
[include]
    path = ~/.gitai
```

Custom _prompt_ files should also be located in your Git HOME directory. For example, your Git home directory may contain:

```
.gitconfig        # includes .gitai
.gitai            # contains the core configuration (ai-llm and ai-commit-message)
.gitai-prompt-foo # custom prompt
.gitai-prompt-bar # another custom prompt
...
```

If the AI integration should apply to every local clone, the above configuration is sufficient.
If you prefer to enable the integration selectively for certain repositories, extend your core configuration in `~/.gitai` by setting the integration to be disabled by default:

```
[ai-commit-message]
   ...
   enabled = false
```

Then, for each repository where the integration should be enabled, add the following to its respective `.git/config`:

```
[ai-commit-message]
   enabled = true
```

## Example Configurations

The below configurations should work out of the box.
Where indicated, you will need to provide your `apiKey` to use this LLM provider model.

### GitHub gpt-4o-mini

```
[ai-llm "gh-4o-mini"]
    type = openai/github
    model = gpt-4o-mini
    url = https://models.github.ai/inference
```

### GitHub o3-mini

> #### Note
>
> As of February 2025, advanced models such as `o3-mini`, will require a GitHub Copilot Business Account.

```
[ai-llm "gh-o3-mini"]
    type = openai/github
    model = o3-mini
    url = https://models.github.ai/inference
```

### Mistral codestral

The list of available Mistral models can be [found here](https://docs.mistral.ai/getting-started/models/models_overview/).

```
[ai-llm "codestral"]
	type = mistral
	model = codestral-latest
	url = https://api.mistral.ai/v1
```

### OpenAI o3-mini

```
[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
```

### OpenAI o1-mini

```
[ai-llm "o1-mini"]
    type = openai
    model = o1-mini
    url = https://api.openai.com/v1
```

### OpenAI GPT-4o

```
[ai-llm "gpt-4o"]
    type = openai
    model = gpt-4o
    url = https://api.openai.com/v1
```

### Anthropic Claude Sonnet 3.5

```
[ai-llm "Claude 3.5"]
    type = anthropic
    model = claude-3-5-sonnet-20241022
    url = https://api.anthropic.com/v1
```

### Custom GPT-4o instance at Microsoft Azure

```
[ai-llm "testing"]
    type = openai
    model = gpt-4o
    url = https://{your-resource-name}.openai.azure.com/openai/deployments/gpt-4o
    urlQueryParams = "api-version=2023-05-15"
    enabled = true
```

## Advanced Example Configurations

The configurations below provide examples of custom AI services and/or illustrations of advanced options.
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
    prompt = \
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
```

### OpenAI o3-mini "high"

```
[ai-llm "o3-mini"]
    type = openai
    model = o3-mini
    url = https://api.openai.com/v1
    parameters = "{ \"reasoning_effort\" : \"high\" }"
```

### Proofreading using GPT-4o

```
[ai-commit-message "gpt-4o proofread"]
  llm = gpt-4o
  mode = replace
  prompt = \
    Correct typos and grammar in the markdown following AND stay as close as possible to the original \n\
    AND do not change the markdown structure AND preserve the detected language AND do not include additional comments in the response, \n\
    but purely the correction:\n\
    \n\
    ${commitMessage}

[ai-llm "gpt-4o"]
    type = openai
    model = gpt-4o
    url = https://api.openai.com/v1
```

### Verification using o3-mini

This example will attempt to determine whether the user has provided a commit message that corresponds to the actual diff being committed.

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

### Commit Message with Additional Hints using GPT-4.5-preview

```
[ai-commit-message "generate [gpt-4.5-preview]"]
    llm = gpt-4.5-preview
    promptFile = .gitai-sg-with-hints-prompt
[ai-llm "gpt-4.5-preview"]
    type = openai
    model = gpt-4.5-preview
    url = https://api.openai.com/v1
```

The file `.gitai-sg-with-hints-prompt` would be located next to the Git configuration file and contain the following content:

~~~
Generate a concise and clear commit message (max 70 characters for the subject line) based on the provided code changes. Do not include prefixes such as "fix:" or "feat:". If the changes are complex or significant, add further explanation in one or two additional sentences.

If any hints are provided (inside the triple backticks), use them to guide or refine the commit message. The hints may sometimes be empty.

### Hints:
```
${commitMessage}
```

### Code changes:
```
${gitDiff}
```
~~~
