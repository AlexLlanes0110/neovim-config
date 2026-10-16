# Keybindings

All mappings below are taken from the repository's Lua configuration. The leader key is **Space**. Unless specified otherwise, mappings work in Normal mode.

## Files and windows

| Keys | Action | Source |
|---|---|---|
| Ctrl+S | Save file (Normal or Insert mode) | config/keymaps.lua |
| Space w | Save file | config/keymaps.lua |
| Space q | Quit current window | config/keymaps.lua |
| Ctrl+h / Ctrl+j / Ctrl+k / Ctrl+l | Focus left / lower / upper / right window | config/keymaps.lua |
| Ctrl+b | Toggle the left-hand nvim-tree file explorer | plugins/filetree.lua |
| Ctrl+p | Find files, including hidden files | config/keymaps.lua |
| - | Open Oil file manager | plugins/navigation.lua |
| Space cp | Copy current file's absolute path to system clipboard | config/keymaps.lua |
| Esc | Clear search highlights | config/keymaps.lua |

Note: Ctrl+b is reused **in Insert mode** to scroll completion documentation upward; it does not toggle the tree there. The clipboard mapping requires a working clipboard provider over SSH.

## Telescope search

| Keys | Action |
|---|---|
| Space ff | Find files (including hidden files) |
| Space fg | Search text across files (requires ripgrep) |
| Space fb | List open buffers |
| Space fh | Search help tags |
| Space fr | Open recently used files |

## Language server (only when an LSP attaches)

| Keys | Action |
|---|---|
| gd | Go to definition |
| gD | Go to declaration |
| gr | Show references |
| gi | Go to implementation |
| K | Hover documentation |
| Space rn | Rename symbol |
| Space ca | Code action |
| Space ld | Show diagnostics for current location |
| [d / ]d | Jump to previous / next diagnostic |

## Diagnostics, formatting and Git

| Keys | Action |
|---|---|
| Space xx | Toggle project diagnostics (Trouble) |
| Space xb | Toggle diagnostics for current buffer |
| Space cs | Toggle symbols view |
| Space cl | Toggle LSP relations view |
| Space fm | Format current buffer with Conform |
| ]c / [c | Next / previous Git change |
| Space gp | Preview Git change |
| Space gb | Show Git blame for current line |
| Space ? | Show available buffer mappings with which-key |

## Completion (Insert mode)

| Keys | Action |
|---|---|
| Ctrl+Space | Open completion suggestions |
| Tab / Shift+Tab | Next / previous suggestion, or jump through snippets |
| Enter | Confirm selected suggestion |
| Ctrl+e | Abort completion |
| Ctrl+b / Ctrl+f | Scroll completion documentation up / down |

## Built-in Vim movement

`h`, `j`, `k`, `l` move left/down/up/right; `10j` moves down ten lines. `gg` jumps to the first line, `G` to the last, `0` to line start, `$` to line end. `w` and `b` jump between words; `Ctrl+d` and `Ctrl+u` scroll half a screen.

## Oil.nvim quick tutorial

1. Open a project with `nvim .`, press `Esc` and then `-`.
2. Use `j`/`k` to move and `Enter` to open an entry.
3. Create a file: press `o`, type `notes.txt`, press `Esc`, then `:w`.
4. Create a directory: `o`, type `backups/`, press `Esc`, then `:w`.
5. Rename: position the cursor in a filename, edit the name like text, then `:w`.
6. Deleting an entry's line with `dd` and subsequently saving **deletes/moves that filesystem entry**; review Oil's confirmation before proceeding.
7. `-` navigates to the parent directory in the default Oil mapping. If needed, select `../` and press `Enter`.

Oil has `delete_to_trash = true`; actual trash support depends on the system. Use `:help oil.nvim` for additional default mappings.

## Verify mappings live

Run `:map`, `:nmap <C-b>`, `:verbose nmap <leader>ff`, or press `Space ?` inside Neovim. Some terminal emulators intercept Ctrl-based shortcuts.
