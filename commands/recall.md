---
description: Surface relevant slices from across the project's context layer for the current task.
argument-hint: [topic]
---

# /recall — surface relevant context

Read across the project's externalized context files and pick out entries
relevant to the current task or explicit topic. This is the cheap way to
re-anchor before any T3 work, before significant implementation, or any
time you suspect drift.

## How to run this

1. **Read these files in order**, scoring each for relevance to the
   argument (or, if no argument, the current conversation):

   - `KNOWLEDGE.md` — runtime quirks, fragile modules, observed gotchas
   - `DECISIONS.md` — architectural decisions and their rationale
   - `TECHNICAL.md` — implementation details, contracts, data models
   - `CLAUDE.md` — the constitution (constraints, standards, scope)
   - `HANDOVER.md` — the previous session's snapshot (only if its
     pending items intersect the current topic)

2. **Surface the top 3–5 hits inline**, grouped by source file. For each,
   include the heading or date and the gist (one or two lines). Cite
   the source file so the user can jump to it.

3. **Flag staleness explicitly:**
   - `KNOWLEDGE.md` entries past their `revisit:` date — may be stale
   - `DECISIONS.md` entries that have been superseded by a later entry
     covering the same area
   - Anything in `TECHNICAL.md` that contradicts what you observed in
     the live code

4. **If nothing relevant is found**, say so. Don't infer or fabricate.
   Suggest one of:
   - "no constraints found — proceed with discovery"
   - "no prior knowledge on this — capture via `/learn` after the work
     is done if anything durable surfaces"

5. **If a referenced file is missing** (no `DECISIONS.md`, no
   `KNOWLEDGE.md`, etc.), don't fail — just skip it and note it in the
   summary. The starter prompt creates these files; some projects may
   not have all of them yet.

## What `/recall` does NOT do

- It does not modify any context file.
- It does not promote speculation to "knowledge". If the files say
  nothing relevant, neither does `/recall`.
- It does not load the entire context layer into the working response —
  only the slices that scored relevant. Concise wins.

## Examples

```
/recall "retriever performance"
/recall                       # uses current conversation context
/recall "auth — what did we decide for session storage?"
```
