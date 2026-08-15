common
======

Baseline system setup applied to every Linux host before any other role
runs: OS packages, Homebrew (incl. Linuxbrew on Linux), and zsh as the
default shell.

Role Variables
--------------

- `common_user` — user to configure (defaults to `target_user`).
- `common_system_packages` / `common_homebrew_packages` — base package
  lists (`roles/common/defaults/main/`).
- `common_homebrew_packages_extra` — per-host additions, set in
  `group_vars/<group>/main.yml` (e.g. `desktops` adds `tmux`).

Dependencies
------------

None. Runs first in `playbooks/site.yml`.
