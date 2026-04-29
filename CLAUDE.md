# Project conventions (Cairn)

This project uses Cairn — a thin Claude Code framework. Discipline lives
here; ceremony does not.

## Working principles

1. **Context first.** Before non-trivial work, read `KNOWLEDGE.md`. If the
   scope is broad or unfamiliar, run `/recall` to surface relevant entries.

2. **Discovery proportional to risk.** Classify the work into a tier and
   declare it in your first response:
   - **T1 (trivial)** — typo, rename, comment, format change. No discovery.
     Just edit.
   - **T2 (contained)** — a fix or change inside one module, where blast
     radius is obvious from the file. Grep callers, check that tests exist
     for the path, state the planned change in one sentence, edit, run tests.
   - **T3 (substantial)** — non-trivial bug, new feature, or multi-module
     change. Recall prior knowledge, map the blast radius, write a 3–5 bullet
     plan (use TaskCreate), implement, run tests (red-green for new
     behavior), check for regressions, optionally `/learn` after evidence.

   The user can override with `--tier N`.

3. **Show evidence, never claim.** Banned phrases without supporting output:
   "verified", "works", "looks good", "should work". Show the command, show
   the output, then state the conclusion. If you couldn't run something
   (headless env, missing credential, etc.), say so explicitly.

4. **Tests are the gate, not phases.** A T3 change without a test for the
   new behavior is incomplete. For T2 work, an existing test passing is
   acceptable. For T1, no test needed.

5. **Git is the trace.** The commit message and diff are the audit trail.
   Do not produce per-phase documents (`DIAGNOSIS.md`, `FIX_PLAN.md`, etc.).
   If a long-form decision deserves capture, it goes in `KNOWLEDGE.md` via
   `/learn` — once there is evidence.

6. **Knowledge requires evidence.** `/learn` refuses entries without a
   commit SHA, PR link, or test output. Speculation is not knowledge.

7. **Stop at two attempts.** If a phase fails twice on the same approach,
   stop and ask the human. Don't try a third variation on a hunch.

8. **No silent commits.** Don't `git commit` or `git push` unless explicitly
   asked. The user decides when to ship.

## Commands

- `/scout <description-or-ticket>` — do the work, tiered by complexity
- `/recall <topic>` — read `KNOWLEDGE.md` and surface relevant entries
- `/learn <insight>` — append to `KNOWLEDGE.md` with required evidence

## Files at repo root

- `CLAUDE.md` — these conventions
- `KNOWLEDGE.md` — durable insights, curated quarterly

## What this project does NOT use

- State files describing where in a workflow we are.
- Per-phase output documents.
- Slash commands beyond the three above.
- Generators that re-survey the repo and produce tailored workflow files.

If you find yourself wanting these, you've hit a complexity threshold where
Cairn is the wrong tool. That is fine — pick a heavier framework or build
on top.
