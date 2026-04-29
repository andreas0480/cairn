# Knowledge

Runtime quirks, fragile modules, and observed gotchas about this codebase.
Curated, not exhaustive. New entries go at the top.

## What lives here vs. elsewhere

This file is the **backward-looking** memory layer — *"this was a problem;
here's what fixed it."* Distinct from the other context files:

- `DECISIONS.md` — *forward-looking* architectural choices ("we chose X
  because Y"). If your insight is "we decided to do X going forward", it
  belongs there.
- `TECHNICAL.md` — implementation specs (contracts, schemas, models).
  If your insight is "the API takes these fields", it belongs there.
- `PROGRESS.md` — what's been done. If it's a status update, it belongs
  there.

`KNOWLEDGE.md` is for things like: "this module times out under load",
"this third-party API silently truncates strings over 1024 chars", "this
test is flaky on CI but stable locally — root cause is X".

## Format

Each entry is a level-3 heading followed by a structured body:

```
### YYYY-MM-DD — short title

- **what:** one sentence
- **why:** root cause or context
- **evidence:** commit SHA, PR link, or test output snippet
- **scope:** file, module, or system this applies to
- **revisit:** YYYY-MM-DD (default: 6 months out)
```

## Curation rules

- **Evidence required.** An entry without a commit SHA, PR, or test output
  is not knowledge. Delete on sight.
- **Quarterly prune.** Walk the file. For every entry past its `revisit:`
  date, validate it against the current code. Update, replace, or delete.
- **Contradictions surface, never overwrite.** If a new entry contradicts
  an older one and they cover the same scope, the older entry is replaced
  and the change is itself a learning. If scopes differ, both stay with
  their scopes spelled out.
- **No prophecy.** Do not record what you *think* will be a problem.
  Record what *was* a problem and what fixed it.
- **Compress over time.** Entries older than a year that have proven
  stable can be condensed into a single architecture-pattern note (or
  promoted to `TECHNICAL.md` if they describe a permanent contract).
  The detail belongs in git history; this file is the index.

## Entries

*(No entries yet. Run `/scout` on a real task; capture an insight via
`/learn` after evidence is in.)*
