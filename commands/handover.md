---
description: Write or refresh HANDOVER.md at session end so the next session can pick up cleanly.
argument-hint: [optional note for the next session]
---

# /handover — session transition snapshot

Write `HANDOVER.md` so the next session can pick up cleanly without
reconstructing context from a degraded conversation. `HANDOVER.md` is
overwritten each session — it's a snapshot, not a log.

## When to run this

- At the end of every working session. **No exceptions.** Even short
  sessions get a handover; they're cheap to write.
- When you detect drift mid-session and recommend a reset, run this
  before the user starts a fresh session.
- Before any extended break (lunch, end of day) where context might be
  lost.

## Required content

Read `PROGRESS.md` and any open `TaskCreate` items first to ground the
snapshot in real state, not memory. Then write `HANDOVER.md` with these
sections:

1. **Active task** — what was being worked on at the moment of handover.
   One sentence. State whether it's complete, in progress, or blocked.
2. **What landed this session** — a terse list of what changed. If
   anything was committed, include the commit SHAs. If `PROGRESS.md` was
   already updated per task, you can reference it: *"see PROGRESS.md
   entries from $TODAY"*.
3. **Decisions made** — any new entries appended to `DECISIONS.md` this
   session, with one-line summaries and references to the entries
   themselves.
4. **Constraints carrying forward** — non-obvious things the next session
   must respect. Things you'd otherwise have to re-learn.
5. **Concrete next steps** — enough detail that a cold session, having
   read this file plus `CLAUDE.md` and `PROGRESS.md`, can start the next
   action without ambiguity.
6. **Open questions** — anything unresolved, including things waiting on
   the human stakeholder.

## Rules

- **Overwrite, don't append.** `HANDOVER.md` describes *now*, not history.
  The history lives in `PROGRESS.md`, `DECISIONS.md`, and git.
- **Be terse.** Bullets, not prose. Aim for under one screen.
- **Cite, don't restate.** If a decision was logged in `DECISIONS.md`,
  reference the entry instead of re-explaining the rationale.
- **Use today's actual date.** Run `date`, don't invent a timestamp.
- **Include the optional note** if the user passed one as argument —
  put it under a "Note to next session" heading.

## Format template

```markdown
# Handover — {YYYY-MM-DD}

## Active task
{one sentence; status}

## Landed this session
- {item} ({commit-sha or PROGRESS reference})
- ...

## Decisions made
- {DECISIONS.md entry title} — {one-line summary}

## Constraints carrying forward
- {non-obvious constraint the next session must respect}
- ...

## Concrete next steps
1. {first action; enough detail for a cold start}
2. ...

## Open questions
- {unresolved item, with who is blocked / what's needed}
```

## What `/handover` does NOT do

- It does not commit or push anything.
- It does not generate `PROGRESS.md` or `DECISIONS.md` entries — those
  should already exist from the in-flow updates during the session.
  `/handover` only references them.
- It does not summarize conversation. It captures *project state*, not
  dialogue history.
