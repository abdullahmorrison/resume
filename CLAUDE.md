# Instructions for Claude

## Never push without explicit approval

Work in this repo is **local only** by default. Make the edit, commit it, then
stop and ask. Wait for the word "push" (or equivalent) before anything reaches
the remote.

This covers every way work leaves the machine:

- `git push`, including `--force` and pushing tags
- opening or merging a pull request
- creating or editing releases
- triggering workflows on the remote (`gh workflow run`, `gh run rerun`)
- changing repo settings, description, homepage, or visibility

**Why:** this repo is public, and merging here is a publish, not a sync. A merge
to `main` deploys the PDF to GitHub Pages and overwrites the `latest` release
asset, where anyone on the internet can read it.

Committing locally is always fine and needs no approval — commit freely so work
isn't lost, just don't send it.

## Never commit directly to main

Use a branch and a pull request, always.

```sh
git checkout -b <short-description>
# edit, commit
gh pr create --fill        # only once approved
```

The `protect main` ruleset enforces this server-side, with no bypass actors — a
direct push is rejected for everyone, including the repo owner. It also blocks
force-pushes and branch deletion, and requires the `lint` and `build` checks to
pass before a merge.

Pushing a *branch* is unrestricted; only `main` is protected. Opening the PR
still needs approval, per the rule above.

**Why:** the diff is not the deliverable — the rendered PDF is. A reworded bullet
can reflow a line, change spacing, or spill onto a second page, and none of that
shows up in a `.tex` diff. CI on a pull request lints, compiles, and uploads the
PDF as an artifact **without publishing anything**, so the actual document can be
reviewed before it goes live. Publishing only happens on merge.

After opening a PR, point at the artifact so the rendered resume gets a look
before merging.
