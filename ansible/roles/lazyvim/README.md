lazyvim
=======

Installs Neovim and the tool dependencies LazyVim needs (ripgrep, fd,
tree-sitter-cli, a Nerd Font, etc.) via Homebrew. Does not install the
LazyVim config itself — that's a separate repo (`jahir-nvim-config`),
vendored as a git submodule under `home/.config/nvim` and symlinked into
place by the `mydotfiles` role.

Role Variables
--------------

- `lazyvim_homebrew_packages` — package list
  (`roles/lazyvim/defaults/main/homebrew.yml`).
- `lazyvim_user` / `lazyvim_home` / `lazyvim_config_dir` — resolved via
  `ansible_user_dir`; currently unused by this role's tasks but available
  for future config-side tasks.

Dependencies
------------

None directly, but the config it supports is fetched by the `mydotfiles`
role, which should run after this one.
