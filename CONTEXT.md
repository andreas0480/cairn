# Cairn context

Living snapshot of this repository. Edited to be correct, never appended to. Session history is in
`status/`.

Written 2026-10-12 from the repository alone (files and git history). Nothing below was checked against
GitHub, the blog, or any project that has Cairn installed.

## What Cairn is

A workflow layer for solo Claude Code work: four slash commands and a block of conventions that tell
Claude when to read and write a project's context files. It assumes the five-file layout from the
context-aware starter prompt (`CLAUDE.md`, `PROGRESS.md`, `DECISIONS.md`, `TECHNICAL.md`, `HANDOVER.md`)
and adds `KNOWLEDGE.md` for observed runtime quirks. Source: `README.md`, `CLAUDE.md`.

| Piece | File | What it does |
|---|---|---|
| Conventions | `CLAUDE.md` | Session protocol, T1/T2/T3 tiering, write-as-you-go, evidence rules, two-attempt stop |
| `/scout` | `commands/scout.md` | Does a task with discovery scaled to its tier, then appends a line to `PROGRESS.md` |
| `/recall` | `commands/recall.md` | Reads across the context files and surfaces the relevant entries. Read-only |
| `/learn` | `commands/learn.md` | Routes an insight to `KNOWLEDGE.md`, `DECISIONS.md` or `TECHNICAL.md`; refuses without evidence |
| `/handover` | `commands/handover.md` | Overwrites `HANDOVER.md` at session end |
| Knowledge template | `KNOWLEDGE.md` | Empty template with entry format and curation rules |
| Installer | `install.sh` | See below |

**`CLAUDE.md` in this repo is the shipped product**, not this repo's own operating rules. Its session
protocol points at `PROGRESS.md` and `HANDOVER.md`, which do not exist here. This repo is run under the
ventures conventions instead: `CONTEXT.md` and `status/` (`~/ventures/AGENTS.md`).

## Build and install

There is no build step and no dependency. Everything is Markdown plus one Bash script.

`install.sh` fetches files with `curl` from `https://raw.githubusercontent.com/andreas0480/cairn/<branch>`
(default `main`) into a target directory (default the current directory, or `--target`):

- the four commands into `<target>/.claude/commands/`, overwritten on every run
- `KNOWLEDGE.md` only if the target has none
- `CLAUDE.md`: the Cairn block between `<!-- BEGIN cairn -->` and `<!-- END cairn -->` is removed and
  re-appended at the end of the file, or the file is created with only that block

Because it reads from GitHub, the installer installs whatever is on the remote branch, not the local
working tree. Usage is in `README.md`.

## Current state

| Item | State | Source |
|---|---|---|
| Last commit | `8b6a451` 2026-04-29, "Add curl-pipe-bash install script" | `git log` |
| Commits | 3, all 2026-04-29, author andreas0480 | `git log` |
| Remote | `origin` = `git@github.com:andreas0480/cairn.git`; local `origin/main` equals `main` at `8b6a451` | `git remote -v`, `git rev-parse` (no fetch made) |
| License | MIT, Andreas Belitz, 2026 | `LICENSE` |
| Tests | None in the repo. The commit message of `8b6a451` says `install.sh` was tried by hand in four scenarios; no script records it | `git log` |
| `KNOWLEDGE.md` entries | None (template only) | `KNOWLEDGE.md` |
| Portfolio row | "No status file. Last commit 2026-04-29", phase unknown | `~/ventures/portfolio.md` |

## Not known

Answering any of these needs something outside the repository.

- **Whether GitHub matches local.** No `git fetch` was run; `origin/main` is as of the last fetch.
- **Whether the GitHub repo is public.** The curl install only works if it is.
- **Whether Cairn is installed anywhere**, and whether anyone uses it.
- **Whether the starter-prompt post exists** at `https://blog.belitz.se/posts/context-aware-starter-prompt`.
  `README.md` and `CLAUDE.md` link to it; the `belitz-blog` repo was not checked.
- **What Cairn's status is now.** Active, paused, or replaced by the `project-scaffolding` and `done`
  skills (see open threads). No decision record exists either way.

## Open threads

- **Overlap with project-scaffolding.** Cairn prescribes `PROGRESS.md` + `HANDOVER.md` + `DECISIONS.md`;
  the ventures convention (from 2026-10-12) uses `CONTEXT.md` + `status/` + `decisions/NNNN-*.md` and a
  `/done` skill. Both cover session state and decisions. Which one Cairn should follow, or whether it
  should be retired, is Andreas's call.
- **Register.** `README.md`, `CLAUDE.md`, `KNOWLEDGE.md`, the commands and `install.sh` use em dashes
  throughout, which the `register` skill does not allow. Not changed: the files are the published product.
- **No README in `commands/`.** project-scaffolding asks for one per folder. `install.sh` fetches named
  files only, so adding one would not reach installs.
- **`.claude/` is not in `.gitignore`.** The worktree used on 2026-10-12 lives under
  `.claude/worktrees/` and shows as untracked in the main checkout.
- **Hard links into a backup.** The files in the main checkout share inodes with
  `~/backup/pre-restructure-20261012/server-management/cairn/`. An in-place edit there changes the backup
  copy too.
