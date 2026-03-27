# Project Guide for Agents

- Always adhere to the writing rules in STYLEGUIDE.md.
- Follow the existing docs history for commit messages.
- Prefer concise topic-led messages in sentence case.
- For Manual changes, prefer the `Manual: ...` form.
- For narrowly scoped topic files outside the Manual, `<Topic>: ...` is acceptable when it matches the existing history.
- Keep one logical topic per commit.
- When adding a new article, include the related index or navigation link updates in the same commit.

## Build And Render

- For simple Jekyll framework changes, build with
  `bundle exec jekyll build --destination /tmp/site`.
- For a full docs preview, run `./.agents/tools/build.sh`.
- Use `./.agents/tools/build.sh` when the page depends on versioned docs
  content, `src-inflated`, or Mermaid rendering.
- Write the build output to a writable temporary directory, not the repo checkout.
- Use Playwright for rendering by default; use raw Chromium only as fallback.
- Serve the built output locally and store screenshots in `/exchange`.
- Example render flow: `python3 -m http.server 1313 --bind 127.0.0.1 --directory /tmp/site` and `playwright screenshot http://127.0.0.1:1313/ /exchange/page.png`.
