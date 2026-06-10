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

