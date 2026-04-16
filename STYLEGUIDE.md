# SmartGit Markdown style guide

This guide defines the required writing and formatting rules for Markdown files in this repository.
Its purpose is to make different authors and agent instances produce materially the same result.

## Rule priority

- `MUST` means required.
- `SHOULD` means required unless following it would clearly make the page less correct or break an established page-local pattern.
- `MAY` means optional.
- When two rules appear to conflict, the more specific rule wins.
- When no rule applies, choose the simplest structure that fits the existing page.
- Do not invent new formatting conventions that are not listed in this guide.

## Scope

- This guide applies to authored Markdown content in this repository.
- Existing legacy content may violate these rules.
- When editing an existing page, bring the touched text into compliance with this guide.
- Do not perform broad repository-wide cleanup unless the task explicitly asks for it.

## Choosing the correct section

Classify a new article by the reader's primary goal.
Use the first rule below that matches.

1. Put the article under `Integrations` if the main goal is connecting SmartGit to an external service, server, tool, or API.
2. Put the article under `GitConcepts` if the main goal is explaining a Git concept that is valid outside SmartGit.
3. Put the article under `GUI` if the main goal is explaining how to use SmartGit itself.
4. Otherwise, keep the article in its current section unless the task explicitly includes restructuring.

Apply these section-specific rules:

- `GUI` articles MUST describe SmartGit behavior, commands, views, dialogs, or workflows.
- `GUI` articles MAY link to a concept article for background, but MUST NOT contain long concept-only explanations.
- `GitConcepts` articles MUST stay tool-agnostic.
- `GitConcepts` articles MUST NOT depend on SmartGit screenshots or SmartGit-specific steps.
- `GitConcepts` articles MAY link to the SmartGit feature that implements the concept.
- `Integrations` articles MUST cover the SmartGit-side setup.
- `Integrations` articles MUST also cover external-side setup when that setup is required for SmartGit to work.

## Article structure

- Every article MUST have exactly one H1 heading.
- The H1 MUST be the first Markdown heading in the file.
- Every article MUST start with a short introduction directly below the H1.
- The introduction SHOULD be one or two short paragraphs.
- Use H2 headings for the major sections of the article.
- Use H3 headings only when an H2 section naturally contains at least two distinct subsections.
- Do not use H4 or deeper headings in normal documentation pages.
- Do not simulate headings with bold text.

Use this summary rule:

- If an article has three or more H2 sections, add a short topic summary under the introduction.
- The topic summary MUST be a bullet list of links to the H2 sections only.
- Do not include H3 links in the summary unless the task explicitly requires a deep table of contents.

If a page would need H4 headings or a very long stack of H3 sections, split the content into multiple pages instead.

## Sentences and paragraphs

- Keep sentences short and focused on one point.
- Write one sentence per physical line.
- Do not manually wrap a sentence across multiple lines unless a Markdown construct forces it.
- Separate paragraphs with one blank line.
- Add one blank line before and after lists, admonitions, code blocks, tables, and images.

## Character set and punctuation

- Use ASCII characters only.
- Use `--` instead of Unicode dash characters.
- Use `->` instead of Unicode arrows.
- Use `...` instead of the Unicode ellipsis.
- Use straight quotes `'` and `"` instead of typographic quotes.

## Capitalization and terminology

- Use sentence case for headings.
- Use normal English capitalization in prose.
- Capitalize product names, company names, and other proper nouns exactly as their official branding requires.
- Capitalize a UI term only when it is the exact visible label shown in the product.
- Do not invent special capitalization for generic concepts.

## Text styling

Use formatting based on what the text represents.

- Use bold for visible UI labels when they are not links.
- A direct link to the corresponding documentation article is sufficient formatting for a GUI label. In that case, use a normal link without bold or italics.
- If a linked GUI label is already bold or italic, remove that emphasis and keep the link.
- Use bold for unlinked windows, views, dialogs, buttons, tabs, checkboxes, menu items, and commands shown in the UI.
- Generic qualifiers such as `view`, `window`, or `dialog` MAY be included or omitted when they are not part of the exact visible label.
- If the current wording already identifies the GUI item clearly, keep the existing presence or absence of such qualifiers instead of changing it only for style.
- Use italics for abstract concepts or repository states that are not literal UI labels.
- Use backticks for shell commands, Git commands, file names, paths, branch names, refs, configuration keys, and literal values.
- Do not combine link formatting with bold or italics.

Examples:

- `**Graph**`
- `**Branches View**`
- `[Branches View](Branches-view.md)`
- `**Commit View**`
- `**Amend Last Commit**`
- `*merge commit*`
- `git fetch --all`
- `smartgit.properties`

## Menus and UI navigation

Use these formats consistently:

- For top-level menus and context menu paths, use bold text with escaped pipes: `**Local \| Commit**`.
- For navigation inside a window, dialog, or preferences page, use bold text with arrows: `**Preferences -> Commands -> Git**`.
- Do not use a raw `|` character outside code spans or code blocks.
- Do not mix `\|` and `->` inside one continuous path.
- If a workflow includes both a menu path and in-dialog navigation, describe them in two clauses or two sentences.

## Links

- Internal documentation links MUST be relative links.
- Internal documentation links MUST target the source `.md` file.
- Link to a heading anchor when the reader should land on a specific subsection.
- When writing an anchor link manually, use the lowercase hyphenated heading slug, for example `#this-is-a-topic`.
- Link text MUST describe the destination clearly.
- Link text SHOULD match the destination page title or heading text when practical.
- Do not use vague link text such as `here`, `this`, or `more`.
- Do not bold or italicize link text.
- A plain link to a GUI article is sufficient to denote the GUI item; do not add extra bold formatting just because the link text names a UI element.
- Do not link from the documentation to Syntevo or SmartGit marketing websites.
- External links MAY be used only when they point to an authoritative third-party reference that the reader genuinely needs.

## Lists

- Use an unordered list for a set of related items when order does not matter.
- Use an ordered list only when sequence matters.
- If a sentence would otherwise contain three or more parallel items, convert it to a list.
- If there are only one or two simple items, prefer normal prose.
- Keep list items grammatically parallel.
- Keep nested lists to one level at most.
- Use nested lists only when the child items are part of the parent item and cannot be expressed clearly in prose.
- Use a table only when the reader needs to compare the same columns across multiple rows.
- Do not use a table for layout or for content that would be clearer as prose or a list.

## Admonitions

Use GitHub-style admonitions for content that deserves visual emphasis.
Do not use an admonition when a normal paragraph is sufficient.

Allowed admonition types:

- `NOTE` for important supporting information.
- `TIP` for optional advice that improves the outcome.
- `WARNING` for risks, destructive actions, or easy-to-miss side effects.
- `EXAMPLE` for concrete sample input, output, or workflows.

Use this syntax:

```md
> [!NOTE]
> Description goes here.
> A second line may follow.
```

Rules:

- Put a blank line before and after each admonition.
- Do not nest admonitions.
- Keep each admonition focused on one point.

## Code blocks

- Use fenced code blocks.
- Add a language identifier whenever Markdown supports one.
- Keep commands in code blocks when the example spans multiple lines or needs exact copying.
- Keep short inline commands in backticks instead of using a code block.

## Images

- Add an image only when it materially improves comprehension.
- Prefer text, links, or a short procedure over a screenshot when they are sufficient.
- Every image MUST include meaningful alt text.
- New images MUST be stored under the relevant `images` directory, not under `attachments`.
- Existing `attachments` references are legacy content and SHOULD be replaced only when you are already updating that page with new image work.
- Image links MUST be relative to the article.
- Image file names MUST be descriptive ASCII names.
- Do not use numeric-only or opaque attachment-style file names for new images.
- Store small UI icon assets under the relevant `images/icons` directory.
- Apply the same naming, alt text, and relative-link rules to icons as to other images.

For screenshots:

- Use an English UI.
- If the article has no existing screenshot style, use the default light theme on Windows at 100% scale.
- Use a consistent theme, scale, and operating system within the same article.
- Remove personal data, credentials, repository names, and other sensitive information.
- Crop the screenshot to the relevant area.
- Use a sharp image that remains readable when rendered in the docs.

## File and folder changes

- Do not rename or move an existing article unless the task explicitly requires it.
- Do not rename or move an existing article only for stylistic reasons.
- If a topic outgrows one page, keep the original page as the landing page whenever practical.
- When splitting content into subpages, update all touched internal links to the new relative paths.
- Do not rely on redirects for internal documentation links.

## Commit rules for documentation changes

- Make one normal Git commit per requested documentation change or other coherent unit of work.
- Do not squash, amend, or rewrite history unless the task explicitly asks for it.
- Keep the commit message to a single concise subject line.
- Do not include internal ticket numbers in the commit message.
