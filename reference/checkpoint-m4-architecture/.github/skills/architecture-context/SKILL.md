---
# REFERENCE CHECKPOINT M4 — architecture-context skill (answer key for Ex 4.2 extension)
#
# This is one outcome of the architecture-skill exercise in Exercise 4.2.
# The agent read the architecture resources from the ADO wiki and self-diagnosed
# which parts belong in the skill body (lazy-loaded) vs. agent instructions (always loaded).
#
# KEY LESSON to show during the M4.2 debrief:
#   - The project stack and conventions → agent instructions (always relevant)
#   - Architecture checklists (C4 layers, integration patterns) → skill body (lazy-loaded,
#     only when the agent is doing architectural analysis, not for every work item)
#   - The skill description is the routing key: "load when requirement involves architecture"
#
# See also: checkpoint-m4-architecture/.github/agents/requirements-analyst.agent.md
name: architecture-context
description: >
  Load when a requirement involves architectural decisions, cross-module integration,
  new subsystem design, or significant BC object restructuring. Provides the architecture
  framework and key constraints for this project. Do not load for pure data entry changes,
  UI layout tweaks, or simple field additions.
---

# Architecture Context

You are now performing an architecture-aware requirements assessment. Apply this framework
alongside your standard INVEST and gap analysis.

## Architecture layers — what this project uses

This is a BC AL extension project. The architecture follows standard BC layering:

```
External systems / APIs
        ↓
   Integration layer (codeunits: communication, mapping, error handling)
        ↓
   Business logic layer (codeunits: domain rules, validation, workflows)
        ↓
   Data layer (tables, records, FlowFields)
        ↓
   Presentation layer (pages, reports, APIs)
```

When a requirement touches more than one layer, note which layers are in scope and which
are out of scope — this affects sizing and dependency mapping.

## C4 model checklist (system context + container level)

For requirements with architectural impact, ask:

**System Context (C1)**
- Which external systems are involved? (integrations, APIs, mail, file storage)
- Who are the human actors? (roles, personas, external partners)
- Is this a change to an existing integration or a new one?

**Container (C2)**
- Which BC subsystem or extension module owns this feature?
- Does this require a new table/codeunit, or extension of an existing base app object?
- Are there shared codeunits that other modules depend on — and could change here?

## Integration patterns

| Pattern | Use when | Watch for |
|---------|---------|-----------|
| Subscribe to event | Extending base app behaviour | Event signature stability; upgrade risk |
| New integration codeunit | Net-new external connection | Auth, error handling, retry logic |
| FlowField / FlowFilter | Computed values, aggregates | Performance on large datasets |
| Background processing | Long-running tasks | User feedback, error visibility, batch limits |

## Architecture red flags in requirements

Flag these patterns when they appear:

- Requirement touches base app tables without using events → likely a customisation risk
- Cross-module data reads without an explicit interface → hidden coupling
- "The system will handle" — passive voice hiding an unspecified integration
- Multiple user roles with conflicting data access in one story → should split

## Output addition

When this skill is loaded, append an **Architecture Notes** section to your assessment:

```
ARCHITECTURE NOTES:
  Layers in scope: [list]
  Integration points: [external systems or base app interfaces touched]
  Architecture flags: [patterns from above that apply]
  Recommended split: [if the requirement crosses too many layers to be one story]
```
