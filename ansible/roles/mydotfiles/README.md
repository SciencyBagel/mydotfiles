mydotfiles
==========

Clones this repo (recursively, so submodules — oh-my-zsh plugins and the
`jahir-nvim-config` nvim submodule — come with it) to `~/mydotfiles` on the
target, then uses GNU stow to symlink everything under `home/` into
`$HOME`. Always force-pulls `main`, so the target's clone is reset back to
origin on every run — it's a deployment target, not something to edit
in place.

Role Variables
--------------

- `mydotfiles_user` / `mydotfiles_user_home` — resolved via
  `ansible_user_dir`.
- `mydotfiles_repo` / `mydotfiles_repo_dest` — clone source and
  destination (`roles/mydotfiles/defaults/main.yml`).

Dependencies
------------

Runs last in `playbooks/site.yml`, after `omz` and `lazyvim` — it symlinks
over `~/.oh-my-zsh/custom` and `~/.config/nvim`, so both need to exist (or
not conflict) first. Requires the target user's SSH access (via agent
forwarding, per `ansible.cfg`'s `ForwardAgent=yes`) to cover both
`mydotfiles` and `jahir-nvim-config` — both are SSH-only clones.
