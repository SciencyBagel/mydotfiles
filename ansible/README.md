# ansible/

Provisioning for Linux hosts. The Mac side is handled by `../scripts/bootstrap-mac.sh`.

See the [top-level README](../README.md) for the full setup flow. This file
is just a quick reference for the Ansible bits.

## Run

From the repo root:

```sh
make provision-check                 # dry-run all hosts
make provision-linux                 # apply to all hosts
make provision-linux LIMIT=mypi-5    # target one host
make syntax-check                    # lint the playbook
```

Or directly:

```sh
ansible-playbook -i ansible/inventory.yml ansible/playbooks/site.yml
```

## Roles

| Role         | What it does |
| ------------ | ------------ |
| `common`     | Baseline packages and system setup. |
| `zsh`        | Installs zsh and oh-my-zsh; sets zsh as the user's default shell. |
| `neovim`     | Installs Neovim. The actual config is symlinked by the `mydotfiles` role. |
| `mydotfiles` | Clones this repo (with submodules) to `~/mydotfiles` on the target, then symlinks `.zshrc`, `.oh-my-zsh/custom`, `.config/nvim` into `$HOME`. |

Order in `playbooks/site.yml` matters: `common → zsh → neovim → mydotfiles`.
The zsh role creates `~/.oh-my-zsh/custom/` (via the upstream installer);
the mydotfiles role then replaces it with a symlink into the repo.

## Inventory

`inventory.yml` defines two groups:

- `raspberrypis` — the Pis on the home network.
- `desktops` — Linux desktop/workstation hosts.

Edit this file to add or remove hosts.

## Variables

Most role variables are in `roles/<role>/defaults/main.yml`. Notably both the
`zsh` and `mydotfiles` roles use `ansible_user_dir` (Ansible-discovered home
directory) so the same defaults work on Linux and macOS — no hardcoded
`/home/...` paths.
