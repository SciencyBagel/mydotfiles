# mydotfiles

Personal dotfiles + Ansible provisioning. macOS is the source of truth; Ansible
deploys the same config to Linux hosts (Raspberry Pis, Linux stations).

## Layout

```
home/                  # source-of-truth dotfiles, used on every host
  .zshrc               # one file, cross-platform (uses $OSTYPE conditionals)
  .oh-my-zsh/custom/   # aliases, themes, plugins (each plugin is a git submodule)
  .config/nvim/        # LazyVim config
ansible/               # provisioning for Linux hosts
  inventory.yml        # hosts (raspberrypis, stations)
  playbooks/           # site.yml entry point
  roles/               # common, zsh, neovim, mydotfiles
  scripts/             # bootstrap.bash for fresh hosts
scripts/               # local (non-Ansible) helpers
  bootstrap-mac.sh     # first-time Mac setup
  update-plugins.sh    # pull latest plugin submodule versions
Makefile               # `make help` lists everything
```

## First-time setup

### macOS

```sh
git clone --recurse-submodules git@github.com:SciencyBagel/mydotfiles.git ~/mydotfiles
cd ~/mydotfiles
make bootstrap-mac
```

This pulls the plugin submodules, installs oh-my-zsh if needed, and symlinks
`~/.zshrc`, `~/.oh-my-zsh/custom`, `~/.config/nvim` into this repo.

If you already have one of those paths as a regular file, the script skips it
and tells you. Re-run with `--force` to overwrite:

```sh
./scripts/bootstrap-mac.sh --force
```

### Linux (Pi or station)

From your Mac, after editing `ansible/inventory.yml` to include the host:

```sh
make provision-check     # dry-run, see what would change
make provision-linux     # apply
```

To target a single host or group: `make provision-linux LIMIT=mypi-5`.

The Ansible flow installs zsh + oh-my-zsh, clones this repo on the target
(with submodules), then symlinks the same dotfiles into `$HOME` there.

## Daily edit loop

1. Edit something in `home/` on Mac (e.g. add an alias to `home/.zshrc`).
2. Open a new shell — the change is live (you're symlinked to it).
3. Commit + push.
4. On each Linux host, re-run `make provision-linux` (or have it ssh in
   automatically — your call).

## Adding a new oh-my-zsh plugin

```sh
git submodule add <upstream-url> home/.oh-my-zsh/custom/plugins/<name>
# add <name> to the plugins=(...) line in home/.zshrc
git add .gitmodules home/.oh-my-zsh/custom/plugins home/.zshrc
git commit -m "feat(zsh): add <name> plugin"
```

## Updating plugins

```sh
make update-plugins
# review what bumped, then:
git add home/.oh-my-zsh/custom/plugins
git commit -m "chore: update oh-my-zsh plugin submodules"
git push
```

## Adding a new host

1. Add the host under the right group in `ansible/inventory.yml`.
2. Make sure the host is reachable over SSH and the user can `sudo`.
3. `make provision-linux LIMIT=<hostname>`.

## Why this layout

- **Mac is the source of truth.** You edit one `.zshrc`. Mac and Linux both
  read it; OS-specific bits (Homebrew, JAVA_HOME, gnubin) are gated with
  `[[ "$OSTYPE" == darwin* ]]`.
- **No Jinja templating for `.zshrc`.** Avoids drift between the file you
  edit on Mac and what gets deployed elsewhere.
- **Plugins are submodules.** Tracks upstream, easy updates, no vendored
  binaries in the repo. `git clone --recurse-submodules` (or
  `make update-plugins`) is the only thing you need to remember.
- **Ansible only runs on Linux.** Mac is bootstrapped by `bootstrap-mac.sh`.
