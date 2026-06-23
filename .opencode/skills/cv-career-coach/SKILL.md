---
name: cv-career-coach
description: "Trigger: CV writing, resume tailoring, ATS, STAR stories, interview prep. Improve truthful career material for technical roles."
license: MIT
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Activation Contract

Load this skill when improving CV/resume content, tailoring a CV to a job description, strengthening bullets, preparing STAR interview stories, or creating role-specific career material for technical/data roles.

## Hard Rules

- Preserve truth: never invent employers, titles, dates, metrics, certifications, tools, responsibilities, or outcomes.
- Treat the repository CV files as the source of truth; ask or flag gaps instead of silently filling them.
- Keep LaTeX commands, braces, escaping, URLs, and section structure intact when editing `.tex` CV content.
- Optimize for credible technical hiring: precise tools, business impact, scale, collaboration, and readable ATS keywords.
- Prefer conservative wording over inflated corporate language; every improved claim must be defensible in an interview.
- For English output from Spanish material, combine this with `cv-latino-english-translator`.

## Decision Gates

| Situation | Action |
|---|---|
| Job description is available | Extract requirements, keywords, role priorities, and risks before rewriting. |
| No target role is provided | Improve clarity and impact generically; do not over-tailor keywords. |
| Bullet lacks measurable result | Ask for the metric or use a non-fabricated impact frame. |
| Interview prep requested | Convert true CV evidence into STAR stories and likely questions. |
| Claim sounds too broad or unverifiable | Narrow it and add a note with what evidence is missing. |

## Execution Steps

1. Identify the target: general CV polish, role tailoring, bullet rewrite, LinkedIn/profile copy, or interview preparation.
2. Audit source material against the target: relevant skills, proof points, gaps, overclaims, and ATS terms.
3. Rewrite using action + scope + method + outcome where evidence exists; keep weak claims honest when evidence is missing.
4. For role tailoring, document what changed and why so the user can defend it in interviews.
5. For interview prep, build a small story bank mapped to competencies and include questions to ask the interviewer.

## Output Contract

Return the improved career text first. Then include short notes for changed emphasis, missing evidence, risks, or interview talking points; omit notes when there is nothing material.

## References

- `references/source-review.md` — public skills reviewed and adaptation notes.
- `references/career-quality-checks.md` — CV, tailoring, ATS, and interview prep checks.
