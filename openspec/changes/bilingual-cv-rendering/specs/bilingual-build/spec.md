# bilingual-build Specification

## Purpose

Define explicit bilingual CV rendering entrypoints and safe build behavior.

## Requirements

### Requirement: Explicit Language Builds

The system MUST provide dedicated Spanish and English LaTeX entrypoints and MUST generate language-matched PDF outputs.

#### Scenario: Render one language

- GIVEN Spanish and English entrypoints exist
- WHEN the user requests one language build
- THEN the matching entrypoint is compiled
- AND only the matching PDF output is produced

#### Scenario: Render both languages

- GIVEN both language entrypoints are available
- WHEN the user requests both builds
- THEN the system compiles Spanish and English separately
- AND produces `resume-es.pdf` and `resume-en.pdf`

### Requirement: Safe Rendering Invocation

The system MUST expose explicit rendering actions for Spanish, English, and both, and MUST NOT compile or open PDFs as a side effect of loading the R script.

#### Scenario: Load build script safely

- GIVEN the build script is sourced or parsed
- WHEN no render action is invoked
- THEN no compilation starts
- AND no PDF viewer is opened

#### Scenario: Reject implicit build behavior

- GIVEN the user has not selected a render action
- WHEN the build automation is evaluated
- THEN the system MUST require an explicit language choice or explicit both-build action
