---
# REFERENCE CHECKPOINT M4 — complete INVEST-check skill (answer key for Ex 4.1)
#
# This is the finished version of the skill you build in Exercise 4.1.
# The M4.1 fallback workflow: if your mind goes blank on what skill to build,
# build this one — it demos the lazy-load pattern cleanly.
#
# KEY POINTS to show during the M4 concept intro (skill frontmatter on screen):
#   - name: must match the directory name (invest-check)
#   - description: this is what the agent reads to decide whether to load the body
#     Be specific: "load when reviewing acceptance criteria" — not "load for requirements"
#   - The body below is NOT loaded until the agent decides it's relevant
#   - Compare to agent instructions (always loaded) and copilot-instructions.md (project-wide)
name: invest-check
description: >
  Load when reviewing, writing, or assessing acceptance criteria for a user story or
  work item. Provides the INVEST checklist and evaluation framework. Do not load for
  general requirements questions, dependency analysis, or language review.
---

# INVEST Acceptance Criteria Review

You are now running an INVEST-focused acceptance criteria review. Apply this framework
to the acceptance criteria in the current work item or requirement.

## The INVEST checklist — evaluation guide

### I — Independent

The story can be built and released without requiring another unfinished story to be done first.

**Check:** Can a developer pick this up without waiting on another team or story?
**Red flag:** "After story #42 is done, this story should also..."
**Fix:** Split, reorder, or remove the dependency. If the dependency is unavoidable, note it
explicitly as a blocking relationship in ADO — don't hide it in the story text.

---

### N — Negotiable

The story describes *what* the user needs, not *how* it should be built. The team has room
to decide the implementation approach.

**Check:** Does the acceptance criteria prescribe a UI layout, a specific table, or a
particular code approach?
**Red flag:** "The system must use a new table called 'Approval Entries'"
**Fix:** Rewrite to describe the *outcome*: "Approval history is visible on the document and
shows who approved, when, and at what amount."

---

### V — Valuable

The story delivers something a real user or the business cares about.

**Check:** Is the value explicit? Can you point to a specific user role who benefits?
**Red flag:** Technical stories written without a user benefit: "Refactor the posting codeunit"
**Fix:** Add the "so that" clause: "...so that posting completes 40% faster for month-end runs"

---

### E — Estimable

The team has enough information to size this work.

**Check:** Would a developer be able to estimate this in story points without asking more
than two clarifying questions?
**Red flag:** Acceptance criteria that reference undefined external systems, unknown data volumes,
or unresolved design decisions
**Fix:** Answer the open questions in the story before bringing it to sprint planning. A story
that can't be estimated shouldn't be in the sprint.

---

### S — Small

The story can be completed in one sprint.

**Check:** Would a single developer (or pair) be able to finish this, test it, and get it
reviewed within the sprint timebox?
**Red flag:** Acceptance criteria with more than 5–7 distinct scenarios; stories that touch
more than 2–3 base app objects; stories that span multiple user roles
**Fix:** Split the story. A good split preserves value in each piece — vertical slice,
not layer by layer.

---

### T — Testable

There is a clear, unambiguous way to verify the story is done.

**Check:** Can a tester write a test case *right now* based on the acceptance criteria alone?
**Red flag:** "The system should handle it correctly", "user-friendly", "appropriate"
**Fix:** Rewrite each criterion as a specific Given/When/Then scenario. If you can't write
the scenario, the criterion isn't testable yet.

---

## How to produce the INVEST assessment

For each principle:
1. Quote the relevant acceptance criterion (or note "no AC present")
2. Give a verdict: **Pass** / **Flag** / **Fail**
3. If Flag or Fail: one sentence on the specific problem and a concrete suggestion

End with:
```
INVEST SUMMARY:
  I: [Pass/Flag/Fail]  N: [Pass/Flag/Fail]  V: [Pass/Flag/Fail]
  E: [Pass/Flag/Fail]  S: [Pass/Flag/Fail]  T: [Pass/Flag/Fail]

Ready for sprint planning: [Yes / No — one sentence on the biggest blocker]
```
