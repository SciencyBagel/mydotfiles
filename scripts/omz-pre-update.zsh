#!/usr/bin/env zsh
set -euo pipefail

cd ~/.oh-my-zsh || exit 1

if [[ -L "custom" ]]; then
  symlink_path="$(realpath -s custom)"
  rm custom
  mkdir custom
  echo "✅ Symlink \"$symlink_path\" removed. Safe to update now."
else
  echo "⚠️ 'custom' is not a symlink. Skipping."
fi
