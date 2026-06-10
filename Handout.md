# BC TechDays 2026 — Workshop Handout
## Using GitHub Copilot for anything but writing code

**Tine Starič & Luc van Vugt** | 9 & 10 June 2026

> This handout goes deeper than the slides and comes home with you. Sections are pushed
> to the repo as we progress through the day — each module's section goes live just before
> its exercises start. Don't try to read ahead during the session; do read back through it
> on Monday morning.
>
> The repo URL: **https://github.com/tinestaric/bc-techdays-2026**

---

## 📋 What you need before we start

| Item | Check |
|------|-------|
| VS Code — latest stable | ☐ |
| GitHub Copilot license active | ☐ |
| Microsoft account (the one you registered with) | ☐ |
| Node.js LTS — [nodejs.org](https://nodejs.org) | ☐ |
| GitHub CLI — [cli.github.com](https://cli.github.com) | ☐ |
| This repo cloned or downloaded | ☐ |

If you have multiple Microsoft accounts (Companial, 4PS, personal), decide now which one
you're using today. You'll need it in Module 1 and it's painful to switch mid-session.

---

---

# 🔌 Module 1 — MCPs

> *An agent without tools is ChatGPT in VS Code. MCPs are how it gets tools.*

MCPs (Model Context Protocol servers) let your Copilot agent call out to real systems —
your Azure DevOps backlog, the BC documentation — instead of hallucinating answers from
training data. Today we install two of them, and also set up GitHub Copilot CLI so the
Module 5 exercises work without a last-minute scramble.

---

## 🏁 Exercise 1.1 — Install the curated MCPs *(15 min)*

**🎯 Goal:** Get all four MCPs installed and verified before we do anything else. This is
the foundation. If an MCP doesn't install, nothing in M2–M5 works properly.

### Steps

1. Open this repository in VS Code (File → Open Folder).

2. VS Code may offer to install the MCP servers from `.vscode/mcp.json` automatically.
   Accept and proceed to step 4 if so. Otherwise, install each one manually:

   **Azure DevOps MCP** — install from the VS Code marketplace:
   - Extensions panel → search "Azure DevOps MCP" → Install
   - Or via command palette: `MCP: Add Server` → paste the connection details

   **Microsoft Learn / BC docs MCP** — click the "Install in VS Code" button on the
   [GitHub README](https://github.com/MicrosoftDocs/mcp) (exact URL in the repo's
   `.vscode/mcp.json` comments)

3. When prompted for your Azure DevOps org URL, enter the workshop org:
   **https://dev.azure.com/fluxxusnl/BCTechDays2026-Using_GHCP**

4. Reload VS Code (`Ctrl/Cmd + Shift + P` → "Developer: Reload Window").

5. Install GitHub Copilot CLI — you will need this in Module 5:
   - Open a terminal (`Ctrl/Cmd + `` ` ``)
   - Run: `gh extension install github/gh-copilot`
   - Verify: `gh copilot --version`

   If `gh` isn't found, install the GitHub CLI first: **https://cli.github.com**

6. Open Copilot Chat and type:
   ```
   List your tools
   ```

### ✅ Done when

Your agent lists both MCPs in its tool inventory. You should see tools from
`azure-devops` and `microsoft-learn`. And `gh copilot --version` prints a version number.

### ⚠️ Watch out — the account-picker footgun

When the AzDevOps MCP connects for the first time, it will ask which Microsoft account
to use. **Pick the account you used to register for this workshop.** If you pick the wrong
one, you'll connect to a different org (or no org) and the work items won't be there.

If you accidentally connected with the wrong account: Command Palette →
"Azure DevOps MCP: Sign out" → reconnect with the right account.

### 💡 Pro Tips

> 💡 If an "Install in VS Code" button doesn't work, every MCP's GitHub README has
> a manual install option — a JSON snippet you paste into your VS Code MCP configuration.
> The `.vscode/mcp.json` in this repo already has all four configured; you just need
> the MCP runtime installed.

> 💡 You can see exactly which tools each MCP provides: ask Copilot
> `list your tools from the azure-devops MCP` — it'll show every callable function.

---

## 🧱 Exercise 1.2 — Use each MCP once *(15 min)*

**🎯 Goal:** See each MCP actually do its thing. Not to be clever — just to confirm it
works and understand what it returns.

### Steps

Run each prompt below in a **fresh Copilot chat**. Note what tool gets called and what
the response looks like.

**Azure DevOps MCP:**
```
List the work items assigned to me in the workshop project.
```

**Microsoft Learn / BC docs MCP:**
```
What is the ToolTip property on a BC AL page control and when is it mandatory?
```

### 🧪 Outcome Notes

For each MCP, note:
- Which tool name was called (visible in the chat tool-use trace)
- One thing the response returned that was useful
- One thing that was surprising or wrong

| MCP | Tool called | Useful | Surprising/wrong |
|-----|-------------|--------|-----------------|
| Azure DevOps | | | |
| Microsoft Learn | | | |

### ✅ Done when

One chat per MCP, each showing the tool was actually called (not just answered from
Copilot's training data — you can tell because the tool-use trace appears in the chat).
And `gh copilot --version` in the terminal from Exercise 1.1 shows a version number.

### 💡 Pro Tips

> 💡 The difference between a tool call and a training-data answer: a real MCP call shows
> an expandable "Tool used" section in the chat. If you don't see that, the agent answered
> from memory — which may be outdated or wrong for your org.

---

## 📣 Module 1 Debrief

*"Which MCP surprised you most? Which one didn't work?"*

Drop one line into the polling tool (or call it out). We'll read the board together.

---

---

# 🤖 Module 2 — Custom Agents

> *An agent with all tools enabled spends 25k tokens saying hello. Scoping is the discipline.*

A custom agent is a named, reusable AI persona with a scoped toolset and its own
instructions. Instead of configuring the same thing in every chat, you define it once
and load it from the picker. Today you build one for requirements analysis.

The file lives at `.github/agents/your-agent-name.agent.md`. VS Code picks it up
automatically. You can also find Tine's `documentation-writer` agent already in that
folder — use it as a reference for structure, not as a template to copy wholesale.

By the end of M2 you'll have iterated on the agent with real wiki content, and wired it
to a peer agent via a `handoffs:` block — so it can hand its output off to a tech designer
in one click. That last part is Exercise 2.3.

> **Falling behind?** The `reference/` folder has checkpoints for every stage.
> If the room moves on before you finish an exercise, grab the matching checkpoint,
> copy it into your workspace, and continue from there — you're not losing the exercise,
> you're deferring the build and keeping the learning. See `reference/README.md` for
> which checkpoint to grab at each point.

---

## 🏁 Exercise 2.1 — Build your own requirements analyst *(15 min)*

**🎯 Goal:** A working `requirements-analyst.agent.md` that loads in the agent picker
and accepts a prompt. It doesn't need to be good yet — that's Exercise 2.2.

### Steps

1. Open Copilot chat and use the `/create agent` skill as your starting point:
   ```
   /create agent
   ```
   Follow the prompts to generate a skeleton. You'll customise it next.

2. Create the file `.github/agents/requirements-analyst.agent.md` in this workspace
   (VS Code may offer to create it for you from the `/create agent` output).

3. Fill in or edit the frontmatter:
   ```yaml
   ---
   name: requirements-analyst
   description: >
     Analyses software requirements for quality and completeness.
     Give me a work item ID or paste requirement text to analyse.
   argument-hint: "Work item ID or requirement text to review"
   tools: [read, web, 'microsoft/azure-devops-mcp/*']
   ---
   ```

4. Write a short instructions body — a few sentences on what the agent should do.
   Don't overthink it. You'll improve it substantially in 2.2.

5. Save the file. Check that the agent appears in the Copilot agent picker
   (the dropdown in the chat panel header).

6. Pick your agent and send it a prompt:
   ```
   Analyse work item #1
   ```

### ✅ Done when

Your agent appears in the picker, responds to a prompt, and attempts to call the
Azure DevOps MCP to read the work item. The quality of the output doesn't matter yet.

### 💡 Pro Tips

> 💡 The `description:` field is what the agent picker shows as the subtitle. Make it
> specific about what to give the agent — it's also the hint that helps Copilot decide
> whether to suggest this agent automatically.

> 💡 If VS Code doesn't pick up your new agent, try: Command Palette →
> "GitHub Copilot: Refresh Agents". Or reload the window.

> 💡 **Stuck?** A minimal working starter agent lives in `reference/m2/.github/agents/`.
> Copy it to your own `.github/agents/` folder and continue from there. Build on it in
> Ex 2.2 — don't just run it.

---

## 🧱 Exercise 2.2 — Iterate: let the agent absorb what *good* looks like *(25 min)*

**🎯 Goal:** Experience the *fix the agent, not the prompt* pattern — and let the agent
absorb best-practice guidance from a curated reference source. This is the pattern
you take home.

### Steps

1. **Run your agent from 2.1** on the AzDevOps work item assigned to your seat.
   Look at the output: what's missing, what's vague, what did it get right?
   Take 2 minutes to note down 2–3 specific gaps.

2. **Point the agent at the wiki.** Open a new chat with your agent and try:
   ```
   Read these URLs and pull out the points a good requirements analyst
   should always check. Add the relevant ones to your own instructions.

   - https://xp123.com/invest-in-good-stories-and-smart-tasks/
   - https://www.agilealliance.org/glossary/user-stories/
   - http://www.volere.org/volere-requirements-specification-template/
   ```
   Watch the agent read the URLs (fetch tool calls visible in trace), extract key
   criteria, and propose updates to its own instructions. Accept or refine the additions.

3. **Re-run on the same work item.** Compare the output to Step 1. What got better?

4. **Find one remaining gap.** Pick one specific thing the agent still does wrong or
   inconsistently. This is your manual improvement.

5. **Fix the agent, not the prompt.** Open the `.agent.md` file and add or refine
   a specific instruction to address the gap you found. Re-run. Compare again.

### 🧪 Outcome Notes

| | Before wiki absorption | After wiki absorption | After manual fix |
|--|--|--|--|
| INVEST coverage | | | |
| Acceptance criteria check | | | |
| Output structure | | | |

### ✅ Done when

You can name:
- **(a)** one concrete thing the agent absorbed from the wiki that improved its output
- **(b)** one specific instruction-level fix you made on top of that

### 💡 Pro Tips

> 💡 The agent reading URLs is itself the demo: this is how you bootstrap any agent
> with external expertise. Point it at documentation, guides, internal wikis — the same
> pattern works anywhere there's a URL.

> 💡 If the agent proposes instructions you don't want, reject them specifically:
> "Don't add the Volere template sections — too heavyweight for our sprints. Keep only
> the INVEST and Agile Alliance points." Negotiate. That's the N in INVEST.

> 💡 **Done early?** Go back and look at what the agent wrote for each INVEST principle.
> Pick the one verdict you'd phrase differently — and fix the agent's instructions so it
> would phrase it your way next time.

---

## 🔗 Exercise 2.3 — Hand off to a peer agent *(15 min)*

**🎯 Goal:** Add one YAML block, create one peer agent, click one button. Experience what
user-routed flow between agents feels like — before you see the agent route itself in M3.

### Steps

1. **Create the peer agent.** In your workspace, create a new file:
   `.github/agents/tech-designer.agent.md`

   Minimal frontmatter:
   ```yaml
   ---
   name: tech-designer
   description: >
     Creates a technical design for a Business Central requirement or feature.
     Give me a requirements-analyst output or a work item ID to design technically.
   argument-hint: "Requirements-analyst output or work item ID to design"
   tools: [read, 'microsoft/azure-devops-mcp/*']
   ---
   ```

   Body (write this yourself — a few sentences is enough):
   Describe what the agent should do: take the requirements analysis, produce a technical
   design — what tables, pages, and codeunits to create or modify, the key integration
   points, and a suggested implementation approach. Concrete enough for a developer to start.

2. **Add a `handoffs:` block to your requirements-analyst.** Open your
   `requirements-analyst.agent.md` and add this to the frontmatter, after `tools:`:

   ```yaml
   handoffs:
     - label: Create technical design
       agent: tech-designer
       prompt: >
         Create a technical design for the requirement analysed above.
         Use the analysis findings as the source of truth. Include all flagged gaps
         as open items requiring PO confirmation before implementation starts.
       send: false
   ```

3. **Run your requirements analyst on your assigned work item.** Let it finish.

4. **Look for the handoff button.** Under the agent's finished response, you should see a
   "Create technical design" button. Click it.

5. **Observe what happens.** The pre-composed prompt lands in the input field — with the
   analysis context carried forward. Review it. Edit if you want. Submit.

6. **Name who's in charge.** You clicked the button. You walked the edge. The requirements
   analyst didn't decide to route to the peer — it offered you an option and you took it.

### 🧪 Outcome Notes

| | |
|---|---|
| Handoff button appeared? | ☐ Yes ☐ No |
| Pre-composed prompt looked right? | ☐ Yes ☐ Needed editing |
| Who decided to route to the peer agent? | ☐ The LLM ☐ Me |

### ✅ Done when

You clicked a handoff button and the peer agent picked up with carried-forward context.
You can answer: *"who's in charge of routing here — me or the LLM?"*

### ⚠️ Watch out — VS Code only

The `handoffs:` field is a VS Code–only feature. If you run the same agent file as a
GitHub Cloud Agent (e.g. on a GitHub issue), the field is silently stripped. The buttons
won't appear — no error, just not supported there. Design accordingly.

### 💡 Pro Tips

> 💡 The most common stuck moment: a typo in the `agent:` field. The name must exactly
> match the peer agent's `name:` frontmatter value. If the target doesn't exist or the
> name is wrong, the button silently doesn't work. No validation.

> 💡 `send: false` is the right default for demos and learning. The pre-composed prompt
> landing in the input *is* the point — you see exactly what gets handed over, and you can
> edit it before submitting. With `send: true` it auto-fires and you lose that visibility.

> 💡 The `prompt:` field is the quality lever. A lazy handoff just says "do the next step."
> A good one distills the previous agent's output into a brief — tell the peer what it needs
> to know, not just what to do.

> 💡 **Stuck?** Both files — the handoff-equipped requirements-analyst and the tech-designer
> peer — live in `reference/checkpoint-m2-handoff/.github/agents/`. Copy both, run,
> then go back and understand the `handoffs:` block before moving on.

> 💡 **Done early?** Add a second handoff button. Wire it to a documentation peer agent —
> same analyst, two buttons: one for technical design, one for user documentation. You've
> just built a small directed graph of agents.

---

## 📣 Module 2 Debrief

*"What other agent would you build — one that doesn't exist in this repo yet?"*

Think about your own day-to-day: what decision, review, or lookup do you repeat so often
that it deserves its own persona? Drop one into the polling tool.

---

> ### 🗺️ Who's in charge?
>
> Before we get into sub-agents, here's where we are:
>
> | Pattern | Who routes? | You built this in |
> |---|---|---|
> | Custom agent | You configured it; one agent, one job | M2 Ex 2.1–2.2 |
> | **Handoff** | **You clicked a button** | **M2 Ex 2.3** |
> | Sub-agent | The LLM delegates autonomously within a turn | M3 → |
>
> The question for Module 3: *what if you didn't have to click?*

---

# 🔀 Module 3 — Sub-agents

> *In M2 you clicked a button to route to the next agent. Sub-agents do that routing
> themselves — no click, no button, just the LLM deciding to delegate within a turn.*

Your requirements analyst is one agent doing five things. That's fine for simple work
items — but as the work items get complex, or as you add more dimensions to the analysis,
the context window starts to matter. Sub-agents let you fan out: multiple specialist
agents run in parallel, each in its own context, each returning only a summary to the parent.

---

## 🏁 Exercise 3.1 — Ad-hoc sub-agents *(15 min)*

**🎯 Goal:** Feel the parallelism. See the context savings in action.

### Steps

1. **Make sure your requirements analyst has the `agent` tool enabled.** Open the
   `.agent.md` file and confirm `agent` is in the `tools:` list:
   ```yaml
   tools: [read, web, 'microsoft/azure-devops-mcp/*', agent]
   ```
   If it's not there, add it and reload VS Code. The `agent` tool is what allows an
   agent to spin up sub-agents.

2. **Take your requirements analyst from M2** and use it with this prompt:
   ```
   Analyse work item #[your assigned ID].
   Run each of the following as a separate sub-agent and then give me
   one consolidated summary:
   1. Ambiguity check — flag all vague language and undefined terms
   2. Gap analysis — identify missing acceptance criteria and personas
   3. Base app impact — use AL Symbols to find which BC objects are affected
   ```

3. **Watch the sub-agent threads spin up** in the chat. Each will show its own
   tool-use trace. You should see the AL Symbols MCP being called in thread 3.

4. **Read the consolidated summary.** What was combined vs. what was kept separate?

### 🧪 Outcome Notes

- Did three sub-agent threads visibly spin up? ☐ Yes ☐ No
- Did the consolidated summary collapse duplicate findings? ☐ Yes ☐ No
- Any sub-agent fail or time out? ☐ No ☐ Yes — which one: ___________

### ✅ Done when

Three sub-agent threads ran and you got back a single consolidated summary.

---

## 🔧 Exercise 3.2 — Bake the fan-out into the agent *(15 min)*

**🎯 Goal:** The agent fans out automatically, without you asking.

### Steps

1. **Open your requirements analyst's `.agent.md` file.**

2. **Add fan-out instructions to the body.** Something like:
   ```
   When analysing a work item, always spin up sub-agents for these three tasks
   in parallel before producing your final output:
   1. Ambiguity check — vague language, undefined terms
   2. Gap analysis — missing AC, missing personas, missing edge cases
   3. Base app impact — AL Symbols lookup for affected BC objects
   Only return the consolidated summary to me.
   ```

3. **Add `agent` to your `tools:` list** so the orchestrator can spin up sub-agents:
   ```yaml
   tools: [read, web, 'microsoft/azure-devops-mcp/*', agent]
   ```
   The `agent` tool is what gives your orchestrator permission to delegate to sub-agents.
   You'll restrict it to a named custom sub-agent in Ex 3.3.

4. **Re-run with the same prompt as 3.1, but without the explicit sub-agent clause:**
   ```
   Analyse work item #[your assigned ID]
   ```

5. Confirm the fan-out still happens.

### ✅ Done when

The same prompt as 3.1, but without the explicit "run as sub-agent" instruction, still
produces a fan-out into parallel sub-agent threads.

---

## ⚙️ Exercise 3.3 — A custom agent, used as a sub-agent *(15 min)*

**🎯 Goal:** Build a focused custom agent for one specific job and have your requirements
analyst delegate to it by name.

### Steps

1. **Create a new agent file:** `.github/agents/base-app-impact-analyzer.agent.md`

   Frontmatter:
   ```yaml
   ---
   name: base-app-impact-analyzer
   description: >
     Uses AL Symbols MCP to identify which BC base app tables, pages, and codeunits
     are relevant to a requirement. Returns a structured impact summary.
   user-invocable: false
   model: gpt-4o-mini
   tools:
     - al-symbols-mcp
   ---
   ```

   In the body: write instructions for this specific job — read the requirement, use
   AL Symbols to look up the entities mentioned, return a structured impact summary.

   > **Notice `user-invocable: false`** — this agent won't appear in the picker. It's a
   > specialist tool the orchestrator calls, not something you'd invoke directly. It still
   > works as a sub-agent.

   > **When to assign a model to a sub-agent**
   >
   > Add `model:` to a sub-agent's frontmatter when its job is focused and doesn't need
   > the full reasoning power of a large model:
   >
   > | Task | Model to consider | Why |
   > |------|-------------------|-----|
   > | Structured lookup, symbol extraction | Small (`gpt-4o-mini`) | One clear task — speed and cost win |
   > | Reasoning over multiple findings, synthesis | Large (`gpt-4o`, `claude-sonnet`) | Connecting dots across sources |
   > | Long document read + summary | Large | Context window + comprehension quality |
   >
   > The orchestrator (your requirements analyst) earns the larger model.
   > Narrow sub-agents doing a single lookup usually don't.

2. **Update your requirements analyst** to call this specific agent by name.
   Add an `agents:` list to the frontmatter naming your sub-agent:
   ```yaml
   agents:
     - base-app-impact-analyzer
   ```
   Add the other named sub-agents here as you build them (ambiguity-detector, etc.).
   Then update the fan-out instructions in the body to name `base-app-impact-analyzer`
   explicitly for the base app impact analysis task.

3. **Run end-to-end.** Same prompt, same work item. Confirm the orchestrator delegates
   to the named agent and `base-app-impact-analyzer` doesn't show up in your agent picker.

### ✅ Done when

Your orchestrator delegates to the named `base-app-impact-analyzer` sub-agent and
returns a consolidated summary. The base-app-impact-analyzer does NOT appear in the
agent picker dropdown.

### 💡 Pro Tips

> 💡 Look at `reference/checkpoint-m3/` if you're stuck. Read the orchestrator file
> and the four sub-agent files — the structure is the answer.

> 💡 The `user-invocable: false` flag is the M4.0 matrix "custom agent instructions"
> point in action: the agent's *scope* (not user-invocable, only callable by orchestrators)
> is part of its definition. That's a design decision, not an afterthought.

---

## 📣 Module 3 Debrief

*"When do you stop subdividing?"*

Drop one word or phrase into the polling tool (word cloud format). The edges are where it gets interesting.

---

---

# 🎛️ Module 4 — Skills, and where everything else fits

> *Same content can technically live anywhere in the instruction stack. The trick is
> putting it where it'll actually be loaded at the right moment.*

A skill is a prompt file with frontmatter. The name and description are loaded up front,
every time. The body is loaded **lazily** — only when the agent decides the description
matches the current task. That lazy loading is what makes skills different from putting
the same content in the agent's instructions.

The five surfaces where instructions can live (the M4.0 slide you can photograph):

| Surface | Always loaded? | Who decides when? | Best for |
|---------|---------------|-------------------|----------|
| `copilot-instructions.md` | ✅ Always | Project-wide, automatic | Context every agent needs |
| Custom agent instructions | ✅ Always (for this agent) | You, when you pick the agent | Persona + scope for this job |
| Skill frontmatter (name + description) | ✅ Always | Agent, based on task | When should this be loaded? |
| Skill body | ❌ Lazy | Agent, based on description | What to do when loaded |
| `.prompt.md` files | ❌ Manual invoke | You, explicitly | One-off pattern; manual trigger |

---

