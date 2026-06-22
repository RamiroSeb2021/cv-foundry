# Tasks: Bilingual CV Rendering

## Review Workload Forecast

| Field | Value |
|-------|-------|
| Estimated changed lines | 450-700 |
| 400-line budget risk | High |
| Chained PRs recommended | Yes |
| Suggested split | PR 1 layout/API → PR 2 translation → PR 3 verification/docs |
| Delivery strategy | chosen chained/stacked PR mode |
| Chain strategy | stacked-to-main |

Decision needed before apply: No — resolved to stacked-to-main chained PR slices
Chained PRs recommended: Yes
Chain strategy: stacked-to-main
400-line budget risk: High

### Suggested Work Units

| Unit | Goal | Likely PR | Notes |
|------|------|-----------|-------|
| 1 | Create bilingual source layout and safe R API | PR 1 | Entry files, `cv/es`, guarded render functions, parse check |
| 2 | Translate English content with preserved LaTeX facts | PR 2 | `cv/en/*.tex`; depends on PR 1 |
| 3 | Verify outputs and document guarded compile path | PR 3 | Manual content review, optional compile only if side effects accepted |

## Phase 1: Source Restructuring

- [x] 1.1 Create `resume-es.tex` from `resume.tex`, updating `\addbibresource` and `\input{}` paths to `cv/es/*.tex`.
- [x] 1.2 Create `resume-en.tex` mirroring the Spanish entrypoint but importing `cv/en/*.tex`.
- [x] 1.3 Move `cv/{summary,skills,experience,education,languages,interests}.tex` into `cv/es/` without changing facts or LaTeX commands.
- [x] 1.4 Decide in `resume.tex` whether to delete it or replace it with a compatibility wrapper aligned with the approved rollout.

## Phase 2: Rendering API

- [x] 2.1 Refactor `Compilar_Archivos.R` so `compilar_cv(path_, main_tex, open_pdf = FALSE)` validates the chosen entrypoint and never auto-runs.
- [x] 2.2 Add `render_es()`, `render_en()`, and `render_all()` in `Compilar_Archivos.R` returning normalized PDF path(s).
- [x] 2.3 Keep `paquetes_Necesarios.R` unchanged and document in code comments that install/compile side effects stay explicit.

## Phase 3: Translation Content

- [x] 3.1 Create `cv/en/{summary,skills,experience,education,languages,interests}.tex` by translating section-by-section with `cv-latino-english-translator` rules.
- [x] 3.2 Preserve names, dates, institutions, companies, metrics, tools, URLs, and LaTeX structure exactly across every English file.
- [x] 3.3 Flag ambiguous Spanish claims in translator notes or conservative wording before finalizing `cv/en/experience.tex`.

## Phase 4: Verification and Docs

- [x] 4.1 Run `Rscript -e "parse(file = 'Compilar_Archivos.R'); parse(file = 'paquetes_Necesarios.R')"` to verify the safe R refactor.
- [x] 4.2 Review `cv/es/*.tex` vs `cv/en/*.tex` against spec scenarios for isolated trees and translation fidelity.
- [x] 4.3 Only if side effects are explicitly accepted, run `Rscript Compilar_Archivos.R` or `render_all(open_pdf = FALSE)` and record whether `resume-es.pdf` and `resume-en.pdf` build.
- [x] 4.4 Update `openspec/changes/bilingual-cv-rendering/design.md` or implementation notes only if the `resume.tex` compatibility decision changes scope.
