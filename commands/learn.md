---
description: Capture a durable insight, routed to the right context file, with required evidence.
argument-hint: <one-sentence insight>
---

# /learn — capture a durable insight

Append a new entry to the right file in the context layer. Refuse to write
without evidence.

## Routing — pick the right file

Decide which file the insight belongs in. If unclear, ask the user.

- **`KNOWLEDGE.md`** — runtime quirks, fragile modules, observed gotchas,
  API timeouts, surprising behaviors. *Backward-looking* — "this was a
  problem; here's what fixed it." Default destination if uncertain.
- **`DECISIONS.md`** — architectural decisions, framework/library choices,
  schema or API design constraints. *Forward-looking* — "we chose X
  because Y." Use the ADR format already in that file.
- **`TECHNICAL.md`** — implementation specifications: contracts, data
  models, interface signatures, infrastructure details. Update the
  relevant section in place; this file mutates with the architecture.

If a single insight spans more than one of these, write the parts to
their respective files and cross-reference. Do not duplicate full entries.

## Required fields

For `KNOWLEDGE.md` entries, all of:

- **what:** one-sentence summary
- **why:** the underlying cause or context
- **evidence:** one of — commit SHA, PR link, test output snippet,
  reproduction script. Anything you can point at.
- **scope:** which file, module, or system this applies to
- **revisit:** an absolute date (default: 6 months from today)

For `DECISIONS.md` entries:

- **decision:** what was decided
- **alternatives:** what else was considered
- **rationale:** why this choice
- **date and reference:** today's date plus a commit/PR/issue link
- **supersedes:** if this replaces an earlier decision, name it explicitly
  (and do not delete the older entry — keep the chain visible)

## Refusal cases

Refuse to write the entry — and say why — if:

- no evidence was provided,
- the insight is speculative ("I think this might cause issues later"),
- the insight is generic engineering advice rather than a fact about
  *this* codebase,
- the destination file already has a contradicting entry covering the
  same scope and the user hasn't acknowledged the conflict.

## How to run this

1. **Decide the destination** based on the routing rules above. State
   the destination in your response so the user can correct it.
2. **Gather the required fields.** If any are missing, ask the user.
3. **Check for contradiction.** Read the destination file. If an
   existing entry covers the same scope and contradicts the new one,
   surface both and ask which is correct. For `DECISIONS.md`, the
   resolution is to append the new entry with a `supersedes:` reference,
   not overwrite. For `KNOWLEDGE.md`, replace if the older entry is
   wrong; otherwise keep both with distinct scopes.
4. **Use today's actual date** (run `date`, do not invent a timestamp).
5. **Append the entry.** For `KNOWLEDGE.md`, at the top of the Entries
   section. For `DECISIONS.md`, follow the file's existing convention.
6. **Confirm to the user.** Quote the inserted entry back so they can
   verify the wording.

## Examples

```
/learn "RAG retriever times out above 50 QPS — added pool cap"
   → KNOWLEDGE.md (runtime quirk, observed)

/learn "chose Postgres over Mongo — strong relational shape, audit log needs"
   → DECISIONS.md (architectural decision)

/learn "orders.customer_id FK is DEFERRABLE — required by import job"
   → KNOWLEDGE.md (gotcha) and TECHNICAL.md schema section (spec)
```
