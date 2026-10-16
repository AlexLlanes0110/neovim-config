
# Neovim Configuration

A modular, cross-platform Neovim configuration designed for development, infrastructure management, and system administration.

## Overview

This repository maintains a consistent Neovim environment across multiple operating systems.

The goal is to provide a portable, maintainable, and documented configuration that can be deployed on new machines with minimal setup.

## Supported Platforms

| Platform              | Status     |
| --------------------- | ---------- |
| macOS (Apple Silicon) | Configured |
| Linux (Ubuntu Server) | Configured |
| Windows (Lenovo)      | Planned    |

## Features

- Neovim 0.12.6
- Modular Lua configuration
- lazy.nvim plugin management
- Catppuccin theme
- nvim-tree file explorer
- Oil.nvim file management
- Telescope fuzzy finder
- LSP integration
- Autocompletion and snippets
- Treesitter syntax highlighting
- Conform formatting
- Git integration

## Project Structure

```text
.
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── config/
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins/
│       ├── completion.lua
│       ├── diagnostics.lua
│       ├── editing.lua
│       ├── filetree.lua
│       ├── formatting.lua
│       ├── lsp.lua
│       ├── navigation.lua
│       ├── treesitter.lua
│       └── ui.lua
└── docs/
```

## Keybindings

| Shortcut | Action |
|----------|--------|
| Ctrl+B | Toggle file explorer |
| Ctrl+P | Find files |
| - | Open Oil.nvim |
| gg | Go to beginning of file |
| G | Go to end of file |
| Ctrl+D | Scroll down half a page |
| Ctrl+U | Scroll up half a page |

## Installation

Platform-specific installation instructions will be provided in the `docs/` directory.

## Roadmap

- [x] Configure macOS
- [x] Configure Ubuntu Server
- [x] Modularize Neovim configuration
- [ ] Document plugins and keybindings
- [ ] Create installation scripts
- [ ] Configure Windows
- [ ] Establish a cross-platform update workflow

## License

No license has been selected yet.
