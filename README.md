# Using GitHub Copilot for anything but writing code
### BC TechDays 2026 — Workshop Handouts Repo

**Tine Starič & Luc van Vugt** | 9 & 10 June 2026

> The slides give you the shape. This repo gives you the detail, the reference material,
> and the files to take home. Everything here is yours to keep and adapt.

---

## Before the workshop — prerequisites

1. **VS Code** — latest stable release
2. **GitHub Copilot license** — individual, business, or the license provided by the
   workshop organisers (details in the reminder mail)
3. **A Microsoft account** registered for the workshop — you'll need this for the
   Azure DevOps exercises. If you have multiple Microsoft accounts (Companial, 4PS,
   personal), know which one you used to register. Wrong account = wrong org = no work items.

---

## The two MCPs you'll install in Module 1

Install these during Exercise 1.1. The `.vscode/mcp.json` file in this repo has the
configuration — once you clone/download the repo, VS Code will offer to install them.

| MCP | What it does | Install path |
|-----|-------------|--------------|
| **Azure DevOps** | Read and write work items, wikis, and boards in your ADO org | VS Code marketplace |
| **Microsoft Learn / BC docs** | Look up BC documentation and feature references | GitHub README "install" button |

**Verify install:** after installing, open Copilot chat and ask `list your tools` — you
should see tools from `azure-devops` and `microsoft-learn` in the response.

> The repo also has the AL Symbols MCP pre-configured (used in Module 3). It activates
> automatically once Node.js is on your machine — no manual install needed.

---

## How this repo is structured

```
.github/
  copilot-instructions.md     — project-wide context every agent in this workspace gets
  agents/                     — Tine's documentation-writer demo (Modules 1–5 concept intro)
  skills/                     — the diataxis-doc skill (Module 4 demo)
  prompts/                    — one stored-prompt sample (shown in the closing)

.vscode/
  mcp.json                    — MCP server configuration for the four workshop MCPs

sample-app/                   — tiny BC AL extension: the documentation subject + M5 target
  app.json
  src/Tables/WorkshopFeedback.Table.al
  src/Pages/WorkshopFeedbackCard.Page.al
  src/Enums/FeedbackRating.Enum.al

reference/                    — ANSWER KEY: requirements-analyst checkpoints (don't peek early)
  checkpoint-m2/
  checkpoint-m3/
  checkpoint-m4/

Handout.md                    — full exercise instructions, progressively revealed during the day
README.md                     — you are here
```

---

## Progressive unveil — how the handout works

Tine will push new sections of `Handout.md` to this repo as we progress through the day.
After each module's concept teach, the matching handout section goes live. You don't need to
read ahead — but everything will be here to take home at the end.

**Before exercises start:** install the four MCPs and verify they work.
**During exercises:** the Handout has more detail than the slide — refer to it if you need it.
**After the workshop:** the full Handout.md is your take-home reference.

---

## Azure DevOps — the workshop org

We've set up a shared AzDevOps org for the day: **https://dev.azure.com/fluxxusnl/BCTechDays2026-Using_GHCP**

- Each seat has a set of sample requirements pre-seeded as work items
- You'll need to be signed in with the Microsoft account you registered with
- The wiki (*Resources → Requirements*) has the best-practice reference your agent reads
  in M2.2: INVEST, Agile Alliance user stories, Volere primer

---

## The `reference/` folder

This is the answer key for the requirements-analyst you build across Modules 2–4.

**Don't look at it until you need it.** If you're keeping up, you don't need it. If you're
falling behind and the room is moving on, grab the checkpoint matching your module and
continue building from there. Full guide in `reference/README.md`.

---

## Take-home reading

| Track | Resource |
|-------|----------|
| Requirements | [INVEST Model](https://xp123.com/invest-in-good-stories-and-smart-tasks/) · [Agile Alliance — User Stories](https://www.agilealliance.org/glossary/user-stories/) · [Volere Primer](http://www.volere.org/volere-requirements-specification-template/) |
| Documentation | [Diátaxis Framework](https://diataxis.fr/) · [Write the Docs Guide](https://www.writethedocs.org/guide/) · [GitLab Doc Style Guide](https://docs.gitlab.com/ee/development/documentation/styleguide/) |
| Design notes | [C4 Model](https://c4model.com/) · [arc42](https://arc42.org/overview) · [Martin Fowler — Architecture](https://martinfowler.com/architecture/) |
| Test plans | Luc's 4PS write-up is on the workshop AzDevOps wiki — stakeholder access, no extra login needed |

---

*Questions after the workshop: Tine — <!-- TODO: add contact --> · Luc — lvanvugt@fluxus.nl*
