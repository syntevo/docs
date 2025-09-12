# SmartGit AI Feature Tutorials

The following tutorials demonstrate how to use the Generative AI features in SmartGit:
- [Getting Started with AI Generated Commenting](#tutorial--getting-started-with-ai-generated-commenting)
- [Using the '@ai' placeholder to Reword Commit Messages](#tutorial--using-the-ai-placeholder-to-reword-commit-messages)
- [Using the 'WIP' placeholder to insert an AI-generated WIP commit message](#tutorial--using-the-wip-placeholder-to-insert-an-ai-generated-wip-commit-message)

## Tutorial : Getting Started with AI Generated Commenting
SmartGit can use a default configuration to connect to a free LLM (currently, the OpenAI gpt-4.1 model is hosted on the Azure AI Model Inference services), or you can provide your own configuration for any supported LLM provider and model.

For this example, we'll use the default AI Model.

1. In SmartGit, create a new Repository called 'AISample' by using **Repository \| Add or Create** from the SmartGit menu and choosing a suitable folder on your local drive.
   Click **Initialize** to create the new repository.
2. In the folder SmartGit has created, add a file named `AddNumbers.sh` with the following contents:

``` bash
#!/bin/bash

read -p "Enter first number: " num1
read -p "Enter second number: " num2

sum=$((num1 + num2))
echo "The sum is: $sum"
```

3. [Stage](Stage-Unstage-IndexEditor.md) `AddNumbers.sh` for the next commit (you can skip this step if you're using auto-staging in the **Standard Window**)

4. Instead of typing a commit message, click the ![AI](../images/AI-Commit-Button.png) button above the **Commit View**.
   As this is your first time using SmartGit's AI features in this repository, SmartGit will prompt you to select from several AI options.
   Select **Use GitHub models for this repository** so that the AI selection is only applied to 'AISample'.
   Confirm when prompted.

5. Click the **AI** button again.
   Within a few seconds, a commit message describing the changes in the new diff will be added to the **Commit View**.
   The generated message should resemble the following:
   > **Add Bash script to read two numbers and output their sum**

6. You can now accept the AI-generated commit message or tailor it as needed, then commit the changes to your repository.

### Tip
> Clicking the **AI** button when a commit message already exists will insert the AI-generated message at the current cursor position.

## Tutorial : Using the '@ai' placeholder to Reword Commit Messages

When committing, you can use `@ai` as a placeholder to combine user-generated and AI-generated comments.
SmartGit will replace the `@ai` placeholder with an AI-generated commit message, similar to the message produced by clicking the AI button.
This is useful when you need to include additional context, non-AI generated information in the commit message, such as a bug tracking ID, that is not related to the code changes.

Continuing from the example above:

1. Edit the `AddNumbers.sh` file in your Working Tree folder as follows:

```
#!/bin/bash

read -p "Enter first number: " number1
read -p "Enter second number: " number2

sum=$((number1 + number2))
echo "The sum is: $sum"
```

2. Stage the change in SmartGit.

3. In the **Commit View**, add the following commit message:
   > **TUT-1234. AI commit message: @ai**

4. Click **Commit**.
   SmartGit will detect the `@ai` token and ask if you want to enable `@ai` and `WIP` placeholder substitution.
   Click **Yes** (you'll only be prompted once).

5. The commit message (e.g., in the [Graph View](Graph-View.md)) should now resemble:
   > **PRO-1234. AI commit message: Rename variable num1 to number1 and variable num2 to number2**

## Tutorial : Using the 'WIP' placeholder to insert an AI-generated WIP commit message

Similar to the `@ai` token, SmartGit will replace a commit message which is exactly `WIP` or `wip` (meaning "Work in Progress") with an AI generated comment prefixed with `WIP:`.

Continuing in our 'AISample' repository:

1. Add a new file `DivideNumbers.sh` to the 'AISample' repository.

```
#!/bin/bash

#TODO!
```

2. Stage the new `DivideNumbers.sh` file in SmartGit.

3. In the **Commit View**, enter the following message:
   > **WIP**

4. Complete the commit by clicking the **Commit** button.

The commit message (e.g. in the [Graph View](Graph-View.md)) will be updated to reword the `WIP` placeholder with an AI-generated message similar to the below.

> **WIP: Add placeholder script DivideNumbers.sh with TODO comment**
