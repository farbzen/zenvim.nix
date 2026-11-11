# Editor defaults

General settings live in `nixvim/options.nix`, `nixvim/autocmds.nix`,
`nixvim/smartnumber.nix` and `nixvim/packages.nix`. They are part of every
profile.

## Options

| Setting                       | Value         | Effect                                                          |
| ----------------------------- | ------------- | --------------------------------------------------------------- |
| `mapleader`, `maplocalleader` | `Space`       | Leader for all custom mappings                                  |
| `clipboard`                   | `unnamedplus` | Yank and paste use the system clipboard                         |
| `tabstop`, `shiftwidth`       | `4`           | Default indentation (vim-sleuth adapts it per file)             |
| `expandtab`                   | on            | Spaces instead of tabs                                          |
| `wrap`                        | off           | No soft wrapping                                                |
| `number`                      | on            | Line numbers, see [smart numbers](#smart-relative-line-numbers) |
| `cursorlineopt`               | `number`      | Only the line number of the cursor line is highlighted          |
| `ignorecase`, `smartcase`     | on            | Case-insensitive search unless it contains capitals             |
| `hlsearch`                    | on            | Highlight search matches                                        |
| `inccommand`                  | `split`       | Live preview of `:s` in a split                                 |
| `undofile`                    | on            | Persistent undo history                                         |
| `breakindent`                 | on            | Wrapped lines keep their indentation                            |
| `exrc`                        | on            | Loads trusted project-local `.nvim.lua`                         |
| `mousemoveevent`              | on            | Hover effects (e.g. bufferline close button)                    |
| `termguicolors`               | on            | 24-bit colors                                                   |

netrw is disabled in favour of neo-tree. Diagnostic signs use Nerd Font icons;
inline diagnostic text comes from tiny-inline-diagnostic.

## Autocommands and commands

- `formatoptions` loses `c`, `r` and `o` for every file type, so comments are
  not continued automatically.
- Empty, unnamed buffers are closed as soon as a real file is opened.
- Yanked text is briefly highlighted.
- `:W` and `:Q` behave like `:w` and `:q` (with `!` support).

## Smart relative line numbers

Relative line numbers are shown in the focused window in normal mode. They
switch to absolute numbers in insert mode, on the command line, in unfocused
windows and when Neovim loses focus. Pickers, terminals and neo-tree are
excluded.

## Neovide

When running in [Neovide](https://neovide.dev), zenvim sets:

- the font `JetBrainsMono Nerd Font` (13 pt) with `Noto Color Emoji` as fallback
  and a line spacing of 5,
- 16 px padding, rounded floating windows and slight transparency,
- the `pixiedust` cursor effect and short scroll animations,
- `<C-=>` and `<C-->` to zoom in and out.

The colorscheme is opaque in Neovide and transparent everywhere else.

## Bundled tools

`fd`, `gcc`, `lazygit`, `noto-fonts-color-emoji`, `ripgrep` and `tree-sitter`
are added to the end of `PATH` (`extraPackagesAfter`). Like all bundled language
tools, they only serve as fallback: if a project's devshell provides a different
version, that version is used.
