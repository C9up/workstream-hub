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

It copies the hook to `.githooks/commit-msg` (commit that file so the team shares it) and runs
`git config core.hooksPath .githooks`. Git never enables hooks from a clone by itself: each clone runs the
`git config` command once. If `core.hooksPath` already points elsewhere, or a different `commit-msg` hook
exists, the script stops and asks for a manual merge.

The hook does not rewrite past commits.
