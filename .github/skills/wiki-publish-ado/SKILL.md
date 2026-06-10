---
name: wiki-publish-ado
description: >
  Publish or sync documentation to Azure DevOps Wiki with safe checks.
  Use for BC documentation publishing, wiki page upserts, docs-to-wiki sync,
  wiki audit-before-publish, and release documentation handoff. Reads existing
  pages first, then writes with a clear publish report.
argument-hint: "What to publish and where (project, wiki, root path, and doc content or source paths)"
user-invocable: true
---

# Azure DevOps Wiki Publisher

Use this skill when you need to **publish documentation to Azure DevOps Wiki** safely and consistently.

## What this skill produces

- A publish plan (target pages, mode, assumptions)
- Optional pre-publish audit (existing wiki pages + overlap/conflicts)
- Upserted wiki pages (when in apply mode)
- A final publish report with per-page status

## When to use

- "Publish these docs to Azure DevOps Wiki"
- "Sync local docs into wiki pages"
- "Check wiki first, then publish only missing/outdated pages"
- "Create release notes pages under a feature path"

Do **not** use this skill to author full technical content from scratch. Pair with a documentation-writing workflow first.

## Required inputs

Collect (or confirm) the following before publishing:

1. `project` (Azure DevOps project name or ID)
2. `wikiIdentifier` (wiki name or ID)
3. `rootPath` (example: `/Features/Workshop Feedback`)
4. source content:
   - either direct markdown content blocks
   - or local source file paths to convert/publish
5. publish mode:
   - `preview` (plan only, no writes)
   - `apply` (perform upserts)

If any required input is missing, ask concise follow-up questions before continuing.

## Workflow

### Step 1 — Intake and mapping

1. Confirm goal and mode (`preview` or `apply`).
2. Build target page map:
   - page title
   - target wiki path
   - source doc reference
3. Normalize paths under `rootPath` (leading slash, no accidental double slashes).

### Step 2 — Discover existing wiki state

1. Search for matching pages under the feature scope.
2. Read existing pages for likely path collisions.
3. Mark each target page as:
   - `new`
   - `update`
   - `possible-conflict`

### Step 3 — Pre-publish checks

For every target page, verify:

- content is not empty
- heading/title is present and meaningful
- cross-links are not obviously broken (as far as known)
- no obvious duplicate page under a different path

If issues exist, stop and show a fix list before writing.

### Step 4 — Publish

If mode is `preview`:
- Return planned operations only (no writes).

If mode is `apply`:
1. Upsert each page to Azure DevOps Wiki.
2. Continue page-by-page; do not hide partial failures.
3. Capture status for every page.

### Step 5 — Final report

Return a structured summary:

- project
- wiki
- rootPath
- mode
- pages processed
- created/updated/failed counts
- per-page details (path, status, notes, url when available)
- retry suggestions for failures

## Output template

```
WIKI PUBLISH REPORT
Project: [project]
Wiki: [wikiIdentifier]
Root Path: [rootPath]
Mode: [preview|apply]

SUMMARY
- Total pages: [n]
- Created: [n]
- Updated: [n]
- Failed: [n]

DETAILS
- [path]
  Status: [created|updated|failed|skipped]
  Source: [file/content label]
  Notes: [if any]
  URL: [if available]

FOLLOW-UPS
- [next actions for any failed/skipped pages]
```

## Azure DevOps Wiki tool usage notes

Use these operations where available:

- Search wiki pages to discover existing content.
- Read/list wiki pages before publish for collision awareness.
- Upsert wiki pages for create/update writes.

Prefer safe behavior:

- Read before write
- Show planned changes in preview mode
- Preserve visibility of partial failures

## BC workshop conventions

For BC feature docs, a common page set is:

- `<rootPath>/Overview`
- `<rootPath>/Technical Reference`
- `<rootPath>/Usage Guide`
- `<rootPath>/Operational Notes`

If local docs follow this structure, map them 1:1 into wiki pages.
