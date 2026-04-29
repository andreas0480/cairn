# Cairn

A thin SDLC framework for solo Claude Code work.

A cairn is a stack of stones marking a trail. It points the way without
dictating your route. That is the design intent.

## What this is

Three slash commands, one knowledge file, one `CLAUDE.md`. Six files total.
No state machines, no per-phase document chains, no generators.

```
cairn/
  README.md          ← you are here
  CLAUDE.md          ← drop into your repo root (or merge with existing)
  KNOWLEDGE.md       ← drop into your repo root
  commands/
    scout.md         ← drop into <repo>/.claude/commands/
    recall.md
    learn.md
```

## What it solves

Five problems worth solving on every non-trivial change in AI-assisted work:

- **Discovery before code.** Map blast radius. Check existing tests. Read
  what the project already knows about the area.
- **Memory across sessions.** Persist what you've learned. Quirks, fragile
  modules, APIs that time out — all of that lives in your head if it lives
  anywhere.
- **Evidence over assertion.** "Verified" / "works" / "looks good" are
  claims, not proofs. Show the command and the output, then state the
  conclusion.
- **A stop condition.** Two failed attempts on the same approach is enough.
  A third is a hunch dressed as effort.
- **A trace someone can read.** The git log and the diff are the audit
  trail with a real audience. Per-phase documents are paperwork.

These five are inexpensive to enforce and large in effect. Cairn is the
smallest framework that enforces them without becoming bureaucracy.

## Install

```bash
cp cairn/commands/*.md /path/to/your-repo/.claude/commands/
cp cairn/CLAUDE.md     /path/to/your-repo/CLAUDE.md
cp cairn/KNOWLEDGE.md  /path/to/your-repo/KNOWLEDGE.md
```

If your repo already has a `CLAUDE.md`, merge the conventions section in
manually. Cairn doesn't try to own the whole file.

## Usage

```
/scout "fix login button returning 500"
/scout PROJ-123
/scout --tier 3 "implement dark mode toggle"

/recall "retriever performance"
/recall                       # uses current task context

/learn "RAG retriever times out above 50 QPS — added pool cap"
```

## The tier rubric

| Tier | Examples | Discovery |
|------|----------|-----------|
| **T1** | typo, rename, comment, format change | none — edit and save |
| **T2** | contained fix in one module, single-file feature | grep callers, check existing tests, plan in one sentence |
| **T3** | non-trivial bug, new feature, multi-module change | recall, blast radius, plan, red-green tests, regression check, optional `/learn` |

The agent declares the tier in its first response. Override with `--tier N`.
The point of tiering is to avoid enforcing the same machinery on a typo and
a multi-module refactor.

## When Cairn is the wrong tool

Cairn is the floor for solo work. Below it you're vibe-coding; above it
you're paying ceremony tax. Pick something heavier when you need any of:

- compliance-grade audit trails,
- multi-team standardization across many engineers,
- long unattended autonomous runs,
- cross-workflow state that must survive crashes.

## License

MIT.
