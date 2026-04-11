# Project Guide for Agents

- Always adhere to the writing rules in STYLEGUIDE.md.

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
