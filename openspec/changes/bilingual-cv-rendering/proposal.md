# Proposal: Bilingual CV Rendering

## Intent

To support generating both Spanish and English versions of the CV, maintaining separate source files for language-specific content while sharing facts, template logic, and bibliographies. English content will be created using specific translation rules to sound natural for a Latin American technical professional without losing LaTeX structure.

## Scope

### In Scope
- Create bilingual source layout (`cv/es/*.tex` and `cv/en/*.tex`).
- Introduce explicit language entrypoints (`resume-es.tex`, `resume-en.tex`).
- Update the R rendering API to explicitly compile Spanish, English, or both, and remove the unsafe top-level execution side-effect.
- Translate existing Spanish content into English using the project-local `cv-latino-english-translator` skill, preserving LaTeX facts, metrics, and commands.

### Out of Scope
- Redesigning the CV visual style or template unless strictly required for English text overflow.
- Translating facts like names, institutions, companies, or the bibliography.

## Capabilities

### New Capabilities
- `bilingual-build`: Build process handling explicit language entrypoints (`resume-es.tex`, `resume-en.tex`) and multiple PDFs without unsafe side-effects.
- `cv-translation`: Process for generating English content from Spanish sources preserving facts and LaTeX structures per translator skill.

### Modified Capabilities
- None

## Approach

We will duplicate the main entrypoint (`resume.tex`) into `resume-es.tex` and `resume-en.tex` referencing `cv/es/` and `cv/en/` respectively. The shared template (`russell.cls`) and bibliography (`references.bib`) will be preserved. We will refactor `Compilar_Archivos.R` to expose safe `render_es()`, `render_en()`, and `render_all()` functions and remove its top-level unconditional compile. Finally, we will translate the contents using the `cv-latino-english-translator` skill.

## Affected Areas

| Area | Impact | Description |
|------|--------|-------------|
| `resume.tex` | Removed | Split into `resume-es.tex` and `resume-en.tex`. |
| `cv/*.tex` | Moved | Migrated to `cv/es/*.tex`. |
| `cv/en/*.tex` | New | English content translated from Spanish. |
| `Compilar_Archivos.R` | Modified | Top-level execution removed; safe multi-language functions added. |

## Risks

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| English text overflow | Med | Full PDF compilation verification to catch layout breaks. |
| Factual loss in translation | Low | Strict adherence to `cv-latino-english-translator` rules. |
| Accidental top-level PDF open | Low | Refactoring `Compilar_Archivos.R` to guard execution. |

## Rollback Plan

Revert the source tree to the single `resume.tex` and `cv/*.tex` structure, and restore the previous version of `Compilar_Archivos.R` from source control.

## Dependencies

- Local `cv-latino-english-translator` skill.

## Success Criteria

- [ ] `cv/es` and `cv/en` contain isolated language content.
- [ ] R script can successfully generate both `resume-es.pdf` and `resume-en.pdf` without opening them automatically.
- [ ] English translation accurately reflects the Spanish original without breaking LaTeX syntax.
