# SmartGit Markdown file Style Guidelines

## Sentencing and Whitespace

- Keep sentences short, focusing on a single point.
- Even where no paragraph separation is required, start sentences on a new line 
  _Rationale_ : This makes the documentation easier to maintain by future authors.
- As the content will be rendered in HTML, single newlines are removed in the final output, and tend to create large paragraphs.
- Where a paragraph break is intended, insert an additional (second) newline between paragraphs.
  _Rationale_ : Even though the sentences will be run into each other in the final output, the newline assists Markdown authors clarify the content and focus on specific points. 
-- Shorter line widths also make side by side review easier to read e.g. in GitHub pull requests.

## Character Set and Symbols

- Use ASCII characters only throughout the documentation.
- Dashes: use `--` for an em-dash effect; never use Unicode dashes (`—`, `–`, `‑`).
- Arrows: use `->`; do not use Unicode arrows (e.g. `→`).
- Ellipsis: use `...`; do not use the Unicode ellipsis (`…`).
- Quotes: use straight quotes `'` and `"`; avoid typographic quotes (`“ ” ‘ ’`).

## Deciding on whether a topic belongs under GUI, or other root folders like GitConcepts, Integration etc

### SmartGit App Commands and Actions (e.g. /GUI/Commiting.md)

- These articles describe the user interface of SmartGit, and are typically aligned to a specific SmartGit screen, view, window or feature.
- These articles can / should repeat a brief summary paragraph of the concept, with a LINK to the Concept the feature addresses, but not go into any conceptual detail.
- The objective is to ensure the user understands what the described feature is intended to do, and how to use that feature in SmartGit.

### Concepts (i.e. /GitConcepts)

- These articles are not specific to SmartGit, but provide a background to concepts needed to understand the Git ecosystem.
- Topics in the GitConcepts section need to be agnostic of SmartGit
- GitConcept articles should be ‘version’ agnostic and thus do not need to be re-checked or re-written on new releases of SmartGit
- Concept articles may have some diagrams (e.g. to showing branching concepts), but should not include screenshots of SmartGit
- Concept Articles should link to the SmartGit implementation of a concept where appropriate (e.g. to a GUI Command article)
- Bonus: Concept Articles are great for SEO, so ensure that the headings, summary and focus of the article is maintained, and be sure to link externally where a definitive / de-facto reference on a concept is available.

### Integrations

- Articles under this section are generally very technical and low-level, and are used as reference guides, examples, and step by step assistance to connecting SmartGit to an external application, service, or API.
- These articles typically involve changing or adding settings in various configuration files, or configuring 
- Many of these integrations will be once-off, so they need to be thorough enough to ensure users can complete the integration needed.
- Where applicable, include screenshots and instructions on how to configure external systems in order to allow SmartGit connectivity (e.g. setting up API keys, PAT tokens, or other necessary configurations in the external system)

## Header Usage (1,2,3)
- Only 1 x H1 per article
- Brief intro under the H1, possibly with a  table of content links
- H2s for the major sections in the article.
- H3’s for minor sections under the H2 topic
- If the H2s get too long then split the H2 into its own article
- Do NOT use Bold or Underlinked text instead of headings 
  _Rationale_ : This won’t generate an Anchor link and can’t be targeted by a hyperlink

## Menu Selection 

- Use escaped Pipe `\|` to separate successive Menu drop down menu commands and bold e.g. `Edit \| Preferences`
  _Rationale_: If you don’t escape the Pipe, when published on ?Jekyll, the Pipe is interpreted as a table separator and the content is incorrectly displayed
- Escaping is NOT needed if the content is already escaped in a code (`) block, e.g.
  ` git show-ref | grep -c refs/meta/smartgit/commits`
- Use right arrow `->` for smaller UI navigation e.g. tabs on a preferences sheet or cascading radio button toggles (e.g. `File -> Open -> New Window`)

## Reference to Major UI Elements (Including Main Windows and Views)

Use Bold

e.g. `**Standard Window**` or `**Commit View**`

## Reference to smaller UI Elements

Also bold

e.g. `**Commit**` button or `**Amend Last Commit**` checkbox

## Code or Command Line actions

Use backticks, e.g.

`git checkout -b feature/NewFeature`

## Referring to Concepts

Use Italics

i.e. when speaking about a concept which doesn’t directly translate to a UI view or command.

e.g. `*Virtual Merge Commit*` or when the repository is in a merging state.

## Capitalization

In general, try to use normal English capitalization (i.e. Capitalize the start of sentences) and Proper Nouns (London) and where branding requires it (e.g. GitHub and Bitbucket - note Atlassian’s preference for casing).

In some cases, when a word or phrase has been used to mean a ‘special’ context in the documentation, beyond it’s normal meaning, consider capitalizing it, e.g. Hosting Provider may be conceptually repurposed to refer to generic Git hosting service such as GitHub or Bitbucket).

## Notes, Warnings, Tips

Use a H4 with Quotes below, e.g.

```
#### Note / Warning / Tip
> Description goes here.
> Can be multiline
```

If there are multiple points to make under Notes / Warnings / Tips, use dashes for creating bullet points, e.g.

```
#### Note / Warning / Tip
> - Bullet Point 1
> - Bullet Point 2
```

## Links

- Use the form `[Target heading](Link)`
- Target text should match the topic of the linked article (e.g. don’t link to a vague topic which is unlikely to be in context or of use to a user reading the source article)
- Link to an anchor if possible, e.g. if the target is a H2 / H3 within the linked article.
- (For Discussion) Do not bold or italic the target text, even if it is a Window Element (e.g. no `[**Log Window**]()`]
- All link URLs must be relative and should target the raw `.md` file, not a re-written link 
  _Rationale_ : This allows us to test the links in the GitHub repo source view
- Do NOT link from the documentation to the Syntevo or SmartGit WebSites. 
- Once published, the Jekyll / Liquid templates already link both the Syntevo logo and SmartGit icon back to appropriate web sites.
  This makes it easier to maintain.

## Bullets and Numbering

Use Bullets or Numbers wherever makes sense to do so. 
Generally as soon as there are more than 2 points to be made in a paragraph, then use bullets or numbers.

## Topic Summaries

- If an article consists of more than 2 second level (i.e. H2) topics, then consider adding a brief summary introduction at the top of the article (under the H1)
- Use relative anchor links to each of the 2nd level topics (note that the link casing must be lower case and spaces are hyphenated, e.g. a link to heading 2 "This is a topic" becomes `[This is a topic](#this-is-a-topic)`
- If felt appropriate, the 3rd level topics can be indented beneath the H2 headings

e.g.

> Please refer to one of the below links
> - [Topic 1]()
>   - [Topic 1 Subtopic 1]()
>   - [Topic 1 Subtopic 2]()
> - [Topic 2]()
>   - [Topic 2 Subtopic 1]()
>   - [Topic 2 Subtopic 2]()

## Folder Structure
If an article or topic expands to such an extent that multiple article pages are required, consider creating a folder and moving the articles into a new subfolder (Rationale - this will be easier to maintain the documentation, and also will introduce navigation on BreadCrumb for the folder).

#### Note
> Changing the folder structure and file names of existing articles will impact on SEO and redirection, so needs to be done with extreme care and collaboration.
> Where an existing article will be subdivided, the original article name / link should remain as the 'landing' page with the topic, with links to the new subtopic article pages. A redirect from the old page to the new landing article inside the new folder will need to be established to maintain external navigation compatability.
> However, once a page has been moved into a subfolder, the current documentation should be scanned and updated to the new relative URL (i.e. internal navigation should NOT rely on redirection).

## Images

### Screenshots

- Use as few screenshots as possible to convey the concept in the article 
  _Rationale_ : Images place a large burden of maintenance
- Provide an Alt text description for the image for SEO and accessibility reasons.
  `![description of image](../../images/MyImage.png)`
- Images should be High DPI (TBD actual DPI)
- Need to be consistent about the font, theme and O/S for the screenshot images
- Images shall be placed under the /SmartGit/Manual/images folder
- Links to images shall be relative to the article (e.g. ../../images/FooBarBaz.png)
- Image file name should align to the description
- Where possible, replace images under the /attachments folder with a new image under the /images folder.
  _Rationale_ : The /attachments folder images were inherited from older exported Confluence documentation and use numbers in the image names, which are not ideal from a maintenance and SEO viewpoint.
- Note need to be aware of ‘where’ the images folder is relative to the current page

### Icons

(i.e. small images used in the SmartGit app)

- These are stored in the /SmartGit/Manual/images/icons folder
- Icons should generally follow the same rules as per images

## Commits into the docs Repository

- As with coding standards, should be one commit per meaningful ‘story’ or ‘feature’ or ‘bug’
- Squash and rebase as necessary if multiple commits were required (e.g. using the GitHub markdown editor can create a lot of noisy commits)

## Commit Messages

- Do NOT use ticket numbers (e.g. GitHub issue) in the commit messages (Rationale : the docs repository is visible to public users who will not have access to the internal issue tracking system)
- Keep the message concise, to one line (Rationale: easy to see what was changed in the log history)


