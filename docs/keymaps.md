# Keymaps

`<leader>` and `<localleader>` are both set to `Space`. All mappings are in
normal mode unless stated otherwise. Mappings of optional features only exist
when the feature is enabled, see [Options](options.md). Press `<leader>` and
wait to see the which-key popup.

## Files, buffers and search

| Key             | Action                                  |
| --------------- | --------------------------------------- |
| `<C-o>`         | Open file explorer (neo-tree, floating) |
| `<C-M-o>`       | List recent projects                    |
| `<leader>ff`    | Find file                               |
| `<leader>fg`    | Find content in files                   |
| `<leader>fw`    | Find current word or selection (n, x)   |
| `<leader>bo`    | Show open buffers                       |
| `<leader>bw`    | Close current buffer                    |
| `<leader>bc`    | Close all except the current buffer     |
| `<M-h>`         | Jump to previous buffer                 |
| `<M-l>`         | Jump to next buffer                     |
| `<M-1>`…`<M-9>` | Jump to buffer 1–9 in bufferline        |
| `<M-$>`         | Jump to last buffer in bufferline       |
| `<leader>s`     | Open scratchpad                         |
| `<leader>S`     | Select scratchpad                       |
| `<leader>mm`    | Toggle minimap                          |

## LSP, diagnostics and formatting

| Key          | Action                              |
| ------------ | ----------------------------------- |
| `K`          | Hover (when an LSP is attached)     |
| `<C-k>`      | Signature documentation (LSP)       |
| `gd`         | Go to definition                    |
| `<leader>lr` | Show LSP references                 |
| `<leader>ls` | Show LSP symbols                    |
| `<leader>lR` | Restart LSP                         |
| `<leader>th` | Toggle LSP inlay hints              |
| `<leader>lf` | Format current file                 |
| `<leader>ld` | Show diagnostics for current buffer |
| `<leader>lD` | Show diagnostics                    |
| `<leader>ll` | Show location list                  |
| `<leader>lq` | Show quickfix list                  |
| `<leader>lt` | Show TODO comments                  |
| `<leader>lu` | Show undo history                   |

## Git

| Key           | Action                           |
| ------------- | -------------------------------- |
| `<leader>gg`  | Open Lazygit                     |
| `<leader>gb`  | Toggle git blame on current line |
| `<leader>ghp` | Preview git hunk                 |
| `<leader>ghP` | Preview git hunk inline          |
| `<leader>ghs` | Stage git hunk                   |
| `<leader>ghr` | Reset git hunk                   |

## Tests and debugging

| Key           | Action                     |
| ------------- | -------------------------- |
| `<leader>tr`  | Run current test(s)        |
| `<leader>td`  | Debug current test(s)      |
| `<leader>ta`  | Attach to current test(s)  |
| `<leader>to`  | Toggle test output panel   |
| `<leader>ts`  | Toggle test summary        |
| `<leader>tcs` | Show test coverage         |
| `<leader>tcc` | Clear test coverage        |
| `<leader>tcS` | Show test coverage summary |
| `<F4>`        | DAP: Close                 |
| `<F5>`        | DAP: Start/Continue        |
| `<F6>`        | DAP: Restart               |
| `<F10>`       | DAP: Step over             |
| `<F11>`       | DAP: Step into             |
| `<F12>`       | DAP: Step out              |
| `<leader>db`  | DAP: Toggle breakpoint     |
| `<leader>dr`  | DAP: Open REPL             |
| `<leader>du`  | DAP: Open UI               |

## Tools and UI

| Key          | Action                                              |
| ------------ | --------------------------------------------------- |
| `<C-,>`      | Toggle Claude Code (also hides it in terminal mode) |
| `<leader>tt` | Toggle terminal                                     |
| `<leader>ds` | Dim code around the current block                   |
| `<leader>mp` | Open markdown preview                               |
| `<leader>mt` | Toggle markdown rendering                           |
| `<leader>nh` | Show notification history                           |
| `<leader>na` | Show Noice message history                          |
| `<leader>ql` | Load the last session                               |
| `<leader>qL` | Select a session to load                            |
| `<leader>qd` | Disable persistence (no save on exit)               |
| `<C-=>`      | Zoom in (Neovide only)                              |
| `<C-->`      | Zoom out (Neovide only)                             |

## Just for fun

| Key           | Action         |
| ------------- | -------------- |
| `<leader>fml` | Make it rain   |
| `<leader>gol` | Game of life   |
| `<leader>dh`  | Hatch a duck   |
| `<leader>dc`  | Cook a duck    |
| `<leader>dC`  | Cook all ducks |

## Completion (blink.cmp)

| Key       | Action                    |
| --------- | ------------------------- |
| `<CR>`    | Select and accept         |
| `<Tab>`   | Select next item          |
| `<S-Tab>` | Select previous item      |
| `<C-e>`   | Hide menu                 |
| `<C-d>`   | Scroll documentation down |
| `<C-u>`   | Scroll documentation up   |

## Commands

- `:W` and `:Q` behave like `:w` and `:q`.
