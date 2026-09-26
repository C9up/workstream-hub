# Workstream repository

Skills, context, processes and knowledge shared across projects. Workstream adds them to its local
library (`~/.local/share/workstream/library/`); each project then copies what it uses (origin and
fingerprint recorded in `.workstream/skills.toml` and `.workstream/memory.toml`).

## Layout

| Folder | Content | Format |
|---|---|---|
| `skills/<name>/` | agent skills (Claude Code, Codex, OpenCode, Gemini) | `SKILL.md` (frontmatter `name`, `description`), plus optional scripts and references |
| `context/` | context: who the owner is, goals, way of working | `<name>.md`, `type: Contexte` |
| `processes/` | repeatable procedures, as numbered steps | `<name>.md`, `type: Processus` |
| `knowledge/` | lessons, preferences, mistakes not to repeat | `<name>.md`, `type: Leçon` / `Préférence` / `À ne pas refaire` |
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

## Rules

- One item per file (or per folder for a skill), named in lowercase, without accents, with hyphens.
- No secrets and no machine-specific paths.
- `index.json` is regenerated on every change. It will be signed (Workstream epic 14); a signature
  proves origin and integrity, not harmlessness: content stays inspectable before it is added.
