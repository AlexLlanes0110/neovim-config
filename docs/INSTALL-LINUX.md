# Install on Linux (Ubuntu)

ITPro server reference: Ubuntu, x86_64, user `wolfadmin`. Neovim **0.12.6** was installed per-user; the system's `/usr/bin/nvim` remains installed independently. Root does not automatically share this user's plugins or settings.

## Prerequisites

~~~bash
sudo apt update
sudo apt install -y git curl tar gzip ripgrep fd-find nodejs npm python3 python3-venv python3-pip build-essential
~~~

Ubuntu's `fd` may be named `fdfind`; optionally create a personal symlink or configure Telescope accordingly. Language tooling may require newer runtimes than the distribution defaults.

## Install Neovim per-user (x86_64)

~~~bash
mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
curl -fL https://github.com/neovim/neovim/releases/download/v0.12.6/nvim-linux-x86_64.tar.gz -o /tmp/nvim-linux-x86_64.tar.gz
tar -xzf /tmp/nvim-linux-x86_64.tar.gz -C "$HOME/.local/opt"
ln -sfn "$HOME/.local/opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim"
export PATH="$HOME/.local/bin:$PATH"
hash -r
nvim --version | head -n 2
~~~

For Bash, persist the PATH preference:

~~~bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
~~~

The download above is specific to Linux x86_64. Use the matching official artifact for ARM64 and validate release checksums when deploying.

## Install configuration

If the current machine already has a working Neovim configuration, back it up rather than deleting it:

~~~bash
mkdir -p "$HOME/.config"
if [ -d "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi
git clone https://github.com/AlexLlanes0110/neovim-config.git "$HOME/.config/nvim"
nvim --headless '+Lazy! sync' '+qa!'
nvim
~~~

This repository is **private**: authenticate Git access first (`gh auth login` and `gh auth setup-git`, or another valid credential method).

**Already migrated ITPro server:** Do not clone over its active `~/.config/nvim`. It already contains the modular configuration. First inspect `git status` there and connect it to the repository using the workflow in [Maintenance](MAINTENANCE.md).

## Check the setup

Run `:Mason`, `:ConformInfo`, `:checkhealth` and `:LspInfo`. Individual LSP/formatter installations are platform-specific; being listed in Lua does not imply installation succeeded. Over SSH, system clipboard integration may require an OSC52-capable terminal or a configured provider.

## Root and sudo

`wolfadmin` uses the per-user Neovim binary and configuration. Root has its own HOME/PATH/configuration. Prefer `sudoedit` or careful elevated edits over running your personal plugin setup as root. Do not delete the Ubuntu-managed `/usr/bin/nvim` manually.
