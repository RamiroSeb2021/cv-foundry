---
name: cv-latino-english-translator
description: "Trigger: traducir CV, Spanish to English CV, resume translation, Latino English. Translate technical CV content into natural professional English."
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Activation Contract

Load this skill when translating Spanish CV/resume content, LinkedIn profile text, technical experience bullets, education, skills, summaries, or project descriptions into English.

## Hard Rules

- Preserve facts, dates, metrics, titles, tools, institutions, and technologies; never invent achievements.
- Produce professional English that sounds natural for a Latin American technical professional, not over-polished corporate native-speaker prose.
- Keep technical terms precise: translate role impact and responsibilities, but preserve canonical tool names and acronyms.
- Prefer concise resume language with action verbs, measurable outcomes, and ATS-friendly terms.
- Flag ambiguous Spanish instead of silently guessing.
- Do not translate names, universities, companies, products, package names, file paths, or URLs unless the user explicitly asks.

## Decision Gates

| Situation | Action |
|---|---|
| Technical term has a standard English equivalent | Use the standard industry term. |
| Spanish title has no exact English match | Translate for function and add a short note if nuance is lost. |
| Input is too informal for a CV | Elevate register while keeping the speaker credible and human. |
| Claim sounds exaggerated or unclear | Keep the claim conservative and add a translator note. |
| LaTeX content is provided | Preserve commands, braces, escaping, and section structure. |

## Execution Steps

1. Identify target audience: recruiter, academic, data/tech hiring manager, or general professional.
2. Translate section by section, preserving original structure and technical keywords.
3. Improve clarity only where it strengthens CV readability without changing meaning.
4. Run a tone pass: professional, direct, Latin American bilingual voice, no stiff literal Spanish calques.
5. Return translator notes only for ambiguity, changed nuance, or recommended alternatives.

## Output Contract

Return the translated English text first. Then include a short `Notes` section only when there are ambiguities, terminology choices, or CV-impact suggestions.

## References

- `references/technical-cv-style.md` — tone, terminology, and examples for technical CV translation.
