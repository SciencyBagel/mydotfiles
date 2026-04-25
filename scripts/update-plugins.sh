#!/usr/bin/env bash
# update-plugins.sh — pull the latest version of each oh-my-zsh plugin submodule.
#
# Submodules track upstream HEAD. After this runs, the submodule pointers in
# this repo are advanced; you'll see them as modified in `git status`.
# Review and commit the bumps to land the new versions.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "Fetching upstream HEAD for each plugin submodule…"
git submodule update --init --remote --merge

echo
echo "Submodule status after update:"
git submodule status

echo
echo "Pointer changes (if any):"
if git diff --quiet --submodule=log -- home/.oh-my-zsh/custom/plugins; then
  echo "  (no changes — plugins already at latest)"
else
  git diff --submodule=log -- home/.oh-my-zsh/custom/plugins
  echo
  echo "To commit these updates:"
  echo "  git add home/.oh-my-zsh/custom/plugins"
  echo "  git commit -m 'chore: update oh-my-zsh plugin submodules'"
  echo "  git push"
fi
