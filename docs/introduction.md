# Introduction

zenvim is a personal Neovim setup for polyglot development (Python, Go, Rust,
TypeScript/Svelte, Lua, Nix, shell and more). The whole configuration is
declared as [Nixvim](https://github.com/nix-community/nixvim) modules – there is
no hand-written `init.lua`. Every plugin, language server, formatter and linter
is pinned by Nix, so the same editor runs on any machine with a single
`nix run`.

```sh
nix run github:farbzen/zenvim.nix
```

## What the flake provides

| Output                                | Purpose                                                                    |
| ------------------------------------- | -------------------------------------------------------------------------- |
| `packages.<system>.full` / `.default` | Neovim with every feature enabled                                          |
| `packages.<system>.minimal`           | Neovim with core editing only                                              |
| `packages.<system>.docs`              | This book as a static website                                              |
| `nixvimModules.full` / `.default`     | The complete Nixvim configuration, to build your own variant               |
| `nixvimModules.minimal`               | Profile module that switches all optional features off                     |
| `nixosModules.zenvim` / `.default`    | Adds `programs.zenvim` to NixOS                                            |
| `checks.<system>.*`                   | One check per profile; starts Neovim headless and fails on errors/warnings |
| `formatter.<system>`                  | `alejandra`                                                                |

Supported systems are `x86_64-linux` and `aarch64-linux`.

## Features

- **Completion**: blink.cmp with LSP, path, snippet, buffer and ripgrep sources.
- **Modular**: every language and its tooling, the AI integration, bufferline,
  mini.map, noice, persistence and the fun plugins can be switched on or off
  with a boolean option.
- **Profiles**: `full` (everything, the default) and `minimal` (no languages,
  only the essentials).
- **Language support**: 16 languages with LSP, inlay hints and navic
  breadcrumbs.
- **Formatting & linting**: conform and nvim-lint with per-filetype tools.
- **Treesitter**: all grammars prebuilt by Nix with highlighting, indentation
  and folding.
- **Testing & debugging**: neotest (Python, Rust, Plenary) with coverage, and
  nvim-dap with UI for Python, Go and LLDB.
- **Navigation**: snacks pickers, neo-tree, bufferline, mini.map and sessions.
- **Git**: gitsigns with inline blame and Lazygit integration.
- **AI**: claudecode in a floating snacks terminal.
- **Look & feel**: rose-pine (transparent outside Neovide), lualine, noice,
  tiny-inline-diagnostic and smart relative line numbers.
- **Project tools win**: bundled tools are appended to `PATH`, so versions from
  a project's devshell take precedence.

## Where to go next

- [Installation](installation.md) – run it, install it on NixOS or build a
  variant.
- [Profiles](profiles.md) and [Options](options.md) – choose what is enabled.
- [Keymaps](keymaps.md) – every mapping at a glance.
- [Languages](languages.md) and [Plugins](plugins.md) – what is configured and
  how.
