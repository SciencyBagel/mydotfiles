#!/usr/bin/env bash
# Move files or directories from $HOME into this repo's home/ tree, leaving symlinks behind.
# Usage: track.sh PATH [PATH ...] (relative paths use the current directory).
set -euo pipefail

if (($# == 0)); then
  printf 'Usage: %s PATH [PATH ...]\n' "$0" >&2
  exit 2
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
HOME_DIR="$(cd "$HOME" && pwd -P)"

for input in "$@"; do
  # Strip trailing slashes, then resolve only the parent so symlinks are not moved.
  path=$input
  while [[ "$path" == */ ]]; do path=${path%/}; done
  if [[ "$path" == */* ]]; then
    parent=${path%/*}
    [[ -n "$parent" ]] || parent=/
  else
    parent=.
  fi
  name=${path##*/}
  if [[ -z "$name" || "$name" == . || "$name" == .. ]] || ! source_dir="$(cd "$parent" && pwd -P)"; then
    printf 'track: invalid path: %s\n' "$input" >&2
    exit 1
  fi
  source="$source_dir/$name"

  case "$source" in
    "$HOME_DIR"/*) ;;
    *) printf 'track: outside $HOME: %s\n' "$input" >&2; exit 1 ;;
  esac
  case "$source" in
    "$REPO_ROOT"|"$REPO_ROOT"/*) printf 'track: already inside the repo: %s\n' "$input" >&2; exit 1 ;;
  esac
  case "$REPO_ROOT" in
    "$source"/*) printf 'track: cannot move a parent of the repo: %s\n' "$input" >&2; exit 1 ;;
  esac

  destination="$REPO_ROOT/home/${source#"$HOME_DIR"/}"
  if [[ -L "$source" ]]; then
    if [[ -e "$destination" && "$source" -ef "$destination" ]]; then
      printf 'Already tracked: %s\n' "$source"
      continue
    fi
    printf 'track: refusing to move a symlink: %s\n' "$input" >&2
    exit 1
  fi
  if [[ ! -f "$source" && ! -d "$source" ]]; then
    printf 'track: not a file or directory: %s\n' "$input" >&2
    exit 1
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    printf 'track: destination already exists: %s\n' "$destination" >&2
    exit 1
  fi

  mkdir -p "${destination%/*}"
  # Do not follow a symlinked repo directory out of the home/ tree.
  destination_dir="$(cd "${destination%/*}" && pwd -P)"
  case "$destination_dir" in
    "$REPO_ROOT/home"|"$REPO_ROOT/home/"*) ;;
    *) printf 'track: destination escapes the repo: %s\n' "$destination" >&2; exit 1 ;;
  esac
  mv "$source" "$destination"
  if ! ln -s "$destination" "$source"; then
    # Restore the original file if linking fails and the path is still free.
    if [[ ! -e "$source" && ! -L "$source" ]]; then
      mv "$destination" "$source" || true
    fi
    printf 'track: could not link %s (check %s)\n' "$source" "$destination" >&2
    exit 1
  fi
  printf 'Tracked: %s -> %s\n' "$source" "$destination"
done
