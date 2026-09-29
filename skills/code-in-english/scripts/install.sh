#!/bin/sh
# Installs this skill's git hooks into the current repository. .githooks/<hook> becomes a dispatcher that runs
# every script of .githooks/<hook>.d/, so several skills can each add theirs; this skill's scripts go there.
set -e
name=code-in-english
hooks="commit-msg pre-commit"
root=$(git rev-parse --show-toplevel)
here=$(cd "$(dirname "$0")" && pwd)
current=$(git -C "$root" config --get core.hooksPath || true)
if [ -n "$current" ] && [ "$current" != ".githooks" ]; then
  echo "core.hooksPath is already set to $current: copy the scripts there by hand." >&2
  exit 1
fi
for hook in $hooks; do
  target="$root/.githooks/$hook"
  mkdir -p "$target.d"
  # A hook that is not the dispatcher keeps running, first; a copy of this skill's own script (older installer)
  # is simply replaced.
  if [ -f "$target" ] && ! cmp -s "$here/run-hooks" "$target"; then
    if cmp -s "$here/$hook" "$target"; then rm "$target"; else mv "$target" "$target.d/00-previous"; fi
  fi
  cp "$here/run-hooks" "$target"
  chmod +x "$target"
  cp "$here/$hook" "$target.d/$name"
done
git -C "$root" config core.hooksPath .githooks
echo "Installed: $hooks ($name) in $root/.githooks (core.hooksPath = .githooks)"
