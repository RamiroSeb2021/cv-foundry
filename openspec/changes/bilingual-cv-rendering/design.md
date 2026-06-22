# Design: Bilingual CV Rendering

## Technical Approach

Split the current single-language LaTeX entrypoint into two explicit documents: `resume-es.tex` and `resume-en.tex`. Spanish content moves from `cv/*.tex` to `cv/es/*.tex`; translated English content lives in `cv/en/*.tex`. Both entrypoints keep the existing `russell.cls`, fonts, geometry, header metadata, and bibliography. `Compilar_Archivos.R` becomes a safe render API with no unconditional top-level compilation or PDF opening.

No delta spec was available during design, so this maps to the proposal capabilities `bilingual-build` and `cv-translation`.

## Architecture Decisions

| Option | Tradeoff | Decision |
|---|---|---|
| Two entrypoint files vs one parameterized `.tex` | Duplication of preamble, but simpler for LaTeX and easier to compile independently. | Use `resume-es.tex` and `resume-en.tex` because the current project is file-entrypoint based. |
| `cv/es` + `cv/en` vs suffix files in `cv/` | More directories, but clean ownership by language. | Use language directories to avoid mixing translated content with source Spanish files. |
| R wrapper functions vs top-level script execution | Requires users to call a function, but removes unsafe side effects. | Expose `render_es()`, `render_en()`, `render_all()` and keep `compilar_cv()` internal/general. |
| Translate whole LaTeX files manually vs generated pipeline | Manual work is slower, but preserves facts and avoids hallucinated rewrites. | Translate section-by-section using `cv-latino-english-translator`; preserve commands, names, dates, URLs, tools. |

## Data Flow

```text
cv/es/*.tex ──translate──> cv/en/*.tex
       │                       │
       v                       v
resume-es.tex            resume-en.tex
       │                       │
       └──── Compilar_Archivos.R ────> resume-es.pdf / resume-en.pdf
```

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `resume.tex` | Delete/replace | Replaced by explicit language entrypoints. |
| `resume-es.tex` | Create | Spanish entrypoint importing `cv/es/*.tex`. |
| `resume-en.tex` | Create | English entrypoint importing `cv/en/*.tex`. |
| `cv/summary.tex`, `cv/skills.tex`, `cv/experience.tex`, `cv/education.tex`, `cv/languages.tex`, `cv/interests.tex` | Move | Move unchanged Spanish sources into `cv/es/`. |
| `cv/es/*.tex` | Create | Spanish source of truth copied from current files. |
| `cv/en/*.tex` | Create | English translations preserving LaTeX structure and factual content. |
| `cv/references.bib` | Keep | Shared bibliography remains language-neutral unless explicitly changed later. |
| `Compilar_Archivos.R` | Modify | Remove final `compilar_cv(...)`; add safe render functions and default `open_pdf = FALSE`. |
| `paquetes_Necesarios.R` | No change | Installation side effects remain out of scope. |

## Interfaces / Contracts

```r
compilar_cv(path_ = "", main_tex, open_pdf = FALSE)
render_es(path_ = "", open_pdf = FALSE)
render_en(path_ = "", open_pdf = FALSE)
render_all(path_ = "", open_pdf = FALSE)
```

Contract: render functions return normalized PDF path(s), compile with `tinytex::latexmk(engine = "xelatex")`, and validate `russell.cls`, `fonts/`, `cv/`, and the selected entrypoint before compiling.

## Testing Strategy

| Layer | What to Test | Approach |
|-------|-------------|----------|
| Static | R syntax after API refactor | `Rscript -e "parse(file = 'Compilar_Archivos.R'); parse(file = 'paquetes_Necesarios.R')"` |
| Integration | Both entrypoints compile | Run `render_all(open_pdf = FALSE)` only when TinyTeX/build side effects are accepted. |
| Content | English preserves facts and LaTeX | Manual section review against Spanish source and translator skill rules. |

## Migration / Rollout

Move current sources to `cv/es/`, add `cv/en/`, then update entrypoints and R rendering in one review slice if under budget. Rollback is restoring `resume.tex`, `cv/*.tex`, and previous `Compilar_Archivos.R`.

## Open Questions

- [ ] Should a temporary compatibility `resume.tex` wrapper be kept for existing local habits, despite the proposal saying it is replaced?
