---
name: bc-doc-task-review
description: >
  Use when Business Central developers need non-coding support: documenting a
  BC feature, reviewing existing docs for gaps, or validating task/work-item
  quality before implementation. Keywords: BC docs, acceptance criteria,
  backlog refinement, task review, requirement clarity, documentation QA,
  feature handoff.
argument-hint: "Feature, object, or task to process (e.g. 'Workshop Feedback: add moderation status')"
---

# BC Documentation & Task Review Workflow

Use this skill for **everything but code** in BC delivery: clear docs, sharper tasks, and safer handoffs.

## What this skill produces

Depending on the request, produce one of these outcomes:

1. **Documentation Pack** (overview, reference, usage, operations notes)
2. **Existing Docs Gap Audit** (coverage, staleness, contradictions, priorities)
3. **Task Review Report** (clarity score, risks, acceptance criteria quality, suggested rewrite)

## When to use this skill

Load this skill when the user asks to:

- document a BC feature, AL object, or behavior
- review whether current docs are good enough
- review/refine backlog tasks or work-item descriptions before coding
- check if acceptance criteria are testable and complete
- prepare implementation-ready handoff notes for BC teams

Do **not** use this skill for writing production AL code.

## Required inputs

Ask for (or infer) these inputs before starting:

- Feature/object/task name
- Source of truth (AL source, issue, work item, notes)
- Intended audience (developer, consultant, support, mixed)
- Desired output mode: `doc-pack`, `doc-audit`, or `task-review`

If output mode is not specified, choose it with this rule:
- Existing docs present and user asks "is this good?" -> `doc-audit`
- User asks "write docs" -> `doc-pack`
- User asks "is this task/requirement ready?" -> `task-review`

## Workflow

### Step 1: Intake and classification

1. Restate the requested outcome in one sentence.
2. Classify into one mode: `doc-pack`, `doc-audit`, or `task-review`.
3. List assumptions and unknowns explicitly.

### Step 2: Evidence collection

Collect concrete facts before making recommendations.

- For BC features: extract object metadata, fields, procedures, triggers, business rules.
- For docs review: inventory existing docs and map coverage by purpose.
- For tasks: parse objective, scope, dependencies, risks, and acceptance criteria.

Prefer workspace evidence first; use official Microsoft docs when needed.
Never invent behavior that is not in source.

### Step 3A: If mode = doc-pack

1. Build structure:
   - Feature Overview
   - Technical Reference
   - Usage Guide
   - Operational Notes (optional)
2. Ensure each section has only content appropriate for that section.
3. Mark open questions where source is incomplete.
4. Run a style/quality pass before finalizing.

### Step 3B: If mode = doc-audit

1. For each relevant doc, assess:
   - freshness (current / possibly stale / stale)
   - completeness (complete / partial / thin)
   - correctness risk (low / medium / high)
   - overlap risk (none / some / high)
2. Summarize missing document types (overview/reference/usage/operations).
3. Prioritize top gaps by delivery impact.

### Step 3C: If mode = task-review

Evaluate the task against this BC-ready checklist:

1. **Outcome clarity**: Is the business outcome explicit?
2. **Scope boundaries**: Are in-scope and out-of-scope clear?
3. **Testable acceptance criteria**: Can each criterion be verified objectively?
4. **Source alignment**: Does it align with current AL objects/processes?
5. **Dependencies & risks**: Are external blockers and domain risks identified?
6. **Handoff readiness**: Could a developer start without guessing?

Then return:
- PASS/BLOCKED status per checklist item
- minimal rewrite proposal for weak sections
- concrete "ready-to-implement" next steps

## Quality gates (must pass before final output)

- Evidence-backed: every key statement traceable to source
- Non-ambiguous: no vague wording like "improve" without measurable criteria
- Testable: acceptance criteria contain observable outcomes
- BC-accurate terminology: object names, field names, and actions are consistent
- Honest uncertainty: unknowns are explicit, never hidden

## Output templates

### Template A — Documentation Pack

```
DOC PACK for: [feature]
Audience: [developer/consultant/support/mixed]
Source confidence: [high/medium/low]

1) docs/features/[feature]-overview.md
- [content]

2) docs/reference/[feature]-reference.md
- [content]

3) docs/guides/[feature]-usage.md
- [content]

4) docs/operations/[feature]-notes.md (optional)
- [content]

Open Questions:
- [...]
```

### Template B — Existing Docs Gap Audit

```
EXISTING DOCS AUDIT for: [feature]
FILES FOUND: [count]
- [path] | Type: [...] | Freshness: [...] | Completeness: [...] | Risk: [...] | Gap: [...]

Coverage summary:
- Overview: [present/missing]
- Technical reference: [present/missing]
- Usage guide: [present/missing]
- Operations notes: [present/missing]

Most urgent gap: [...]
Suggested next doc to write first: [...]
```

### Template C — Task Review Report

```
TASK REVIEW for: [task]
Verdict: [Ready | Needs revision | Blocked]

Checklist:
- Outcome clarity: [PASS/BLOCKED] - [...]
- Scope boundaries: [PASS/BLOCKED] - [...]
- Testable acceptance criteria: [PASS/BLOCKED] - [...]
- Source alignment: [PASS/BLOCKED] - [...]
- Dependencies & risks: [PASS/BLOCKED] - [...]
- Handoff readiness: [PASS/BLOCKED] - [...]

Minimal rewrite:
- [...]

Ready-to-implement next steps:
1. [...]
2. [...]
3. [...]
```

## Integration notes for this workshop repo

When available, coordinate with existing agents:

- `documentation-writer` for full doc-pack orchestration
- `doc-source-reader` for source fact extraction
- `doc-existing-docs-reader` for gap audit
- `doc-style-checker` for QA before final output

If those agents are unavailable, apply this workflow directly and keep the same output contracts.
