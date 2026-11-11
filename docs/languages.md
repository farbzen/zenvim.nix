# Languages

Every language has a switch `zenvim.languages.<language>.enable` and one
sub-option per feature it supports (`lsp`, `format`, `lint`, `dap`, `test`,
`render`). Sub-options default to the language switch and can be toggled on
their own:

```nix
zenvim.languages.python = {
  enable = true;
  dap.enable = false;
};
```

The supported features per language are declared in
`nixvim/languages/features.nix`. Shared plugins follow the languages: lspconfig,
conform, nvim-lint, nvim-dap with dap-ui and neotest with nvim-coverage are only
part of the configuration if at least one language enables the corresponding
feature (see [Plugins](plugins.md#language-tooling)).

## How tools are provided

- **Language servers** are enabled with Nixvim's `packageFallback = true`. The
  server from nixpkgs is appended to the end of `PATH`, so a server installed in
  the project (e.g. through a devshell) is used first.
- **Formatters and linters** are added with `extraPackagesAfter`, which also
  appends them to `PATH`.
- Tools marked as _not bundled_ below must come from the system or the project
  environment.

## Overview

| Language     | LSP                         | Format                            | Lint                      | DAP                      | Test            |
| ------------ | --------------------------- | --------------------------------- | ------------------------- | ------------------------ | --------------- |
| `lua`        | lua_ls + lazydev            | stylua                            | –                         | –                        | neotest-plenary |
| `nix`        | nil                         | alejandra                         | statix                    | –                        | –               |
| `python`     | pyright                     | isort + ruff_format (not bundled) | ruff (not bundled)        | nvim-dap-python          | neotest-python  |
| `go`         | gopls                       | gofmt (not bundled) + golines     | staticcheck (not bundled) | nvim-dap-go              | –               |
| `rust`       | rustaceanvim + crates       | rustfmt (not bundled)             | –                         | nvim-dap-lldb (codelldb) | neotest-rust    |
| `shell`      | bash-language-server        | shfmt                             | shellcheck                | –                        | –               |
| `html`       | vscode-html-language-server | prettierd                         | –                         | –                        | –               |
| `css`        | –                           | prettierd                         | stylelint                 | –                        | –               |
| `typescript` | typescript-tools            | deno fmt                          | eslint                    | –                        | –               |
| `svelte`     | svelte-language-server      | prettierd                         | eslint                    | –                        | –               |
| `tailwind`   | tailwindcss-language-server | –                                 | –                         | –                        | –               |
| `json`       | vscode-json-language-server | deno fmt                          | –                         | –                        | –               |
| `yaml`       | yaml-language-server        | –                                 | –                         | –                        | –               |
| `sql`        | sqls                        | –                                 | –                         | –                        | –               |
| `docker`     | dockerfile-language-server  | –                                 | –                         | –                        | –               |
| `markdown`   | –                           | deno fmt                          | –                         | –                        | –               |

## Details

### Lua

- **LSP**: `lua_ls` with signature help; `vim` and `hl` are known globals and
  the `missing-fields` diagnostic is disabled. lazydev provides completion for
  the Neovim Lua API.
- **Format**: stylua.
- **Test**: neotest-plenary for plenary/busted test files.

### Nix

- **LSP**: nil.
- **Format**: alejandra.
- **Lint**: statix.

### Python

- **LSP**: pyright.
- **Format**: isort, then `ruff format` – both not bundled.
- **Lint**: ruff – not bundled.
- **DAP**: nvim-dap-python.
- **Test**: neotest-python with `justMyCode = false`, so debugging a test also
  steps into library code.

### Go

- **LSP**: gopls.
- **Format**: gofmt (not bundled), then golines.
- **Lint**: staticcheck – not bundled.
- **DAP**: nvim-dap-go.

### Rust

- **LSP**: rustaceanvim, plus crates.nvim for `Cargo.toml`. rust-analyzer is not
  bundled, so the toolchain version of the project is used.
- **Format**: rustfmt – not bundled.
- **DAP**: nvim-dap-lldb using the bundled `codelldb` adapter from the
  vscode-lldb extension.
- **Test**: neotest-rust.

### Shell

Applies to the `sh` and `bash` filetypes.

- **LSP**: bash-language-server.
- **Format**: shfmt.
- **Lint**: shellcheck.

### HTML

- **LSP**: vscode-html-language-server.
- **Format**: prettierd for `html` and `htmldjango`.

### CSS

- **Format**: prettierd.
- **Lint**: stylelint.

### TypeScript

Applies to the `javascript` and `typescript` filetypes.

- **LSP**: typescript-tools.nvim.
- **Format**: `deno fmt`.
- **Lint**: eslint.

### Svelte

- **LSP**: svelte-language-server.
- **Format**: prettierd.
- **Lint**: eslint.

### Tailwind, JSON, YAML, SQL, Docker

- **Tailwind**: tailwindcss-language-server.
- **JSON**: vscode-json-language-server; formatting with `deno fmt`.
- **YAML**: yaml-language-server.
- **SQL**: sqls. The default SQL omni-completion mappings of Neovim are disabled
  (`omni_sql_no_default_maps`).
- **Docker**: dockerfile-language-server.

### Markdown

- **Format**: `deno fmt`.
- **Render**: render-markdown.nvim. Rendering is off by default and toggled per
  buffer with `<leader>mt`; `<leader>mp` opens a preview.
