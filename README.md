# Cairn

A thin SDLC framework for solo Claude Code work.

A cairn is a stack of stones marking a trail. It points the way without
dictating your route. That is the design intent.

## What this is

Cairn is the **workflow layer** that sits on top of an externalized
context system. It does not own the context — your project's `.md` files
do. Cairn tells Claude how to *use* them on every workflow: when to read,
when to write, what to log, when to stop.

It ships as four slash commands and a CLAUDE.md you merge into your
existing project conventions. That's it.

```
cairn/
  README.md           ← you are here
  CLAUDE.md           ← merge into your project's CLAUDE.md
  KNOWLEDGE.md        ← drop into your repo root
  commands/
    scout.md          ← drop into <repo>/.claude/commands/
    recall.md
    learn.md
    handover.md
```

## The substrate Cairn assumes

Cairn layers on top of the five-file context architecture from the
[context-aware starter prompt](https://blog.belitz.se/posts/context-aware-starter-prompt).
If your project doesn't have these files yet, run the starter prompt
first to bootstrap them; then layer Cairn on top.

| File | Purpose | Cadence |
|------|---------|---------|
| `CLAUDE.md` | Project constitution — stakeholder, objectives, standards | Rarely (after discovery) |
| `PROGRESS.md` | Living build log — done / in progress / next / blocked | Every completed task |
| `DECISIONS.md` | ADR — every constraining technical choice with rationale | Every major decision |
| `TECHNICAL.md` | Implementation details — stack, contracts, data models | As architecture evolves |
| `HANDOVER.md` | Session transition snapshot — overwritten each session | End of every session |
| `KNOWLEDGE.md` | Runtime quirks, fragile modules, observed gotchas | Via `/learn` with evidence |

The first five files are owned by the starter-prompt protocol. The sixth
(`KNOWLEDGE.md`) is Cairn's addition — backward-looking gotchas that
don't belong in `DECISIONS.md` (forward-looking) or `TECHNICAL.md`
(specs). Each Cairn command knows which files to touch.

## What Cairn enforces

The starter prompt establishes the *what* (the file architecture). Cairn
adds the *how* — the workflow protocol that's mostly already in the
starter prompt, applied per-task:

- **Discovery proportional to risk.** Tier the work; don't run a 5-step
  ceremony on a typo.
- **Session-start protocol.** First response in every session reads
  `CLAUDE.md` + `PROGRESS.md` + `HANDOVER.md` before touching anything.
- **Write as you go.** `PROGRESS.md` after every completed task,
  `DECISIONS.md` the moment a constraining decision is made.
- **10–15 exchange checkpoint.** Silent self-check against `CLAUDE.md`
  and `DECISIONS.md` to catch drift early.
- **Re-anchor before significant implementation.** Re-read the relevant
  `DECISIONS.md` entries; never assume prior context is still active.
- **Show evidence, never claim.** Output or it didn't happen.
- **Stop at two attempts.** Don't grind on a hunch.
- **Drift → reset.** When the conversation degrades, run `/handover` and
  start fresh.
- **Files are the source of truth.** Memory loses to files. Always.

## Install

One line, from the directory you want to install into:

```bash
curl -fsSL https://raw.githubusercontent.com/andreas0480/cairn/main/install.sh | bash
```

Or into a specific path:

```bash
curl -fsSL https://raw.githubusercontent.com/andreas0480/cairn/main/install.sh | bash -s -- --target /path/to/your-repo
```

The installer is idempotent — re-run it any time to pick up updates.
It drops the four slash commands into `.claude/commands/`, creates
`KNOWLEDGE.md` if missing (never overwrites your entries), and either
creates `CLAUDE.md` from scratch or appends/updates the Cairn section
between `<!-- BEGIN cairn -->` / `<!-- END cairn -->` markers in your
existing one.

You should already have a `CLAUDE.md` from the starter prompt for the
context layer to work. If not, the installer creates a minimal one with
just the Cairn section and tells you to bootstrap the rest.

### Manual install

If you'd rather not curl-pipe-bash:

```bash
git clone https://github.com/andreas0480/cairn.git
cp cairn/commands/*.md /path/to/your-repo/.claude/commands/
cp cairn/KNOWLEDGE.md  /path/to/your-repo/KNOWLEDGE.md
# Append cairn/CLAUDE.md to your existing CLAUDE.md (or copy it whole)
```

## Usage

```
/scout "fix login button returning 500"
/scout PROJ-123
/scout --tier 3 "implement dark mode toggle"

/recall "retriever performance"
/recall                       # uses current task context

/learn "RAG retriever times out above 50 QPS — added pool cap"
/learn "chose Postgres over Mongo — strong relational shape"

/handover                     # at session end, no exceptions
/handover "watch out for the migration in branch X"
```

## The tier rubric

| Tier | Examples | Discovery |
|------|----------|-----------|
| **T1** | typo, rename, comment, format change | none — edit and save |
| **T2** | contained fix in one module, single-file feature | grep callers, check tests, plan in one sentence |
| **T3** | non-trivial bug, new feature, multi-module change | `/recall` across the context layer, blast radius, plan, red-green tests, regression check, `/learn` if anything durable surfaced |

The agent declares the tier in its first response. Override with
`--tier N`. The point of tiering is to avoid enforcing the same machinery
on a typo and a multi-module refactor.

## How `/learn` routes

| Insight type | Destination | Format |
|--------------|-------------|--------|
| Runtime quirk, fragile module, observed gotcha | `KNOWLEDGE.md` | what / why / evidence / scope / revisit |
| Architectural decision, framework choice | `DECISIONS.md` | decision / alternatives / rationale / date / supersedes |
| Implementation spec (contract, schema, model) | `TECHNICAL.md` | update the relevant section in place |
| Build progress | `PROGRESS.md` (auto, by `/scout`) | terse single-line per task |

If a single insight spans multiple files, `/learn` splits it and
cross-references. It refuses to write without evidence.

## When Cairn is the wrong tool

Cairn is the floor for solo work backed by a curated context layer.
Below it you're vibe-coding; above it you're paying ceremony tax. Pick
something heavier when you need any of:

- compliance-grade audit trails,
- multi-team standardization across many engineers,
- long unattended autonomous runs,
- cross-workflow state that must survive crashes.

## License

MIT.
