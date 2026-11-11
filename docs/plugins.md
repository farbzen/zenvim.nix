# Plugins

Each plugin is configured in its own module under `nixvim/plugins/`. Plugins
marked with an option can be switched off (see [Options](options.md)); all
others are always part of the configuration.

## Navigation and search

### snacks.nvim

Always enabled. Enabled snacks: `animate`, `bigfile`, `dim`, `indent`, `input`,
`lazygit`, `notifier`, `picker`, `quickfile`, `scope`, `scratch` (markdown
scratch buffers), `statuscolumn`, `terminal` and `words`.

The pickers cover files, grep, buffers, recent projects, undo history, LSP
definitions/references/symbols, diagnostics, location and quickfix lists, TODO
comments and notifications. See [Keymaps](keymaps.md#files-buffers-and-search).

### neo-tree

Always enabled. Opens as a floating window (`<C-o>`) with rounded borders, shows
hidden and ignored files, follows the current file and closes when it is the
last window. Inside the tree, `l` opens and `h` closes a node.

### bufferline

Option `zenvim.bufferline.enable`. Always visible, slope separators, LSP
diagnostic counts per buffer, close button on hover and an offset for the
neotest summary. Colors match rose-pine.

### mini.map

Option `zenvim.miniMap.enable`. Minimap with search, diagnostic and gitsigns
integrations, toggled with `<leader>mm`.

### persistence.nvim

Option `zenvim.persistence.enable`. Sessions are stored per directory and git
branch under `stdpath("state")/sessions/` and only saved when at least one file
buffer is open.

## Editing

| Plugin          | Purpose                                                                                        |
| --------------- | ---------------------------------------------------------------------------------------------- |
| blink.cmp       | Completion from LSP, path, snippets, buffer and ripgrep; Rust fuzzy matcher                    |
| blink-ripgrep   | Project-wide word completion (from 3 characters, up to 1 MB files, ignore case)                |
| treesitter      | All grammars, highlighting, indentation and folding (`foldlevel = 99`)                         |
| autoclose       | Auto-pairs, disabled when the cursor touches a character                                       |
| nvim-surround   | Add, change and delete surrounding pairs                                                       |
| nvim-cursorline | Highlights the cursor line number and underlines the word under the cursor (from 3 characters) |
| todo-comments   | Highlights `TODO`, `FIXME` & co. and lists them in a picker (`<leader>lt`)                     |
| vim-sleuth      | Detects indentation from the file                                                              |
| direnv          | Loads `.envrc` environments, so project tools are found                                        |
| which-key       | Shows available mappings after pressing `<leader>`                                             |

## Language tooling

These plugins are only enabled if at least one [language](languages.md) uses the
respective feature.

| Plugin                  | Enabled when any language uses | Notes                                                    |
| ----------------------- | ------------------------------ | -------------------------------------------------------- |
| lspconfig + inlay hints | `lsp`                          | `K` hover, `<C-k>` signature help, `<leader>lR` restart  |
| conform.nvim            | `format`                       | Formatting on demand with `<leader>lf` (async)           |
| nvim-lint               | `lint`                         | Runs on `BufReadPost`, `BufWritePost` and `InsertLeave`  |
| nvim-dap + nvim-dap-ui  | `dap`                          | UI at the bottom with console, watches and breakpoints   |
| neotest + nvim-coverage | `test`                         | Rounded floating windows, coverage reloads automatically |

## UI

### lualine and navic

Always enabled. The statusline shows mode, file type and name, git diff,
diagnostics, the attached LSP clients, search count, branch, position and file
format. The winbar shows the working directory, navic breadcrumbs (depth 3) and,
depending on the enabled features, macro recording state (noice), DAP status
(any language with `dap`) and typing speed (tacho).

### rose-pine

Always enabled, variant `main`. The background is transparent unless running in
Neovide.

### tiny-inline-diagnostic

Always enabled and replaces Neovim's virtual text: multi-line diagnostics with
source, count and icons, disabled in neo-tree.

### noice.nvim

Option `zenvim.noice.enable`. Presets: bottom search, command palette, LSP doc
borders, long messages in a split and inc-rename. `<leader>na` shows the message
history.

## Git

- **gitsigns** (always): signs in the status column, inline blame of the current
  line, hunk preview, stage and reset.
- **Lazygit** (always): opened through snacks with `<leader>gg`; `lazygit` is
  bundled.

## AI

### claudecode.nvim

Option `zenvim.ai.claudecode.enable`. Runs Claude Code in a floating snacks
terminal (90 % of the screen, rounded border). `<C-,>` opens or focuses it and,
inside the terminal, hides it again. The `claude` CLI is not bundled.

## Just for fun

| Plugin             | Option                            | What it does                                     |
| ------------------ | --------------------------------- | ------------------------------------------------ |
| tacho.nvim         | `zenvim.tacho.enable`             | Words per minute in the winbar                   |
| pentatonic.nvim    | `zenvim.pentatonic.enable`        | Plays pentatonic notes while typing (volume 5 %) |
| duck.nvim          | `zenvim.duck.enable`              | A duck that walks across the buffer              |
| cellular-automaton | `zenvim.cellularAutomaton.enable` | "Make it rain" and "Game of life" animations     |
