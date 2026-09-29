# Workstream repository

Skills, context, processes, knowledge and plugins shared across projects. Workstream adds skills and memory
documents to its local library (`~/.local/share/workstream/library/`); each project then copies what it uses
(origin and fingerprint recorded in `.workstream/skills.toml` and `.workstream/memory.toml`). Plugins install
straight into a project, from the Plugins page of Workstream.

## Layout

| Folder | Content | Format |
|---|---|---|
| `skills/<name>/` | agent skills (Claude Code, Codex, OpenCode, Gemini) | `SKILL.md` (frontmatter `name`, `description`), plus optional scripts and references |
| `context/` | context: who the owner is, goals, way of working | `<name>.md`, `type: Contexte` |
| `processes/` | repeatable procedures, as numbered steps | `<name>.md`, `type: Processus` |
| `knowledge/` | lessons, preferences, mistakes not to repeat | `<name>.md`, `type: Leçon` / `Préférence` / `À ne pas refaire` |
| `plugins/<name>/` | project dashboards: a sandboxed WASM module that returns a view Workstream draws | `plugin.toml` (title, description, `[measure] wasm`, `[permissions]`), plus the `.wasm` module |
| `index.json` | repository catalogue: one entry per item, with its fingerprint | generated, do not edit by hand |

## Memory documents

Markdown with a frontmatter (OKF-compatible):

```markdown
---
type: Processus
title: "Publish a release"
description: "Tag, let CI build, review the notes, publish."
tags: [release, ci]
status: draft
created: 2026-09-26
---

# Publish a release

1. …
```

The `type` values are Workstream's document types and stay as they are, whatever the language of the text.

## Optional fields

Both in a skill's `SKILL.md` and in a memory document's frontmatter:

| Field | Meaning |
|---|---|
| `requires: [other-item]` | items of this repository added along with this one |
| `agents: [claude, codex]` | agents the item works with (`claude`, `codex`, `opencode`, `gemini`); omitted: all |

## Rules

- One item per file (or per folder for a skill), named in lowercase, without accents, with hyphens.
- No secrets and no machine-specific paths.
- No AI agent signatures in commits: enable the hook once with `git config core.hooksPath .githooks`.
- `index.json` is regenerated and signed (`index.json.sig`, ed25519) on every change; a signature proves
  origin and integrity, not harmlessness: content stays inspectable before it is added.

## Signature

Public key (base64):

```
pkNP/0Elq5Are1ZV1IxWqg0IP+pJVwKj+3nH5b9FHGU=
```

Check a clone with `workstream repo verify --pubkey pkNP/0Elq5Are1ZV1IxWqg0IP+pJVwKj+3nH5b9FHGU= .`

## Origin

Documents tagged `mr-mak` come from [Mr. Mak Workspace](https://github.com/witnesstodark/mr-mak-workspace)
(commit `de0f88b`), with a Workstream frontmatter added; some are adapted to Workstream (see their `source` field). MIT License — Copyright (c) 2026
Mr. Mak Workspace contributors; full text in [`LICENSE-mr-mak`](LICENSE-mr-mak).
