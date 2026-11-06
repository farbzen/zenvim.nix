# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-11-06

### Added

- Flake outputs `nixvimModules.full` and `nixosModules.zenvim` as named
  equivalents of `nixvimModules.default` and `nixosModules.default`.

### Changed

- The code moved from `src/` to `nixvim/` (Nixvim configuration), `profiles/`
  (`full` and `minimal`) and `modules/` (NixOS module). The built packages are
  unchanged.

## [0.1.0] - 2026-11-06

### Added

- Neovim configuration built with Nixvim, ported from the previous
  `nix-wrapper-modules` setup with Lua dotfiles: options, autocommands, smart
  relative line numbers, Neovide settings and all keymaps.
- Plugins: autoclose, blink.cmp with ripgrep source, bufferline, claudecode,
  conform, nvim-cursorline, nvim-dap with dap-ui and Python/Go/LLDB adapters,
  gitsigns, nvim-lint, lualine with navic, mini.map, neotest with
  Python/Plenary/Rust adapters and nvim-coverage, neo-tree, noice, persistence,
  render-markdown, vim-sleuth, snacks with todo-comments,
  tiny-inline-diagnostic, treesitter with all grammars, rustaceanvim, crates,
  typescript-tools, lazydev, which-key, nvim-surround, direnv, rose-pine as well
  as cellular-automaton, duck, pentatonic and tacho.
- Language servers for Lua, Python, Go, Svelte, HTML, SQL, Tailwind CSS, JSON,
  YAML, Dockerfile, Bash and Nix, plus formatters, linters and CLI tools. All of
  them are appended to `PATH`, so project-local versions take precedence.
- Boolean options under `zenvim.*`: `zenvim.languages.<language>.enable` for 16
  languages (Lua, Nix, Python, Go, Rust, Shell, HTML, CSS, TypeScript, Svelte,
  Tailwind CSS, JSON, YAML, SQL, Docker, Markdown) with sub-options for LSP,
  formatter, linter, DAP, test adapter and Markdown rendering, plus switches for
  claudecode, bufferline, mini.map, noice, persistence, tacho, pentatonic, duck
  and cellular-automaton. Shared tooling (LSP core, conform, nvim-lint,
  nvim-dap, neotest) and language-specific tools are only included when a
  language needs them.
- Profiles `full` (everything enabled) and `minimal` (no languages, only the
  essentials) as packages `full`, `minimal` and `default` (= `full`), with one
  Nixvim check per profile.
- Flake outputs `nixvimModules.default` and `nixvimModules.minimal` to build
  custom variants.
- NixOS module `nixosModules.default` with `programs.zenvim.enable`, `profile`,
  `settings` (Nixvim module on top of the profile), `defaultEditor` and the
  read-only `package`.

### Changed

- Plugins are no longer lazy-loaded; lze/lzextras and the `nixInfo` glue are
  gone.
- Treesitter parsers are provided by Nix only; on-demand parser installation was
  dropped.
- claudecode logs only warnings and errors.

### Fixed

- `<leader>lf` formats asynchronously as intended (`async = true` instead of the
  string `"true"`).
- nvim-coverage reloads automatically (`auto_reload` instead of the misspelled
  `auto_reafter`).
- The LLDB debug adapter points to the `codelldb` binary from nixpkgs.

[Unreleased]: https://github.com/farbzen/zenvim.nix/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/farbzen/zenvim.nix/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/farbzen/zenvim.nix/releases/tag/v0.1.0
