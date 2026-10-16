# Maintenance and Sync Workflow

This repository is the **single source of truth** for the shared Neovim configuration. The MacBook, ITPro Linux server, and Lenovo Windows workstation run the modular configuration. The repository is public for read/clone access; pushing changes still requires GitHub authentication.

## Daily workflow

Edit configuration on **one machine at a time** (preferably MacBook), then inspect and push:

~~~bash
cd "$HOME/.config/nvim"
git status
git diff --check
git diff
git add init.lua lazy-lock.json lua/ docs/ README.md .gitignore
git commit -m "chore: update Neovim configuration"
git push origin main
~~~

Only commit when something actually changed; `git commit` exits harmlessly if nothing is staged. If other files were added, inspect and explicitly stage them.

On another Unix machine that **already has this folder as a Git repository**:

~~~bash
cd "$HOME/.config/nvim"
git status
git pull --ff-only
nvim --headless '+Lazy! sync' '+qa!'
~~~

If `git status` reports local changes, resolve/commit/stash them before pulling; do **not** run `git reset --hard` blindly.

## Connecting the existing ITPro installation

The server received a copy of the configuration via rsync and may **not** have a `.git` directory. First take a backup and inspect the directory. To attach the existing tree safely without deleting working files:

~~~bash
cd "$HOME/.config/nvim"
cp -a "$HOME/.config/nvim" "$HOME/.config/nvim.pre-git.$(date +%Y%m%d-%H%M%S)"
git init -b main
git remote add origin https://github.com/AlexLlanes0110/neovim-config.git
git fetch origin main
git status
git diff --no-index /dev/null init.lua || true
~~~

**Stop here and compare local files with `origin/main` before changing branches, overwriting files or attempting to pull.** Differences could represent Linux-specific adjustments. The simplest alternative after backup is cloning the repo into a separate directory, reviewing differences, and swapping directories only after validation. Never use `git reset --hard` on the active configuration.

## Plugins and tools

- `:Lazy`: inspect plugins.
- `:Lazy sync`: update/install plugins; the resulting `lazy-lock.json` may change.
- `:Mason`: check language servers and formatting binaries.
- `:ConformInfo`: see the active formatter for a file.
- `:TSUpdate`: update Tree-sitter parsers.
- `:checkhealth`: inspect dependencies and providers.

Commit `lazy-lock.json` when intentionally updating plugins. Keep tool installations out of Git: the repo tracks declarations, not downloaded binaries or Mason caches.

## Recovery and diagnostics

Before disruptive changes:

~~~bash
cp -a "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
nvim --version
~~~

To identify configuration startup errors:

~~~bash
nvim --headless '+qa!' 2>&1
~~~

Inspect `:messages`, `:Lazy`, `:checkhealth`, `:Mason`, and `:ConformInfo` as appropriate. A printed success message alone does not prove there were no startup errors.

## Security and contribution conventions

- The repository is public: review both working-tree files and commit history before publishing secrets.
- Never commit tokens, passwords, SSH keys, `.env` files, or machine-specific secrets.
- Review `git diff --cached` before each push; `.gitignore` does not protect secrets already tracked.
- Avoid force-pushes on shared branches.
- Write README, docs and commit messages in English.
- Mappings in the existing Lua code may still have Spanish descriptions; updating those labels is optional and separate from translating documentation.
