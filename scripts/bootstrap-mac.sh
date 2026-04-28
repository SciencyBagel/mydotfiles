#!/usr/bin/env bash
# bootstrap-mac.sh — first-time (and re-runnable) setup on macOS.
#
# What it does:
#   1. Initializes/updates git submodules (oh-my-zsh plugins).
#   2. Installs oh-my-zsh if it isn't already there.
#   3. Uses GNU stow to symlink all files under home/ into $HOME.
#
# Idempotent — safe to re-run.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[1/3] Updating submodules…"
git -C "$REPO_ROOT" submodule update --init --recursive

echo "[2/3] Ensuring oh-my-zsh is installed…"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  already present at $HOME/.oh-my-zsh"
fi

echo "[3/3] Linking dotfiles into \$HOME…"
stow --restow --dir "$REPO_ROOT" --target "$HOME" home

echo "Done. Open a new shell to pick up changes."
