omz
===

Installs oh-my-zsh unattended. Skipped entirely if `~/.oh-my-zsh` already
exists. Also removes the freshly-installed `custom/` folder so the
`mydotfiles` role can replace it with a symlink into the repo.

Role Variables
--------------

- `omz_user` — user to install for (defaults to `target_user`).
- `omz_home` / `omz_dir` — resolved via `ansible_user_dir`, so this works
  unchanged on Linux and macOS.

Dependencies
------------

None. Must run before `mydotfiles` (see `playbooks/site.yml`), since that
role symlinks over `~/.oh-my-zsh/custom`.
