# resume

LaTeX source for my resume. The PDF is built in CI — never committed.

**[View the current resume](https://abdullahmorrison.github.io/resume/)**

## How it works

Push to `main` → GitHub Actions lints, compiles `resume.tex`, and publishes the
PDF two ways:

| Where | URL | Notes |
| --- | --- | --- |
| GitHub Pages | `https://abdullahmorrison.github.io/resume/resume.pdf` | Served as `application/pdf`, so it opens in the browser |
| Release asset | `https://github.com/abdullahmorrison/resume/releases/latest/download/resume.pdf` | Rolling `latest` tag; always downloads |

Link people to the Pages URL. Release assets are sent with
`Content-Disposition: attachment`, so browsers download them instead of rendering
them — useful as a stable archive, not for viewing.

Every run also uploads the PDF as a workflow artifact, downloadable from the
Actions tab.

## Linting and formatting

CI runs the same `make` targets you run locally, so the two can't drift.

```sh
sudo apt install chktex   # one-time; small package, no TeX Live needed

make lint         # chktex static analysis, fails on any finding
make fmt          # tex-fmt, rewrites in place
make fmt-check    # fails if not already formatted
```

`make fmt` fetches `tex-fmt` into `./bin` on first use — no sudo, no cargo.
Suppressed chktex warnings and the reason for each are documented at the top of
the `Makefile`.

## Editing

CI is the build; no local LaTeX toolchain is required. To compile locally you'd
need TeX Live:

```sh
sudo apt install texlive-full   # large; texlive-latex-extra + fonts-texgyre may suffice
make pdf
```

Required packages: `geometry`, `tgpagella`, `fontawesome`, `enumitem`, `hyperref`,
`titlesec`.

## Private variants

This repo is public. Tailored resumes I don't want indexed live in a separate
private repo.
