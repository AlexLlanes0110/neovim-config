# Plugin Reference

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Plugin specifications live in `lua/plugins/*.lua`; `lua/config/lazy.lua` imports the directory automatically. The checked-in `lazy-lock.json` locks plugin revisions.

## Interface and navigation

| Plugin | Purpose |
|---|---|
| catppuccin/nvim | Mocha color theme |
| nvim-lualine/lualine.nvim | Status line |
| nvim-tree/nvim-tree.lua | Toggleable sidebar file tree (Ctrl+b in Normal mode) |
| nvim-tree/nvim-web-devicons | Filetype icons; best with a Nerd Font |
| stevearc/oil.nvim | Editable file/directory explorer (`-`) |
| nvim-telescope/telescope.nvim | Fuzzy file, buffer, text and help search |
| nvim-lua/plenary.nvim | Utility dependency for Telescope |
| folke/which-key.nvim | Discover mappings (`Space ?`) |

Use nvim-tree to understand project structure and Oil when creating, renaming or reorganizing files. In Oil, save using `:w` to apply changes to disk. The configuration enables hidden files in both file-search and Oil views.

## Editing and Git

| Plugin | Purpose |
|---|---|
| numToStr/Comment.nvim | Comment/uncomment selections and lines |
| windwp/nvim-autopairs | Automatically insert matching pairs |
| kylechui/nvim-surround | Add/change/remove surrounding characters |
| lewis6991/gitsigns.nvim | Git diff indicators, hunk navigation/preview and blame |

## Language intelligence

| Plugin | Purpose |
|---|---|
| mason-org/mason.nvim | Install and manage development tools (`:Mason`) |
| mason-org/mason-lspconfig.nvim | Manage and enable language servers |
| neovim/nvim-lspconfig | LSP configurations and integration |
| hrsh7th/nvim-cmp | Completion engine |
| hrsh7th/cmp-nvim-lsp | LSP completion source |
| hrsh7th/cmp-buffer | Current-buffer completion |
| hrsh7th/cmp-path | Filesystem-path completion |
| hrsh7th/cmp-cmdline | Command-line completion |
| L3MON4D3/LuaSnip | Snippet engine |
| rafamadriz/friendly-snippets | Snippet collection |
| saadparwaiz1/cmp_luasnip | LuaSnip completion integration |
| onsails/lspkind.nvim | Completion item icons |
| folke/trouble.nvim | Diagnostic, symbols and LSP result panels |

### Language servers

Mason LSP installation list: `lua_ls`, `pyright`, `bashls`, `jsonls`, `yamlls`, `html`, `cssls`, `ts_ls`, `dockerls`, `docker_compose_language_service`, `marksman`, `taplo`, `sqls`.

These are **configured targets**, not proof that each binary is installed or can run on every machine. Check `:Mason`, `:LspInfo` and `:checkhealth vim.lsp`.

## Formatting and syntax

| Plugin | Purpose |
|---|---|
| stevearc/conform.nvim | Format-on-save and manual formatting (`Space fm`) |
| WhoIsSethDaniel/mason-tool-installer.nvim | Install formatter tools through Mason |
| nvim-treesitter/nvim-treesitter | Syntax highlighting and parser-based indentation (the configuration uses the `master` branch API) |

Configured formatters: StyLua for Lua; isort then Black for Python; Prettier for JavaScript, TypeScript, HTML, CSS, JSON, YAML and Markdown; shfmt for shell files; SQLFluff for SQL. Automatic formatting falls back to LSP when configured; SQL explicitly disables LSP fallback. Run `:ConformInfo` to inspect the formatter chosen for a particular buffer.

Configured Treesitter parsers include Bash, CSS, Dockerfile, Git metadata, HTML, JavaScript, JSON, Lua, Markdown, Python, SQL, TOML, TSX/TypeScript, Vim, XML and YAML.

## Essential commands

- `:Lazy` — inspect plugins.
- `:Lazy sync` — install/update and clean plugins; review changes before committing the lockfile.
- `:Mason` — inspect language tools.
- `:TSUpdate` — update Treesitter parsers.
- `:ConformInfo` — inspect formatter availability.
- `:checkhealth` — inspect environment dependencies.

Repository declarations are the source of truth. Platform-specific dependencies are covered in the installation guides.
