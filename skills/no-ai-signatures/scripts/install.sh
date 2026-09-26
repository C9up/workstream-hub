#!/bin/sh
# Installs the commit-msg hook that strips AI agent signatures into the current git repository:
# copies it to .githooks/ (versioned, shared with the team) and points git at that folder.
set -e
root=$(git rev-parse --show-toplevel)
here=$(cd "$(dirname "$0")" && pwd)
current=$(git -C "$root" config --get core.hooksPath || true)
if [ -n "$current" ] && [ "$current" != ".githooks" ]; then
  echo "core.hooksPath is already set to $current: copy $here/commit-msg there instead." >&2
  exit 1
fi
if [ -e "$root/.githooks/commit-msg" ] && ! cmp -s "$here/commit-msg" "$root/.githooks/commit-msg"; then
  echo "$root/.githooks/commit-msg already exists and differs: merge it by hand." >&2
  exit 1
fi
mkdir -p "$root/.githooks"
cp "$here/commit-msg" "$root/.githooks/commit-msg"
chmod +x "$root/.githooks/commit-msg"
git -C "$root" config core.hooksPath .githooks
echo "Installed: $root/.githooks/commit-msg (core.hooksPath = .githooks)"
