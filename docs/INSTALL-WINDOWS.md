# Install on Windows (planned)

This guide describes the **intended** Lenovo Windows setup. It has not yet been validated on that machine. The Lua configuration is shared, but terminal, compiler, clipboard and language-tool dependencies differ.

## Install prerequisites

Open PowerShell. With Windows Package Manager available:

~~~powershell
winget install --id Neovim.Neovim -e
winget install --id Git.Git -e
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id OpenJS.NodeJS.LTS -e
winget install --id Python.Python.3 -e
~~~

Optionally install `fd` and a Nerd Font. Restart PowerShell so executable PATH entries refresh.

Verify:

~~~powershell
nvim --version
git --version
rg --version
node --version
python --version
~~~

Target the tested Neovim version (0.12.6) where available; inspect `nvim --version` before proceeding. Some plugin or LSP versions may require additional compilers or runtimes.

## Clone the configuration

Neovim's Windows configuration directory is normally `$env:LOCALAPPDATA\nvim`.

~~~powershell
$dest = Join-Path $env:LOCALAPPDATA 'nvim'
if (Test-Path $dest) {
  $backup = "$dest.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
  Move-Item $dest $backup
}
git clone https://github.com/AlexLlanes0110/neovim-config.git $dest
nvim --headless "+Lazy! sync" "+qa!"
nvim
~~~

Since this is a **private repository**, set up GitHub authentication first. Using GitHub CLI: `gh auth login` then `gh auth setup-git`.

## Validate before standardizing

- `Ctrl+b` toggles the file tree in Normal mode.
- `Ctrl+p` finds files; `Space fg` searches text if ripgrep is on PATH.
- `-` opens Oil.
- `:Lazy` shows plugin installation status.
- `:Mason`, `:ConformInfo`, `:LspInfo` and `:checkhealth` identify platform-specific problems.

The `LuaSnip` optional `make install_jsregexp` step can require additional Windows build tools. Troubleshoot actual errors before changing the shared configuration for all platforms.

## Updating

~~~powershell
Set-Location (Join-Path $env:LOCALAPPDATA 'nvim')
git pull --ff-only
nvim --headless "+Lazy! sync" "+qa!"
~~~

Do not consider Windows support complete until the Lenovo has been tested interactively.
