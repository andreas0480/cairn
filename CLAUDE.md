# Project conventions (Cairn)

Cairn is a thin workflow discipline that layers on top of an externalized
context system — `CLAUDE.md`, `PROGRESS.md`, `DECISIONS.md`, `TECHNICAL.md`,
`HANDOVER.md` (the same five-file pattern from the
[context-aware starter prompt](https://blog.belitz.se/posts/context-aware-starter-prompt)),
plus `KNOWLEDGE.md` for runtime quirks. Cairn does *not* try to replace any
of those — it tells Claude how to *use* them on every workflow.

If you don't already have those files, run the starter prompt first to
bootstrap them. Then merge this file's conventions into your existing
project `CLAUDE.md`.

## Context layer (the substrate Cairn assumes)

| File | Purpose | Cadence |
|------|---------|---------|
| `CLAUDE.md` | Project constitution — stakeholder, objectives, standards | Rarely (after discovery) |
| `PROGRESS.md` | Living build log — done / in progress / next / blocked | Every completed task |
| `DECISIONS.md` | ADR — every constraining technical choice with rationale | Every major decision |
| `TECHNICAL.md` | Implementation details — stack, contracts, data models | As architecture evolves |
| `HANDOVER.md` | Session transition snapshot — overwritten each session | End of every session |
| `KNOWLEDGE.md` | Runtime quirks, fragile modules, observed gotchas | Via `/learn` with evidence |

**Files are the source of truth.** If something you "remember" from
conversation conflicts with what's in the files, the files win. Re-read
them before acting on inherited assumptions.

## Session protocol

**At the start of every working session** — your first response in a
conversation — read these three files before anything else:

1. `CLAUDE.md` — the constitution
2. `PROGRESS.md` — what state the project is in
3. `HANDOVER.md` — what the previous session expected this one to pick up

Do not rely on conversational memory to carry project state forward.

**Every 10–15 exchanges**, do a silent self-check: *am I still aligned with
the constraints in `CLAUDE.md` and the decisions in `DECISIONS.md`?* If
unsure, re-read those sections. This catches drift before it costs hours.

**Before significant implementation** (new feature, structural refactor,
schema change, API design), re-anchor by reading the relevant sections of
`DECISIONS.md` and `CLAUDE.md`. Never assume prior context is still active.

**At session end**, write `HANDOVER.md` via `/handover`. No exceptions —
even if the session was short. A clean re-entry point next time is worth
the two minutes.

**If you detect drift** (suggesting approaches that contradict earlier
decisions, forgetting constraints, repeating work), proactively recommend
a session reset. Write the handover. A fresh session with good files
beats grinding through a degraded one.

## Working principles

1. **Discovery proportional to risk.** Classify the work into a tier and
   declare it in your first response:

   - **T1 (trivial)** — typo, rename, comment, format change. No
     discovery. Just edit.
   - **T2 (contained)** — fix or change inside one module, where blast
     radius is obvious from the file. Grep callers, check that tests
     exist for the path, state the planned change in one sentence, edit,
     run tests.
   - **T3 (substantial)** — non-trivial bug, new feature, or multi-module
     change. Run `/recall` (reads across the context layer + `KNOWLEDGE.md`),
     map the blast radius, write a 3–5 bullet plan via `TaskCreate`,
     implement, run tests (red-green for new behavior), check for
     regressions, optionally `/learn` after evidence.

   The user can override with `--tier N`.

2. **Write as you go, never at the end.**
   - After **any completed task** (any tier), append one terse line to
     `PROGRESS.md`. Don't batch.
   - When you make a **constraining technical decision** (framework,
     schema, API shape, deployment approach), log it to `DECISIONS.md`
     immediately with: the decision, the alternatives considered, the
     rationale. Five-line entries.
   - Never delete from `DECISIONS.md`. If a later decision supersedes an
     older one, append the new entry and reference what it replaces.

3. **Show evidence, never claim.** Banned phrases without supporting
   output: "verified", "works", "looks good", "should work". Show the
   command, show the output, then state the conclusion. If you couldn't
   run something (headless env, missing credential, etc.), say so
   explicitly.

4. **Tests are the gate, not phases.** A T3 change without a test for the
   new behavior is incomplete. For T2, an existing test passing is
   acceptable. For T1, no test needed.

5. **Git is the immediate trace; the context files are the durable one.**
   The commit message and diff record *what* changed; `DECISIONS.md` and
   `PROGRESS.md` record *why* and *where we are*. Both matter.

6. **Knowledge requires evidence.** `/learn` refuses entries without a
   commit SHA, PR link, or test output. Speculation is not knowledge.

7. **Stop at two attempts.** If a phase fails twice on the same approach,
   stop and ask the human. Don't try a third variation on a hunch.

8. **No silent commits.** Don't `git commit` or `git push` unless
   explicitly asked. The user decides when to ship.

9. **Keep files concise.** `PROGRESS.md` is terse bullets, not prose.
   `DECISIONS.md` entries are 3–5 lines. `HANDOVER.md` is a snapshot,
   not a log. If a single file passes ~500 lines, propose splitting it.

## Commands

- `/scout <description-or-ticket>` — do the work, tiered by complexity,
  with the session protocol enforced
- `/recall <topic>` — surface relevant slices from the full context layer
- `/learn <insight>` — append a durable insight, routed to the right file,
  with required evidence
- `/handover` — write/refresh `HANDOVER.md` at session end

## What this project does NOT use

- Per-phase output documents (no `DIAGNOSIS.md`, `FIX_PLAN.md`, etc.).
- A workflow-state file describing where in a phase machine we are.
- Slash commands beyond the four above.
- Generators that re-survey the repo and produce tailored workflow files.

If you find yourself wanting these, you've hit a complexity threshold
where Cairn is the wrong tool. That's fine — pick a heavier framework or
build on top.
