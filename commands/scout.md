---
description: Do the work, with discovery proportional to its risk.
argument-hint: <description or ticket id> [--tier 1|2|3]
---

# /scout — discovery-proportional work

Scout the work, then do it. Tiered by complexity.

## How to run this

1. **Read the task.** Classify into one of three tiers and **declare the
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
   - read `KNOWLEDGE.md` (or run `/recall <topic>`) — does the project
     already have a relevant pattern, anti-pattern, or quirk?
   - map the blast radius: which files, which callers, which tests
   - write the change plan as 3–5 bullets via `TaskCreate`
   - implement
   - run tests; if missing, write tests for the new behavior (red-green)
   - run a wider test suite to check for regressions
   - if you discovered something durable (a quirk, pattern, or
     anti-pattern), suggest `/learn` after evidence is in

3. **Verification rules (all tiers).**
   - never claim "verified" / "works" without showing the command and its
     output
   - if tests don't exist for the changed path, say so explicitly
   - if you couldn't run something (UI in headless env, etc.), say so

4. **Stop at two attempts.** If the same approach fails twice, stop and
   ask the user. Don't try a third variation on a hunch.

## What `/scout` does NOT do

- It does not create per-phase output documents.
- It does not maintain a state file across runs.
- It does not commit, push, or open a PR. The user decides when to ship.
- It does not write to `KNOWLEDGE.md`. That requires explicit `/learn`
  with evidence.

## Examples

```
/scout "fix login button returning 500"
/scout PROJ-123
/scout --tier 3 "implement dark mode toggle"
/scout --tier 1 "rename internal helper getDb → getConnection"
```
