# Neovim Keybind Cheat Sheet

`<leader>` is mapped to `Space`.

This is the short version. The full reference still lives in [`README.md`](./README.md#neovim-keybinds).

## Daily Use

| Keybind | Action |
|---------|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between splits |
| `<C-s>` | Save file |
| `<C-x>` | Save and quit |
| `<C-q>` | Quit all |
| `<Esc>` | Clear search highlight |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep project |
| `<leader><leader>` | Find existing buffers |
| `<leader>/` | Fuzzy search current buffer |
| `<C-n>` | Toggle NvimTree |
| `-` | Open parent directory with Oil |
| `<leader>-` | Open Yazi at current file |
| `<A-,>` / `<A-.>` | Previous / next buffer |
| `<A-c>` | Close buffer |
| `<C-p>` | Pick buffer |

## Files And Buffers

| Keybind | Action |
|---------|--------|
| `<leader>E` | Focus NvimTree |
| `<leader>cw` | Open Yazi in current working directory |
| `<C-y>` | Resume last Yazi session |
| `<A-<>` / `<A->>` | Move buffer left / right |
| `<A-1>` ... `<A-9>` | Go to buffer 1 through 9 |
| `<A-0>` | Go to last buffer |
| `<A-p>` | Pin or unpin buffer |
| `<Space>bb` | Sort buffers by buffer number |
| `<Space>bd` | Sort buffers by directory |
| `<Space>bl` | Sort buffers by language |
| `<Space>bw` | Sort buffers by window number |

## Search

| Keybind | Action |
|---------|--------|
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Search Telescope pickers |
| `<leader>sw` | Search current word |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last Telescope picker |
| `<leader>s.` | Search recent files |
| `<leader>s/` | Live grep open files |
| `<leader>sn` | Search Neovim config files |

Inside Telescope pickers:

| Mode | Keybind | Action |
|------|---------|--------|
| Insert | `<C-/>` | Show picker-local help |
| Normal | `?` | Show picker-local help |

## LSP

These are available after an LSP attaches to the current buffer.

| Keybind | Action |
|---------|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Show hover documentation |
| `<leader>D` | Show type definitions |
| `<leader>ds` | Search document symbols |
| `<leader>ws` | Search workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Open diagnostic quickfix list |

## Git And Utility

| Keybind | Action |
|---------|--------|
| `<leader>l` | Open `:Lazy` |
| `<leader>gB` | Open Git browse |
| `<leader>gb` | Show Git blame for current line |
| `<leader>gf` | Open LazyGit file history |
| `<leader>gg` | Open LazyGit |
| `<leader>gl` | Open LazyGit log for cwd |
| `<leader>un` | Dismiss all notifications |
| `<A-t>` | Toggle floating terminal |
| `]]` / `[[` | Next / previous reference |
| `<leader>dd` | Enable dim mode |
| `<leader>do` | Disable dim mode |

## Notes And Debugging

| Keybind | Action |
|---------|--------|
| `<leader>of` | Search Obsidian files |
| `<leader>os` | Quick switch Obsidian note |
| `<leader>on` | Create new Obsidian note |
| `<leader>ol` | Follow Obsidian link |
| `<leader>ob` | Show Obsidian backlinks |
| `<leader>ot` | Browse Obsidian tags |
| `<leader>p` | Paste image from system clipboard |
| `<leader>bt` | Toggle breakpoint |
| `<leader>bc` | Continue debugger |
| `<leader>bx` | Terminate debugger |
| `<leader>bo` | Step over |

## Rare Or Contextual

| Mode | Keybind | Action |
|------|---------|--------|
| Normal | `<A-h>` | Indent current line left |
| Normal | `<A-j>` | Move current line down |
| Normal | `<A-k>` | Move current line up |
| Normal | `<A-l>` | Indent current line right |
| Visual | `<A-h>` | Indent selected lines left |
| Visual | `<A-j>` | Move selected lines down |
| Visual | `<A-k>` | Move selected lines up |
| Visual | `<A-l>` | Indent selected lines right |
| Insert | `<A-h>` | Indent current line left and return to insert mode |
| Insert | `<A-j>` | Move current line down and return to insert mode |
| Insert | `<A-k>` | Move current line up and return to insert mode |
| Insert | `<A-l>` | Indent current line right and return to insert mode |
| Insert | `<C-j>` | Accept Copilot suggestion |
| Visual | `<leader>fc` | Create a code image with Freeze |
