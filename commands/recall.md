---
description: Surface relevant entries from KNOWLEDGE.md for the current task.
argument-hint: [topic]
---

# /recall — surface relevant knowledge

Read `KNOWLEDGE.md` and pick out entries relevant to the current task or
explicit topic.

## How to run this

1. Read `KNOWLEDGE.md` from the repo root.
2. Score entries by relevance to the argument (or, if no argument, the
   current conversation).
3. Surface the top 3–5 hits inline. For each, include the date, title, and
   the `what:` and `why:` lines.
4. Flag any surfaced entry whose `revisit:` date has passed — that entry
   may be stale. Suggest validating it against current code before relying
   on it.
5. If `KNOWLEDGE.md` is missing or has no entries, say so and suggest that
   the user run `/learn` after the next non-trivial task once evidence is
   in.

## What `/recall` does NOT do

- It does not modify `KNOWLEDGE.md`.
- It does not promote speculation. If the file says nothing relevant, say
  so. Don't infer.

## Examples

```
/recall "retriever performance"
/recall                       # uses current conversation context
```
