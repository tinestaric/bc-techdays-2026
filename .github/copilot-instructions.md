# Workshop Workspace — Copilot Instructions

<!-- M4.0 DEMO SURFACE: "always-on, project-wide context"
     This file is the top surface on the M4.0 "Where does everything fit?" matrix.
     Every agent and every chat interaction in this workspace sees these instructions,
     always, without being asked. Put here only what every agent always needs.
     Compare to custom agent instructions (persona + scope) and skills (lazy-loaded).
-->

## What this workspace is

This is the BC TechDays 2026 workshop hands-on repository for *"Using GitHub Copilot for anything
but writing code."* It contains:

- A **sample Business Central AL extension** (`sample-app/`) — the documentation subject and
  background-agent target for the workshop exercises.
- A **documentation agent** (`.github/agents/documentation-writer.agent.md`) and its sub-agents —
  the demo-on-slides track Tine shows in each module's concept intro.
- A **reference answer key** (`reference/`) — staged checkpoints of the requirements analyst the
  room builds across Modules 2–4. Only look there if you're stuck.

## BC / AL context

- Target platform: **Business Central (BC)** — Microsoft's ERP system built on the AL language.
- AL files use the `.al` extension. Key object types: `table`, `page`, `codeunit`, `report`, `enum`,
  `pageextension`, `tableextension`.
- Field properties include `Caption`, `ToolTip`, `DataClassification`, `Editable`.
- Tooltips on fields are mandatory in AppSource extensions; a missing `ToolTip` is a validation
  warning.
- The app in this workspace has ID range starting at **50100** (workshop range, not production).

## Documentation conventions

- Documentation in this workspace follows the **Diátaxis** framework: tutorials, how-to guides,
  reference, and explanations are distinct document types with different purposes.
- Documentation lives in the `docs/` directory.
- Source of truth for BC feature behaviour is the Microsoft Learn / BC docs MCP.

## Code style

- AL field names use PascalCase with spaces quoted: `"Field Name"`.
- AL object names are descriptive: `"Workshop Feedback"`, not `WrkshpFb`.
- Comments explaining *why*, not *what*.
