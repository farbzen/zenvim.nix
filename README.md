<div align="center">

# zenvim.nix

_A batteries-included Neovim configuration, built with Nixvim._

[![Version](https://img.shields.io/badge/version-0.3.0-blue?style=for-the-badge&labelColor=081216)](CHANGELOG.md)
[![Nix](https://img.shields.io/badge/nix-flake-5277C3?style=for-the-badge&logo=nixos&logoColor=white&labelColor=081216)](https://nixos.org)
[![Neovim](https://img.shields.io/badge/neovim-nixvim-57A143?style=for-the-badge&logo=neovim&logoColor=white&labelColor=081216)](https://github.com/nix-community/nixvim)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge&labelColor=081216)](LICENSE)

[Overview](#overview) • [Features](#features) •
[Getting Started](#getting-started) • [Documentation](#documentation)

</div>

zenvim is a personal Neovim setup for polyglot development (Python, Go, Rust,
TypeScript/Svelte, Lua, Nix, shell and more). Every plugin, language server,
formatter and linter is pinned by Nix, so the same editor runs on any machine
with a single `nix run`.

## Overview

The whole configuration is declared as
[Nixvim](https://github.com/nix-community/nixvim) modules – no hand-written
`init.lua`. The flake is built with [flake-parts](https://flake.parts) and
provides:

- **Neovim packages** – `packages.<system>.full`, `packages.<system>.minimal`
  and `packages.<system>.default` (= `full`), runnable with `nix run`.
- **Nixvim modules** – `nixvimModules.full` (= `default`, everything enabled)
  and `nixvimModules.minimal` (profile that switches all optional features off),
  to build your own variant.
- **NixOS module** – `nixosModules.zenvim` (= `default`), adds
  `programs.zenvim` to pick a profile, toggle single options and set
  `EDITOR=nvim`.
- **Documentation** – `packages.<system>.docs`, this project's
  [mdBook](https://rust-lang.github.io/mdBook/) website including a generated
  option reference.
- **Checks** – one per profile, each starts Neovim headless and fails on any
  error or warning.

The code is organized as follows:

- `nixvim/` – the Nixvim configuration: general settings in `nixvim/*.nix`, one
  module per plugin in `nixvim/plugins/` and one module per language in
  `nixvim/languages/`.
- `profiles/` – the profiles `full.nix` and `minimal.nix`.
- `modules/` – the NixOS module `nixos.nix`.

## Features

- **Completion**: blink.cmp with LSP, path, snippet, buffer and ripgrep sources.
- **Modular**: every language and its tooling, AI integrations, bufferline,
  mini.map, noice, persistence and the fun plugins can be switched on or off
  with a boolean option.
- **Profiles**: `full` (everything, the default) and `minimal` (no languages,
  only the essentials) to try out right away.
- **Language support**: 16 languages with LSP (incl. rustaceanvim, crates and
  typescript-tools), inlay hints and navic breadcrumbs.
- **Formatting & linting**: conform and nvim-lint with per-filetype tools.
- **Treesitter**: all grammars prebuilt by Nix with highlighting, indentation
  and folding.
- **Testing & debugging**: neotest (Python, Rust, Plenary) with coverage, and
  nvim-dap with UI for Python, Go and LLDB.
- **Navigation**: snacks pickers, neo-tree, bufferline, mini.map and sessions
  via persistence.
- **Git**: gitsigns with inline blame and Lazygit integration.
- **AI**: claudecode in a floating snacks terminal.
- **Look & feel**: rose-pine (transparent outside Neovide), lualine, noice,
  tiny-inline-diagnostic and smart relative line numbers.
- **Project tools win**: bundled tools are appended to `PATH`, so versions from
  a project's devshell take precedence.

## Getting Started

### Prerequisites

- [Nix](https://nixos.org/download) with flakes enabled
- A [Nerd Font](https://www.nerdfonts.com) in your terminal

### Run it

```sh
nix run github:farbzen/zenvim.nix          # full profile
nix run github:farbzen/zenvim.nix#full
nix run github:farbzen/zenvim.nix#minimal
```

| Profile   | Contents                                                                                                        |
| --------- | --------------------------------------------------------------------------------------------------------------- |
| `full`    | All languages with LSP, formatter, linter, DAP and test adapters, claudecode, bufferline and all extras.        |
| `minimal` | Core editing only: snacks, neo-tree, lualine, gitsigns, blink.cmp, treesitter, which-key – no languages, no AI. |

From a local checkout:

```sh
nix run .
nix flake check
nix fmt
```

### Install on NixOS

Add the flake as an input, import the NixOS module and enable it:

```nix
{
  inputs.zenvim.url = "github:farbzen/zenvim.nix";
  inputs.zenvim.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {nixpkgs, zenvim, ...}: {
    nixosConfigurations.<host> = nixpkgs.lib.nixosSystem {
      modules = [
        zenvim.nixosModules.default
        {
          programs.zenvim = {
            enable = true;
            profile = "minimal";
            settings.zenvim.languages.python.enable = true;
          };
        }
      ];
    };
  };
}
```

`profile` is `"full"` (default) or `"minimal"`, `settings` takes any Nixvim
module and `defaultEditor` (default `true`) sets `EDITOR=nvim`. See
[Options](docs/options.md#nixos-module) for details.

> [!NOTE]
> `claude` (for claudecode), `rust-analyzer`, `rustfmt`, `gofmt`,
> `staticcheck`, `ruff` and `isort` are not bundled – they are expected from the
> system or the project environment.

### Customize

Every feature is a boolean under `zenvim.*`. Build your own variant from a
profile and override single options:

```nix
inputs.nixvim.lib.evalNixvim {
  system = "x86_64-linux";
  modules = [
    zenvim.nixvimModules.default
    zenvim.nixvimModules.minimal
    {
      zenvim.languages.python.enable = true;
      zenvim.languages.python.dap.enable = false;
    }
  ];
}
```

See [Options](docs/options.md) for the full list.

## Documentation

The full documentation is published at
[zenvim.farbzen.de](https://zenvim.farbzen.de/). Build it locally with
`nix build .#docs`.

- [Installation](docs/installation.md)
- [Profiles](docs/profiles.md)
- [Options](docs/options.md)
- [Keymaps](docs/keymaps.md)
- [Languages](docs/languages.md)
- [Plugins](docs/plugins.md)
- [Editor defaults](docs/editor.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Development](docs/development.md)
- [Changelog](CHANGELOG.md)
- [Legal Notice](docs/legal.md)

## License

See [LICENSE](LICENSE).
