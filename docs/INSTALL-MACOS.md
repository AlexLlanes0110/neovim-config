# Install on macOS

Tested development environment: Apple Silicon MacBook, Neovim **0.12.6** via Homebrew. The repository contains **configuration**, not a bundled Neovim executable.

## Prerequisites

Install [Homebrew](https://brew.sh/) first. Then in Terminal:

~~~bash
brew install neovim git ripgrep fd node python fzf
nvim --version
~~~

Recommended: a Nerd Font in your terminal to render plugin icons. Some LSPs and formatters require `npm`, Python, or other language runtimes. The LuaSnip build may need `make` and a C compiler (Xcode Command Line Tools).

## Back up an existing configuration

~~~bash
mkdir -p "$HOME/.config"
if [ -d "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
fi
~~~

## Install the shared configuration

~~~bash
git clone https://github.com/AlexLlanes0110/neovim-config.git "$HOME/.config/nvim"
nvim --headless '+Lazy! sync' '+qa!'
nvim
~~~

**Private repository:** Authenticate first using `gh auth login` and `gh auth setup-git`, or configure Git credentials. The GitHub URL is not publicly cloneable without permission.

## Validate

Inside Neovim:

- `Ctrl+b`: nvim-tree sidebar in Normal mode.
- `Ctrl+p`: find files.
- `-`: Oil file manager.
- `:Mason`: tool installation status.
- `:ConformInfo`: formatting tools.
- `:checkhealth`: dependency diagnostics.

## Synchronize changes

~~~bash
cd "$HOME/.config/nvim"
git pull --ff-only
nvim --headless '+Lazy! sync' '+qa!'
~~~

After editing configuration files, review `git diff`, commit and push from one machine, then pull on the other machines. See [Maintenance](MAINTENANCE.md).
