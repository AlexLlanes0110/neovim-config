# Install on Windows (validated on Lenovo)

Tested on the Lenovo workstation in October 2026: Windows 11 Pro (64-bit), PowerShell 7.6.7, Neovim 0.12.6, Node.js 24, Python 3.13, ripgrep 15, and Zig 0.17. The same modular Lua configuration is used on macOS and Linux.

The repository is public and can be cloned without GitHub authentication. Authentication is still required to **push** changes.

## 1. Install prerequisites

Use PowerShell and Windows Package Manager (winget). Install only missing tools:

~~~powershell
winget install --id Git.Git -e
winget install --id OpenJS.NodeJS.LTS -e
winget install --id Python.Python.3.13 -e
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id zig.zig -e
~~~

For Neovim use the official Windows release or winget, then verify the installed version. The tested version is **0.12.6**. A per-user ZIP installation can live under `$env:LOCALAPPDATA\Programs\Neovim`; add its `nvim-win64\bin` directory to the user's PATH. If you install from a downloaded archive, verify the checksum against the official GitHub release before extraction.

After winget changes PATH, restart PowerShell. Verify:

~~~powershell
nvim --version
git --version
node --version
npm --version
rg --version
zig version
py --version
~~~

**Python note:** `py --version` can work even if `python` points to the Windows Store alias. The Lenovo used Python 3.13 via the `py` launcher. Do not reinstall Python just to fix this alias.

## 2. Clone the configuration

Run from PowerShell **outside Neovim**:

~~~powershell
$dest = Join-Path $env:LOCALAPPDATA 'nvim'
if (Test-Path $dest) {
  throw "Configuration already exists at $dest. Inspect 'git -C $dest status' first; do not clone over it."
}
git clone https://github.com/AlexLlanes0110/neovim-config.git $dest
Set-Location $dest
nvim --headless "+Lazy! sync" "+qa!"
~~~

If Neovim is open, Windows may lock `$dest`, preventing a move or backup. Close it before changing configuration directories. Existing clones should use `git pull --ff-only` rather than cloning again.

## 3. Install Treesitter parsers with Zig

This configuration uses the `master` API of `nvim-treesitter`. It requires a C-compatible compiler to build additional parsers. The Lenovo had no GCC/Clang installed; **Zig 0.17** worked.

Open Neovim interactively:

~~~powershell
nvim
~~~

Run inside Neovim:

~~~vim
:Lazy load nvim-treesitter
:TSUpdate
~~~

**Keep Neovim open** while the asynchronous download/compile stage runs. The first 27-parser installation can stay at `[0/27] compiling...` for a while before advancing. Do not conclude it failed based on that counter alone. Exiting immediately with `+qa!` may interrupt installation.

Once complete, quit and verify:

~~~powershell
nvim --headless "+lua for _,p in ipairs(require('nvim-treesitter.info').installed_parsers()) do print(p) end" "+qa!" 2>&1
~~~

The Lenovo confirmed installed parsers including `bash`, `dockerfile`, `html`, `javascript`, `json`, `lua`, `python`, `sql`, `typescript`, and `yaml`.

## 4. Install formatters directly (without Mason)

Mason installed the LSP servers but did not install the requested formatters on this Windows setup. **Direct CLI installation succeeded**; Conform can discover executables from PATH.

~~~powershell
npm install -g @johnnymorganz/stylua-bin@2.6.0
npm install -g prettier
py -m pip install --user --upgrade black isort sqlfluff
winget install --id mvdan.shfmt -e
~~~

The Python `--user` scripts on this workstation were installed in:

`$env:APPDATA\Python\Python313\Scripts`

Add the actual directory for the Python launcher in use to the user's PATH (this example is for Python 3.13):

~~~powershell
$scriptsDir = Join-Path ((py -m site --user-base).Trim()) 'Python313\Scripts'
if (-not (Test-Path $scriptsDir)) { throw "Python scripts directory not found: $scriptsDir" }
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($userPath -split ';') -notcontains $scriptsDir) {
  [Environment]::SetEnvironmentVariable('Path', "$userPath;$scriptsDir", 'User')
}
$env:Path = "$scriptsDir;$env:Path"
~~~

Restart PowerShell to verify the PATH change persists. Use the actual Python minor version on other computers. The npm and winget executable directories must also be on PATH.

Check all six tools from Neovim:

~~~powershell
nvim --headless "+lua for _,tool in ipairs({'stylua','prettier','black','isort','shfmt','sqlfluff'}) do print(tool .. '=' .. tostring(vim.fn.executable(tool))) end" "+qa!" 2>&1
~~~

**All six returned `=1` on the Lenovo.** Mason's installed-package list does not include independently installed formatters; this is expected.

## 5. Verify formatting with Conform

Use a throwaway file (not a repository file):

~~~powershell
$testFile = Join-Path $env:TEMP 'neovim-format-test.lua'
Set-Content -Path $testFile -Value 'local x={a=1,b=2};print(x.a)'
nvim --headless $testFile "+lua require('conform').format({async=false,timeout_ms=5000})" "+write" "+qa!"
Get-Content $testFile
~~~

This formatting test **passed on the Lenovo**. It confirms that Conform can run StyLua, not that every configured formatter has been individually tested.

## 6. Validate features and LSP

The Lenovo had all 29 Lazy plugin specifications installed, 12 LSP packages initially installed through Mason, and the Treesitter parsers listed above. After resolving the SQLS build issue described below, Mason also reported `sqls` installed. Run:

- `Ctrl+b` in Normal mode: toggle nvim-tree.
- `Ctrl+p`: find files.
- `-`: open Oil.
- `:Lazy`: inspect plugins.
- `:Mason`: inspect installed language servers.
- `:ConformInfo`: verify per-file formatter.
- `:checkhealth`: optional provider/dependency diagnostics.

Optional warnings (Perl/Ruby/Go/Java providers, LuaRocks, `jsregexp` for LuaSnip) do not automatically mean core configuration is broken. Confirm requirements before installing additional runtimes.

## 7. SQLS language server: resolved Windows installation issue

On the Lenovo, `mason-lspconfig.nvim` lists `sqls` in `ensure_installed`. Mason repeatedly attempted installation because the `sqls` package had not been installed successfully. The rest of Neovim continued to work.

### Problem 1: Go was missing

The Mason log contained:

~~~text
Installation failed for Package(name=sqls)
Could not find executable "go" in PATH.
~~~

Install Go and restart PowerShell so the new PATH is visible:

~~~powershell
winget install --id GoLang.Go -e --accept-package-agreements --accept-source-agreements
go version
~~~

The Lenovo validated `go version go1.27.0 windows/amd64`.

### Problem 2: SQLS could not compile its Oracle driver dependency

Running `go install github.com/sqls-server/sqls@latest` initially failed while compiling `github.com/godror/godror`, with errors such as `undefined: VersionInfo`, `undefined: StartupMode`, and `undefined: ShutdownMode`. The required C compilation toolchain was not available in the initial Windows environment.

Install the MinGW-w64 GCC toolchain, restart PowerShell, and verify the compiler and CGO configuration:

~~~powershell
winget install --id BrechtSanders.WinLibs.POSIX.UCRT -e --accept-package-agreements --accept-source-agreements
gcc --version
go env CGO_ENABLED
~~~

The Lenovo validated GCC **16.2.0** (MinGW-w64 UCRT/POSIX). With GCC available, the Go build succeeded:

~~~powershell
go install github.com/sqls-server/sqls@latest
Get-Command sqls -ErrorAction SilentlyContinue | Select-Object Source
~~~

The resulting executable was in the user Go binary directory, `%USERPROFILE%\go\bin\sqls.exe`. For other machines, use `go env GOPATH` to locate the correct `bin` directory and ensure it is on PATH.

### Problem 3: Mason still showed SQLS as not installed

An independently built `sqls.exe` does **not** count as a Mason-managed installation. The check still returned `SQLS_INSTALLED=false` even though PowerShell found the executable.

**Validated solution:** open Neovim interactively, then run `:MasonInstall sqls` and **wait until installation finishes** before closing Neovim.

~~~powershell
nvim
~~~

Inside Neovim:

~~~vim
:MasonInstall sqls
~~~

After the installation completes and Neovim closes, verify:

~~~powershell
nvim --headless "+lua local p=require('mason-registry').get_package('sqls'); print('SQLS_INSTALLED='..tostring(p:is_installed()))" "+qa!" 2>&1
~~~

**Verified Lenovo result:** `SQLS_INSTALLED=true`. Neovim also completed a headless startup check without visible errors.

Do **not** run an asynchronous Mason install followed immediately by `+qa!`; that exits before the package finishes and aborts installation. The attempted Lua call `p:install():wait(300000)` also failed (`attempt to call method 'wait' (a nil value)`) and must not be copied as a working command.

No Lua configuration changes were needed: the shared `sqls` declaration remains enabled for macOS, Linux, and Windows.

## 8. Update this machine

~~~powershell
Set-Location (Join-Path $env:LOCALAPPDATA 'nvim')
git status -sb
git pull --ff-only
nvim --headless "+Lazy! sync" "+qa!"
~~~

If the lockfile has local changes after a plugin operation, review `git diff -- lazy-lock.json` before deciding whether to restore or commit it. Avoid force pushes and deleting live Neovim configuration directories.

See [Keybindings](KEYMAPS.md), [Plugins](PLUGINS.md) and [Maintenance](MAINTENANCE.md).
