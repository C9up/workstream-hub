---
name: code-in-english
description: Everything that lives in the codebase is written in English (code, identifiers, comments, tests, commit messages, branch names, pull requests), while the conversation with the user and Workstream documents stay in the user's language. Use when writing or changing code, tests or comments, committing, naming a branch, or opening a pull request.
agents: [claude, codex, opencode, gemini]
git-hooks: [commit-msg, pre-commit]
---

# Code in English, conversation in the user's language

Two languages, each in its place.

## In the user's language

- The conversation with the user: answers, questions, explanations, summaries.
- Workstream documents (`.workstream/`: vision, epics, stories, bugs, journal, knowledge): they are written for
  the user, in the language of the documents already there.

## Always in English, even when the user writes in another language

- Code: identifiers (variables, functions, types, files, modules), log messages, error messages meant for
  developers.
- Comments and docstrings, including `TODO` / `FIXME` notes.
- Tests: test names, descriptions, assertion messages, fixtures written for the test.
- Commit messages, branch names, tags, pull request titles and descriptions, code review comments.
- Developer documentation kept with the code (`README`, `docs/`, `CONTRIBUTING`, changelogs), unless the
  project already keeps it in another language on purpose.

Text shown to the end users of the product follows the product's own languages: keep it in its translation
files (i18n) rather than hard-coding it, and write it in the language of that file.

Translate the user's intent, not their words: a request in French becomes an English commit message
(`Add the file cache`, not `Ajoute le cache des fichiers`). When changing a file that still has comments in
another language, write the new ones in English and leave the others unless asked to translate them.

## Safety net: the git hooks

`scripts/commit-msg` rejects a commit message that does not read as English; `scripts/pre-commit` rejects a
branch name, or a comment on an added line, that does not. Workstream installs them by itself when it installs
this skill in a project (`git-hooks` above), keeps them up to date with the skill and removes them with it; its
project diagnostic flags a clone where they are not active yet. Elsewhere, install them once per repository:

```sh
sh scripts/install.sh
```

The detection is a heuristic: an accented Latin letter, or two common words of French, German or Spanish.
Text between backticks or double quotes, URLs, `.workstream/` and prose files (`.md`, `.mdx`, `.txt`, `.rst`)
are not checked. It catches most slips, not all (a short message with no accent and a single common word goes
through): these instructions remain the rule. For a false positive, `git commit --no-verify`.

The installer makes `.githooks/commit-msg` and `.githooks/pre-commit` dispatchers that run every script of
`.githooks/<hook>.d/` (so other skills, such as `no-ai-signatures`, can add theirs), copies this skill's scripts
there, and runs `git config core.hooksPath .githooks`. A hook already in place keeps running, first
(`.githooks/<hook>.d/00-previous`). Commit `.githooks/` so the team shares it; git never enables hooks from a
clone by itself, so each clone runs the `git config` command once. If `core.hooksPath` points elsewhere, the
installer stops.

Linux, macOS and Windows: the hooks only need `sh`, `git`, `grep`, `awk`, `sed` and `tr`; Git for Windows runs
them with its bundled `sh`, so run the installer from Git Bash. Scripts are stored with LF line endings.
