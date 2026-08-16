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
