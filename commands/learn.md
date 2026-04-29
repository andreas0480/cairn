---
description: Append a durable insight to KNOWLEDGE.md, with required evidence.
argument-hint: <one-sentence insight>
---

# /learn — capture a durable insight

Append a new entry to `KNOWLEDGE.md`. Refuse to add an entry without
evidence.

## How to run this

1. **Gather the required fields.** If any are missing, ask the user before
   writing:

   - **what:** one-sentence summary
   - **why:** the underlying cause or context
   - **evidence:** one of — commit SHA, PR link, test output snippet,
     reproduction script. Anything you can point at.
   - **scope:** which file, module, or system this applies to
   - **revisit:** an absolute date (default: 6 months from today)

2. **Check for contradiction.** Read `KNOWLEDGE.md`. If an existing entry
   covers the same scope and contradicts the new one, surface both and
   ask the user which is correct. Do not silently overwrite.

3. **Append the entry at the top of the Entries section.** Use the format
   spec in `KNOWLEDGE.md`. Use today's actual date (run `date`, do not
   invent a timestamp).

4. **Confirm to the user.** Quote the inserted entry back so they can
   verify the wording.

## Refusal cases

Refuse to write the entry — and say why — if:

- no evidence was provided,
- the insight is speculative ("I think this might cause issues later"),
- the insight is generic engineering advice rather than a fact about
  *this* codebase.

## Examples

```
/learn "RAG retriever times out above 50 QPS — added pool cap"
/learn "Postgres FK on `orders.customer_id` is deferrable — required by import job"
```
