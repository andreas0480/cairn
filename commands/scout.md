---
description: Do the work, with discovery proportional to its risk and the session protocol enforced.
argument-hint: <description or ticket id> [--tier 1|2|3]
---

# /scout — discovery-proportional work

Scout the work, then do it. Tiered by complexity, layered on top of the
project's externalized context files.

## Session-start protocol (always, on first response)

If this is your first response in the conversation, before doing anything
else read in order:

1. `CLAUDE.md` — the constitution
2. `PROGRESS.md` — current build state
3. `HANDOVER.md` — what the previous session expected this one to pick up

If `HANDOVER.md` flags a specific next step or open question, factor that
into the tier classification below.

## How to run this

1. **Read the task. Classify into one of three tiers** and **declare the
   tier in your first response**:

   - **T1 (trivial)** — typo, rename, comment, format change. Single-line
     or single-file edits with zero behavior change.
   - **T2 (contained)** — fix or change inside one module, where blast
     radius is obvious from the file.
   - **T3 (substantial)** — non-trivial bug, new feature, multi-module
     change, anything that affects how callers integrate.

   The user may override with `--tier N`.

2. **Run discovery proportional to the tier.**

   **T1:** none. Edit, save, done.

   **T2:**
   - grep for callers of the affected symbol(s)
   - check that tests exist for the path you're changing
   - state the planned change in **one sentence**
   - edit, run tests, done

   **T3:**
   - run `/recall <topic>` (or read directly: `KNOWLEDGE.md`,
     relevant `DECISIONS.md` entries, relevant `TECHNICAL.md` sections) —
     does the project already have a relevant pattern, anti-pattern,
     decision, or quirk?
   - map the blast radius: which files, which callers, which tests
   - write the change plan as 3–5 bullets via `TaskCreate`
   - **before significant implementation, re-anchor**: re-read the
     `DECISIONS.md` entries that constrain this area
   - implement
   - run tests; if missing, write tests for the new behavior (red-green)
   - run a wider test suite to check for regressions
   - if you discovered something durable (a quirk, pattern, anti-pattern),
     suggest `/learn` after evidence is in
   - if a constraining technical decision was made during this work, log
     it to `DECISIONS.md` immediately (5-line entry: decision /
     alternatives / rationale)

3. **Verification rules (all tiers).**
   - never claim "verified" / "works" without showing the command and its
     output
   - if tests don't exist for the changed path, say so explicitly
   - if you couldn't run something (UI in headless env, etc.), say so

4. **After completion, update `PROGRESS.md`** with one terse line:
   `- 2026-04-29 — fixed login 500 (T2, PROJ-123)`. Do not batch updates.

5. **Stop at two attempts.** If the same approach fails twice, stop and
   ask the user. Don't try a third variation on a hunch.

## Drift checkpoint (every 10–15 exchanges)

Silently ask: *am I still aligned with `CLAUDE.md` and the decisions in
`DECISIONS.md`?* If unsure, re-read the relevant sections. If you're
suggesting approaches that contradict earlier decisions, forgetting
constraints, or repeating work — recommend a session reset, run
`/handover`, and tell the user a fresh session will be cleaner.

## What `/scout` does NOT do

- It does not create per-phase output documents (no `DIAGNOSIS.md`,
  `FIX_PLAN.md`, etc.).
- It does not maintain a workflow state file across runs.
- It does not commit, push, or open a PR. The user decides when to ship.
- It does not write *insights* to `KNOWLEDGE.md` or `DECISIONS.md`
  speculatively. `/learn` and the in-flow `DECISIONS.md` rule cover those.

## Examples

```
/scout "fix login button returning 500"
/scout PROJ-123
/scout --tier 3 "implement dark mode toggle"
/scout --tier 1 "rename internal helper getDb → getConnection"
```
