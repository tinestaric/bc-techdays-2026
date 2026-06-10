# Reference — Requirements Analyst Checkpoints

> **Build your own first.** This folder is the answer key. If your agent is working and
> you're keeping up with the room, you don't need this. Come here only if you're stuck and
> the room is moving on — grab the checkpoint matching where you are and continue.

---

## Which checkpoint to use

| You're stuck at... | Grab this |
|--------------------|-----------|
| Exercise 2.1 — can't get a working agent off the ground | `m2/` |
| End of M2 — agent loads but instructions feel thin | `checkpoint-m2/` |
| Exercise 2.3 — handoff button won't appear or points to wrong agent | `checkpoint-m2-handoff/` |
| End of M3 — fan-out isn't working or you're missing sub-agents | `checkpoint-m3/` |
| End of M4 — skill isn't loading or INVEST check isn't wired up | `checkpoint-m4/` |
| Ex 4.2 extension — want to see how the architecture skill turns out | `checkpoint-m4-architecture/` |

---

## How to use a checkpoint

1. Copy the `.github/` folder from the checkpoint into your own workspace root.
2. VS Code will pick up the agents and skills automatically (reload if needed).
3. **Read the agent instructions before you run it.** Each checkpoint has comments at the
   top of the file explaining what changed and why. That's the learning — don't skip it.
4. Run the agent on one of the seeded AzDevOps work items assigned to your seat.
5. When the room moves to the next module, continue building from the checkpoint's state.

---

## What's in each folder

### `m2/`

**State:** Exercise 2.1 starting point (before wiki absorption)

Agent: `requirements-analyst.agent.md`

A minimal working requirements analyst — correct frontmatter, correct tools, basic
instructions. No INVEST guidance, no wiki-sourced content. This is the floor, not the
ceiling. Run it, see it work, then do Ex 2.2 to make it good.

---

### `checkpoint-m2/`

**State:** end of Exercise 2.2

Agent: `requirements-analyst.agent.md`

This is what a wiki-absorbed requirements analyst looks like. The instructions include:
- Full INVEST assessment table (absorbed from xp123.com during the M2.2 exercise)
- Acceptance criteria checklist (from Agile Alliance user story guide)
- Language quality flags (from the Volere primer)
- Structured output format

One agent, no sub-agents, no skills. The M2 end-state.

---

### `checkpoint-m3/`

**State:** end of Exercises 3.2 and 3.3

Agents: `requirements-analyst.agent.md` (orchestrator) + four sub-agents

The orchestrator fans out to:
- `ambiguity-detector` — vague language and undefined terms
- `gap-finder` — missing acceptance criteria, personas, edge cases
- `dependency-mapper` — ADO links, sprint context, blocking dependencies
- `base-app-impact-analyzer` — BC base app objects (AL Symbols MCP)

Note that `base-app-impact-analyzer` has `user-invocable: false` — it won't appear in
the agent picker, but the orchestrator can still call it by name. That's the Ex 3.3 point.

---

### `checkpoint-m4/`

**State:** end of Exercises 4.1 and 4.2

Agents: same orchestrator as M3, updated to reference the INVEST skill
Skills: `invest-check/SKILL.md` — complete INVEST checklist, lazy-loaded

The agent's instructions now explicitly mention loading the invest-check skill when
reviewing acceptance criteria. The skill body has the full checklist content.

Compare the M3 and M4 orchestrator instructions side by side — the diff is small but
the M4.0 lesson is in it: the INVEST content belongs in the *skill body*, not in the
agent instructions, because it should only be loaded when acceptance criteria are in scope.

---

---

### `checkpoint-m2-handoff/`

**State:** end of Exercise 2.3

Agents: `requirements-analyst.agent.md` (with `handoffs:` block) + `tech-designer.agent.md`

The requirements-analyst from checkpoint-m2, extended with a single `handoffs:` block
that wires a "Create technical design" button to the tech-designer peer agent.

The tech-designer takes the analyst's output and produces: data model changes, AL objects
to create or modify, integration points, and an implementation approach.

Copy both files if you can't get the handoff button to appear.

---

### `checkpoint-m4-architecture/`

**State:** Ex 4.2 extension — architecture-context skill wired up

Agents: same orchestrator as M4, updated to load architecture-context skill when relevant
Skills: `architecture-context/SKILL.md` — C4 checklist + integration pattern flags, lazy-loaded

This is one outcome of the architecture skill exercise: the agent read the ADO wiki
architecture resources, self-assessed the skill/instructions boundary, and the skill was
created. The requirements-analyst now loads it for requirements with architectural scope.

This is the "reference" checkpoint Tine shows at the end of Ex 4.2 — what a fully assembled
architecture skill looks like.

---

## What's deliberately not here

- The documentation-writer agent and its sub-agents — those live in the root `.github/agents/`
  folder and are Tine's demo, not something you build.
- Community-built requirements agents — not in scope for this workshop.
- A Module 5 checkpoint — M5 is self-contained (tooltip task + background run).
