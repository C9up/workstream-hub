# Dépôt Workstream

Skills, contexte, processus et connaissances à partager entre projets. Workstream les ajoute à sa
bibliothèque locale (`~/.local/share/workstream/library/`), puis chaque projet en copie ce qu'il utilise
(provenance et empreinte notées dans `.workstream/skills.toml` et `.workstream/memory.toml`).

## Organisation

| Dossier | Contenu | Format |
|---|---|---|
| `skills/<nom>/` | skills d'agents (Claude Code, Codex, OpenCode, Gemini) | `SKILL.md` (frontmatter `name`, `description`), plus scripts et références éventuels |
| `context/` | contexte : qui, objectifs, façon de travailler | `<nom>.md`, `type: Contexte` |
| `processes/` | procédures répétables, en étapes numérotées | `<nom>.md`, `type: Processus` |
| `knowledge/` | leçons, préférences, erreurs à ne pas refaire | `<nom>.md`, `type: Leçon` / `Préférence` / `À ne pas refaire` |
| `index.json` | catalogue du dépôt : une entrée par élément, avec son empreinte | généré, ne pas modifier à la main |

## Documents de mémoire

Markdown à frontmatter (compatible OKF) :

```markdown
---
type: Processus
title: "Publier une release"
description: "Taguer, laisser la CI construire, relire les notes, publier."
tags: [release, ci]
status: draft
created: 2026-09-26
---

# Publier une release

1. …
```

## Règles

- Un élément par fichier (ou par dossier pour une skill), nommé en minuscules, sans accents, avec des tirets.
- Pas de secret ni de chemin propre à une machine.
- `index.json` est régénéré à chaque changement ; il sera signé (epic 14 de Workstream), la signature
  prouvant la provenance et l'intégrité, pas l'innocuité : le contenu reste inspectable avant ajout.
