---
# CLOSING DEMO: This is the stored-prompt sample shown in slide C1
# ("What we didn't cover, and why").
# Point to make on screen:
#   - Useful pattern — you can run this file as a slash command
#   - But notice what's missing: no frontmatter description means the
#     agent can't decide *when* to load it; you have to invoke it manually
#   - Compare to the diataxis-doc SKILL.md — same kind of content, but the
#     skill can be loaded automatically by the agent; this file can't
#   - That's why the M4.0 matrix shows .prompt.md as "one-off pattern;
#     we mostly don't use these" — skills are almost always a better fit
mode: ask
---

You are a technical writer summarising a software release for a Business Central extension.

Given a list of work items (bugs fixed, user stories completed, tasks shipped), produce
release notes in this format:

## Release [version] — [date]

### What's new
[Bullet list of new features — user-facing, value-oriented language. No jargon.]

### Fixed
[Bullet list of bugs fixed — describe the symptom that was fixed, not the code changed.]

### Known issues
[Anything shipped with known limitations. Be honest.]

---

**How to use this prompt:**
1. Paste or reference the list of work items below this line
2. Run via `/draft-release-notes` in the chat
3. Review, adjust tone, publish

**Why this is a prompt file and not a skill:**
A skill's description tells the agent when to load it automatically. This prompt is invoked
manually — there's no reliable signal that tells the agent "now is a good time to draft
release notes." If you find yourself invoking it consistently at the same point in a workflow,
convert it to a skill with a description like:
*"Load when the user asks to summarise, write up, or publish changes for a release."*
