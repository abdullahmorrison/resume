# resume

LaTeX source for my resume. The PDF is built in CI — never committed.

## How it works

Push to `main` → GitHub Actions compiles `resume.tex` → the PDF is published as a
release asset on a rolling `latest` tag:

```
https://github.com/abdullahmorrison/resume/releases/latest/download/resume.pdf
```

That URL is stable, so [abdullahmorrison.com](https://abdullahmorrison.com) serves
`/resume.pdf` by proxying to it. Editing the resume needs no website commit and no
website rebuild — push here and the live resume updates.

Every run also uploads the PDF as a workflow artifact, so you can download the
current build straight from the Actions tab.

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

There is no local LaTeX toolchain on my machine, so CI is the build. To compile
locally you'd need TeX Live:

```sh
sudo apt install texlive-full   # large; texlive-latex-extra + fonts-texgyre may suffice
pdflatex resume.tex
```

Required packages: `geometry`, `tgpagella`, `fontawesome`, `enumitem`, `hyperref`,
`titlesec`.

## Private variants

This repo is public. Tailored resumes I don't want indexed live in a separate
private repo.
