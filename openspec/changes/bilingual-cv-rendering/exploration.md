## Exploration: bilingual-cv-rendering

### Current State
The CV is a single Spanish LaTeX document. `resume.tex` defines document configuration, personal information, bibliography path `cv/references.bib`, then imports section files directly from `cv/`: `summary.tex`, `skills.tex`, `experience.tex`, `education.tex`, `languages.tex`, and after `\newpage`, `interests.tex`.

Content and layout are currently coupled: `resume.tex` owns the global template and section order, while each `cv/*.tex` file contains Spanish section titles and body text using macros from `russell.cls` such as `\cvsection`, `\cvskill`, `\cventry`, and `\cvsubsection`. `Compilar_Archivos.R` exposes `compilar_cv(path_, main_tex = "resume.tex", open_pdf = TRUE)`, compiles via `tinytex::latexmk(engine = "xelatex", clean = TRUE)`, and derives output PDF name from `main_tex`; however, the file also calls `compilar_cv(...)` at top level, so `Rscript Compilar_Archivos.R` compiles immediately and may open the PDF through `xdg-open`/`browseURL`.

### Affected Areas
- `resume.tex` — current single-language entrypoint; imports `cv/*.tex` directly and points bibliography to `cv/references.bib`.
- `cv/*.tex` — current Spanish content source; likely source material for `cv/es/*.tex` and translated `cv/en/*.tex`.
- `cv/references.bib` — currently under `cv/`; should either remain shared or move to a shared path so both language entrypoints can reference the same bibliography without duplicating facts.
- `Compilar_Archivos.R` — compile helper already accepts `main_tex`; needs safer render commands for both language entrypoints and a guarded top-level execution path to avoid unwanted PDF opening.
- `paquetes_Necesarios.R` — dependency installer has top-level install side effects; not part of bilingual rendering, but must not be used as routine verification.
- `.opencode/skills/cv-latino-english-translator/SKILL.md` — must be used during the later translation step to preserve LaTeX structure and facts, and to flag ambiguity instead of guessing.

### Approaches
1. **Duplicate full entrypoints and split content by language** — create `resume-es.tex` and `resume-en.tex`, with content in `cv/es/*.tex` and `cv/en/*.tex`.
   - Pros: clear source ownership per language; simple LaTeX imports; `compilar_cv(main_tex = "resume-es.tex")` and `compilar_cv(main_tex = "resume-en.tex")` fit the existing R API; low magic for future edits.
   - Cons: duplicates preamble/personal-info unless a shared preamble is introduced later; keeping section order synchronized requires discipline.
   - Effort: Medium

2. **Single parameterized entrypoint** — keep one `resume.tex` and select `cv/es` or `cv/en` with a LaTeX flag or generated command.
   - Pros: one canonical template and section order; less duplicated LaTeX configuration.
   - Cons: more LaTeX/R indirection; harder for a non-LaTeX maintainer to inspect; output naming and language-specific metadata become easier to break.
   - Effort: Medium

3. **Full source duplication per language** — keep independent Spanish and English root files and section trees, with no shared preamble beyond `russell.cls`.
   - Pros: fastest to implement and very explicit.
   - Cons: highest drift risk; any layout/contact fix must be repeated; creates review noise and future maintenance debt.
   - Effort: Low initially, High over time

### Recommendation
Use approach 1, but extract only if needed: create explicit language entrypoints (`resume-es.tex`, `resume-en.tex`) and language-specific content folders (`cv/es`, `cv/en`). Keep shared factual assets like `references.bib`, fonts, and `russell.cls` shared. Update the R workflow so rendering both PDFs is an intentional command, e.g. functions that call `compilar_cv(main_tex = "resume-es.tex", open_pdf = FALSE)` and `compilar_cv(main_tex = "resume-en.tex", open_pdf = FALSE)`, while guarding or removing the current unconditional top-level compile call.

For translation, the later implementation should first copy the existing Spanish section files into `cv/es` without semantic edits, then create `cv/en` by applying `cv-latino-english-translator` section by section. The translation must preserve LaTeX commands, braces, links, names, companies, institutions, dates, technologies, metrics, paths, and URLs; ambiguous Spanish should be flagged for user review rather than resolved by invention.

### Risks
- Current `Compilar_Archivos.R` top-level call can compile/open a PDF unexpectedly during verification or sourcing.
- English translations may change factual meaning if the translator is asked to polish instead of preserve facts.
- LaTeX layout may overflow in English because translated text length differs from Spanish; full PDF compilation should be an explicit verification step.
- Duplicated entrypoint preambles can drift unless shared template ownership is documented or kept minimal.

### Ready for Proposal
Yes — propose a small bilingual restructuring: preserve Spanish as the source of truth under `cv/es`, create English content under `cv/en` using the project-local translator skill, add explicit Spanish/English entrypoints, and make R render commands safe and intentional for both PDFs.
