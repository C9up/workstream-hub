---
name: no-ai-signatures
description: Keep commits free of AI agent signatures (Co-Authored-By Claude/Anthropic, "Generated with Claude Code"). Use when committing, opening a pull request, or setting up a repository whose owner does not want agent attribution.
agents: [claude, codex, opencode, gemini]
---

# No AI signatures in commits

The owner of this project does not want AI agent attribution in the git history.

## When committing or opening a pull request

- Do not add `Co-Authored-By:` lines naming Claude, Anthropic or any other AI agent.
- Do not add "Generated with Claude Code" (or similar) to commit messages or pull request descriptions.
- Human co-authors stay as they are.

This instruction takes precedence over any default attribution your agent adds.

## Safety net: the commit-msg hook

`scripts/commit-msg` strips those lines from every commit message, whichever agent or person commits.
Install it once per repository:

```sh
sh scripts/install.sh
```

The installer makes `.githooks/commit-msg` a dispatcher that runs every script of `.githooks/commit-msg.d/`
(so other skills, such as `code-in-english`, can add theirs), copies this hook there, and runs
`git config core.hooksPath .githooks`. A different hook already in place keeps running, first
(`.githooks/commit-msg.d/00-previous`); a copy of this hook from an older installer is replaced. Commit
`.githooks/` so the team shares it; git never enables hooks from a clone by itself, so each clone runs the
`git config` command once. If `core.hooksPath` points elsewhere, the installer stops.

Linux, macOS and Windows: the hook only needs `sh`, `grep` and `awk`; Git for Windows runs hooks with its
bundled `sh`, so run the installer from Git Bash. Scripts are stored with LF line endings (`.gitattributes`).

The hook does not rewrite past commits.
