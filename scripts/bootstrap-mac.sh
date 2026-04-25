#!/usr/bin/env bash
# bootstrap-mac.sh — first-time (and re-runnable) setup on macOS.
#
# What it does:
#   1. Initializes/updates git submodules (oh-my-zsh plugins).
#   2. Installs oh-my-zsh if it isn't already there.
#   3. Symlinks ~/.zshrc, ~/.oh-my-zsh/custom, ~/.config/nvim into this repo.
#
# Idempotent — safe to re-run. Pass --force to overwrite existing non-symlink files.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOME_TREE="$REPO_ROOT/home"

force=0
for arg in "$@"; do
  case "$arg" in
    --force|-f) force=1 ;;
    -h|--help)
      sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
  esac
done

echo "[1/3] Updating submodules…"
git -C "$REPO_ROOT" submodule update --init --recursive

echo "[2/3] Ensuring oh-my-zsh is installed…"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  already present at $HOME/.oh-my-zsh"
fi

link() {
  local src="$1" dest="$2"
  if [[ -L "$dest" ]]; then
    ln -sfn "$src" "$dest"
    echo "  relinked $dest -> $src"
  elif [[ -e "$dest" ]]; then
    if (( force )); then
      rm -rf "$dest"
      ln -sfn "$src" "$dest"
      echo "  replaced $dest -> $src (--force)"
    else
      echo "  SKIP $dest (exists, not a symlink). Re-run with --force to overwrite."
      return
    fi
  else
    mkdir -p "$(dirname "$dest")"
    ln -sfn "$src" "$dest"
    echo "  linked $dest -> $src"
  fi
}

echo "[3/3] Linking dotfiles into \$HOME…"
link "$HOME_TREE/.zshrc"               "$HOME/.zshrc"
link "$HOME_TREE/.oh-my-zsh/custom"    "$HOME/.oh-my-zsh/custom"
link "$HOME_TREE/.config/nvim"         "$HOME/.config/nvim"

echo "Done. Open a new shell to pick up changes."
