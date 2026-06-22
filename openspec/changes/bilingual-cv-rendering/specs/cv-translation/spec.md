# cv-translation Specification

## Purpose

Define how Spanish CV content is translated into English while preserving factual accuracy and LaTeX structure.

## Requirements

### Requirement: Separate Language Content Ownership

The system MUST keep Spanish and English CV content in separate language-specific source trees while allowing shared assets and references to remain language-neutral.

#### Scenario: Maintain isolated content trees

- GIVEN bilingual CV sources are stored in the repository
- WHEN an editor updates Spanish content
- THEN the Spanish source changes in its own language path
- AND English content remains separately maintained

#### Scenario: Reuse shared facts infrastructure

- GIVEN both language versions reference common assets
- WHEN the CV is rendered
- THEN shared template logic, fonts, and bibliography MAY be reused without duplicating factual data structures

### Requirement: Translation Fidelity and Boundaries

The system MUST translate Spanish CV text into natural professional English while preserving names, dates, institutions, companies, metrics, technologies, URLs, file paths, and LaTeX commands exactly.

#### Scenario: Translate professional content faithfully

- GIVEN a Spanish CV section with technical experience and LaTeX markup
- WHEN English content is produced
- THEN the English text reads naturally for a Latin American technical professional
- AND factual content and LaTeX structure are preserved

#### Scenario: Handle ambiguous wording conservatively

- GIVEN the Spanish source contains ambiguous or exaggerated wording
- WHEN English content is prepared
- THEN the system SHOULD flag the ambiguity or keep the claim conservative
- AND MUST NOT invent achievements or altered facts
