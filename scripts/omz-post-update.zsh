#!/usr/bin/env zsh
set -euo pipefail

tracked_folder="$MYDOTFILES_PATH/home/.oh-my-zsh/custom"

cd ~/.oh-my-zsh || exit 1

if [[ -L "custom" ]]; then
  echo "⚠️ 'custom' is already a symlink. Skipping." >&2
  exit 1
fi

if [[ -d "custom" ]]; then
  rm -rf custom
fi

ln -s "$tracked_folder" custom
echo "✅ Tracked folder re-linked successfully: $(realpath -s custom)"
