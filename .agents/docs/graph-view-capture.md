# Capture brief: How to read the graph view

The existing screenshots do not show all the concepts needed for one annotated guide.
The current `Graph-View.png` focuses on recyclable commits; `Log-window.png`, `Standard-window.png`, and `GitNotes-GraphView.png` also omit some of the required states.
In particular, there is no complete example of a signed commit, collapsed ancestry, and diverged upstream branches together.
Prepare a new real SmartGit screenshot rather than adding missing UI symbols to an existing image.

- [Deliverables](#deliverables)
- [Repository to prepare](#repository-to-prepare)
- [SmartGit display and capture](#smartgit-display-and-capture)
- [Numbered callouts and explanation text](#numbered-callouts-and-explanation-text)
- [SVG interaction and accessibility](#svg-interaction-and-accessibility)
- [Acceptance checks](#acceptance-checks)

## Deliverables

- A lossless PNG of the Graph pane, with the state below visible.
- An SVG that embeds that PNG as its backdrop and adds numbered callouts without covering the corresponding UI symbols.
- The screenshot's SmartGit version, theme, display scale, and logical dimensions.
- An HTML version of the numbered explanations for keyboard users, screen readers, touch screens, printing, and browsers with scripting disabled.

Use the heading `How to read the graph view` in `src/SmartGit/Manual/GUI/Graph-View.md`.
Keep the existing `icons-used-in-the-graph-view` anchor as an alias for old links.
Store the new assets in `src/SmartGit/Manual/GUI/images/`, with descriptive names such as `graph-view-reading-guide.png` and `graph-view-reading-guide.svg`.

## Repository to prepare

Use a disposable local repository and a local bare repository named `origin.git`.
Use real file changes for every commit, with different files on independent lines of development so the merges do not require conflict resolution.
Keep the commit subjects short enough to fit in the capture.
Do not use empty commits or a command wrapper.

Build the following history, in this order:

1. Create `main` with commits `A` (Initialize guide repository) and `B` (Prepare shared baseline).
2. Branch `feature/import` from `B` and create `I1`, `I2`, and `I3` (Add import reader, Validate import, Document import).
3. Return to `main`, create `C` (Update main readme), and merge `feature/import` with a merge commit `N` (Merge import feature).
4. Branch `feature/export` from `N` and create `F1` and `F2` (Add export option, Document export).
5. Return to `main`, create `D` (Update release notes), and merge `feature/export` with a merge commit `M` (Merge export feature).
6. At `M`, create a local branch `synced` and a tag `v1.0`.
Push `main`, `synced`, and the tag to `origin`.
Set `main` to track `origin/main` and `synced` to track `origin/synced`.
The tag and the two `synced` refs must remain at `M` for the screenshot.
7. Clone `origin.git` into a second directory to simulate a colleague.
On its `main`, create and push `R1` (Adjust server defaults), whose parent is `M`.
8. In the first working repository, keep local `main` at `M` until creating `L1` (Add local validation) and `L2` (Document local validation).
Make `L1` a genuinely signed commit using a disposable signing key configured in SmartGit.
Use the existing signed-commits documentation to configure signing; do not invent a signature icon or edit the screenshot to add one.
9. Fetch from `origin` in the first repository, without pulling, rebasing, or merging.
Local `main` must be two commits ahead of and one commit behind `origin/main`.
The branches `synced` and `origin/synced` must still point to `M` and be equal.
10. Modify a tracked file on local `main`, leaving the change uncommitted.
The Graph must show the working-tree entry and its modified status.
Do not start a merge or leave a conflict in progress for the main capture.

The resulting relationships should be:

```text
Working Tree/Index: one uncommitted change
L2  main, HEAD                 R1  origin/main
L1  signed                     |
 \_____________________________/
 M   synced, origin/synced, v1.0
 |\
 D F2
 | F1
 |/
 N
 |\
 C I3
 | I2
 | I1
 |/
 B
 A
```

`L1` and `R1` both descend from `M`; `L2` descends from `L1`.
`M` has parents `D` and `F2`; `N` has parents `C` and `I3`.
The diagram above is a preparation sketch, not an image to publish.

## SmartGit display and capture

1. Use the current SmartGit version in English, with the light theme on Windows at 100% display scale.
Use synthetic names and a local remote path; no personal data or credentials should appear.
2. Open the Log Window and its Graph pane.
Show `main`, `origin/main`, `synced`, and `origin/synced` in the graph.
Ensure `M`, `N`, `B`, and their connecting lines are all visible.
3. Keep the export side of merge `M` expanded, so the fork and both parents of a merge can be followed in context.
Collapse the import side of merge `N` using the controls available in this SmartGit version.
The actual expand control must be visible, and activating it must reveal `I1` through `I3`.
If this version cannot show that collapsed state alongside the expanded merge, record the limitation and supply a second real detail capture; do not fake the control.
4. Select `L1`, leaving `main` checked out at `L2`.
The selected-row highlight must be visibly separate from the HEAD marker.
Make the genuine signature indicator for `L1` visible using the options available in this version.
5. Widen the branch/ref area until `origin/main`, `main`, `synced`, and their tracking indicators are readable without truncation.
Keep the commit subjects and the signature indicator visible.
An author/date column is optional; unrelated notes and build-status columns should be hidden.
6. Include the Graph header and its Filter/Options controls for orientation.
Crop away unrelated file/diff panes, unused window space, and the desktop.
Aim for about 1000-1200 logical pixels wide and 500-650 pixels high, while keeping every required row readable.
7. Move the mouse away and dismiss menus and SmartGit tooltips before capturing.
Use one consistent capture for all annotations; do not assemble different repository states into a synthetic screenshot.
8. Preserve the original PNG and document its logical display size.
If captured at a device pixel ratio of 2, record both the physical PNG size and its intended half-size display dimensions.
Never enlarge the screenshot beyond its intended display dimensions; shrink it only when the available width is smaller.

## Numbered callouts and explanation text

Place each marker beside the actual feature, with a short leader line if needed.
Leave the symbol itself unobstructed.
These ten explanations replace the former separate-icon gallery:

1. **Working tree:** Point to the status icon and uncommitted-change row above `L2`.
It locates changes that have not yet become a commit.
Explain the clean/modified status in words rather than relying on icon color.
2. **Commit node:** Point to the ordinary node for `D`.
Each node represents a commit; the connecting lines lead to its parent commits.
3. **Fork:** Point to the split after `N` where the main and export histories diverge.
Two lines can share an ancestor even when one of the original branch names has since been deleted.
4. **Merge:** Point to `M` and the connections to `D` and `F2`.
A merge commit has two or more parents; following both lines shows which histories it combines.
5. **Collapsed ancestry:** Point to the actual expand control on the import side of `N`.
Explain that activating this control reveals hidden commits, rather than creating commits or changing repository history.
6. **Branches at the same commit:** Point to the `synced`/`origin/synced` label at `M`.
The equality marker means this local branch and its tracked upstream currently identify the same commit.
Explain that the label contains the branch name and, for a remote-tracking ref, its remote name.
The nearby `v1.0` label is a tag, not another commit.
7. **Ahead and behind:** Point to the tracking counts for `main` at `L2`.
There are two local commits (`L1`, `L2`) missing from `origin/main`, and one incoming commit (`R1`) missing from `main`.
This is divergence, not a claim that the working tree has unstaged changes.
8. **Upstream position:** Point to the upstream/puzzle-piece marker for `origin/main` at `R1`.
Pair it with the local marker at `L2` in the explanation.
These markers locate the two branch tips when they differ.
Remote-tracking information reflects the last fetch, not a continuous live connection to the server.
9. **HEAD and selection:** Point to the HEAD indicator beside local `main` at `L2`.
It identifies the checked-out commit; the highlighted row at `L1` is only the selection.
Selecting a row does not check out that commit.
10. **Signed commit:** Point to the genuine signature indicator for `L1`.
A signature and its verification/trust status are separate concepts.
Direct readers to the SSH signing guide for verification steps with Git; do not describe every signature marker as proof of a trusted signature.

Confirm the actual marker names, shapes, colors, and status text against the SmartGit version being captured.
If the version differs from the old icon assets, update the explanations to match the real interface.

## SVG interaction and accessibility

- Embed the PNG in the SVG, using its real aspect ratio and a matching `viewBox`.
Do not redraw Git lanes, branch labels, or missing state indicators over the screenshot.
Keep numbers and leader lines in a separate annotation layer.
- Give the figure an accessible name and a short description of the repository state.
Include a normal HTML numbered list with the full explanation of every callout immediately below the figure.
This list must be readable without hovering, without scripting, and in print.
- Provide a marker for each numbered explanation.
Use focusable links or buttons with descriptive accessible names, rather than unlabelled circles or mouse-only event handlers.
Do not assign a single image role that hides interactive descendants from assistive technology.
- Show the explanation on mouse hover and keyboard focus; also support activating the marker on a touch screen.
Make the explanation hoverable and keep it open while the pointer or keyboard focus is within the trigger or explanation.
Allow Escape to dismiss it without moving focus.
- Keep focus indicators clearly visible.
Make activation scroll to, or focus, the corresponding item in the ordinary HTML list.
A native SVG `title` can supplement the description but must not be the only source of information.
- Make the interactive targets at least 24 by 24 CSS pixels, with enough spacing between them.
On narrow screens, keep the numbered HTML list as a usable alternative to small image markers and offer a full-size image link.
Do not force readers to identify the meaning from color or hover alone.
- Keep callouts inside the figure's bounds and avoid a tooltip that obscures the feature it explains.
Use the screenshot's documented display size as a maximum and preserve its aspect ratio when shrinking.

## Acceptance checks

- All ten callouts identify actual visible SmartGit features in the captured state.
- The working tree is modified, HEAD is at `L2`, and the selected row is `L1`.
- `main` is ahead by two and behind by one; `synced` is equal to its upstream.
- An expanded fork/merge and a working collapsed-ancestry control are both identifiable.
- `L1` is genuinely signed and its signature can be verified with Git in the disposable repository.
- Desktop hover, Tab navigation, Enter/Space activation, Escape dismissal, touch activation, and the text-only fallback work.
- At 320 and 390 CSS pixels wide and at 200% zoom, the article has no unwanted horizontal overflow and the explanations remain usable.
- Screen-reader users can reach every explanation without navigating the screenshot visually.
- The PNG and SVG remain sharp at their intended size and are never enlarged to fill a wider article.
