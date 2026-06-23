# Source Review and Provenance

This local skill was created after reviewing public Skills registry candidates, then rewritten to fit this repository and the LLM-first `skill-creator` style.

## Candidates considered

- `paramchoudhary/resumeskills@tech-resume-optimizer` — strong technical resume guidance, metrics, scale, projects, ATS balance.
- `paramchoudhary/resumeskills@resume-tailor` — useful truth-vs-tailoring boundary and job-description matching workflow.
- `paramchoudhary/resumeskills@interview-prep-generator` — useful STAR story and interview question framework.
- `claude-office-skills/skills@resume-tailor` — broader office/resume tailoring skill, but too verbose and less aligned with this repo.
- `addyosmani/agent-skills@interview-me` — excellent one-question-at-a-time intent discovery, but it targets product requirements rather than candidate interviews.
- `anthropics/knowledge-work-plugins@interview-prep` — designed for interviewer-side structured hiring, not candidate-side preparation.

## Adaptation decision

No public skill matched this repo exactly because this project needs CV writing plus bilingual/LaTeX preservation plus technical career honesty. The local skill synthesizes the useful patterns above instead of copying a full upstream skill.

## License note

The resulting local `SKILL.md` is original, repository-specific guidance. It uses MIT licensing because the closest resume-skill sources reviewed are MIT-style public skills, and this file keeps attribution in this provenance note.
