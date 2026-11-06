# Options

All options are booleans and default to `true`, which corresponds to the `full`
profile. The `minimal` profile (`nixvimModules.minimal`) sets every option on
this page to `false` with `lib.mkDefault`, so single options can be switched
back on.

## Languages

`zenvim.languages.<language>.enable` switches a language with all of its
tooling. Each sub-option defaults to the value of the language switch and can be
toggled separately, e.g. `zenvim.languages.python.dap.enable = false`.

| Language     | Sub-options                            | Tooling                                                                |
| ------------ | -------------------------------------- | ---------------------------------------------------------------------- |
| `lua`        | `lsp`, `format`, `test`                | lua_ls + lazydev, stylua, neotest-plenary                              |
| `nix`        | `lsp`, `format`, `lint`                | nil, alejandra, statix                                                 |
| `python`     | `lsp`, `format`, `lint`, `dap`, `test` | pyright, isort + ruff_format, ruff, nvim-dap-python, neotest-python    |
| `go`         | `lsp`, `format`, `lint`, `dap`         | gopls, gofmt + golines, staticcheck, nvim-dap-go                       |
| `rust`       | `lsp`, `format`, `dap`, `test`         | rustaceanvim + crates, rustfmt, nvim-dap-lldb (codelldb), neotest-rust |
| `shell`      | `lsp`, `format`, `lint`                | bash-language-server, shfmt, shellcheck                                |
| `html`       | `lsp`, `format`                        | vscode-html-language-server, prettierd (html, htmldjango)              |
| `css`        | `format`, `lint`                       | prettierd, stylelint                                                   |
| `typescript` | `lsp`, `format`, `lint`                | typescript-tools, deno fmt (JS/TS), eslint                             |
| `svelte`     | `lsp`, `format`, `lint`                | svelte-language-server, prettierd, eslint                              |
| `tailwind`   | `lsp`                                  | tailwindcss-language-server                                            |
| `json`       | `lsp`, `format`                        | vscode-json-language-server, deno fmt                                  |
| `yaml`       | `lsp`                                  | yaml-language-server                                                   |
| `sql`        | `lsp`                                  | sqls                                                                   |
| `docker`     | `lsp`                                  | dockerfile-language-server                                             |
| `markdown`   | `format`, `render`                     | deno fmt, render-markdown                                              |

The shared tooling follows the languages: the LSP core (lspconfig, inlay hints,
`K`, `<C-k>`, `<leader>lR`, `<leader>th`), conform, nvim-lint, nvim-dap with
dap-ui and neotest with nvim-coverage are only enabled when at least one
language uses the respective feature. The DAP status in the winbar follows
nvim-dap as well.

## Integrations and extras

| Option                            | Enables                                                       |
| --------------------------------- | ------------------------------------------------------------- |
| `zenvim.ai.claudecode.enable`     | claudecode in a floating snacks terminal (`<C-,>`)            |
| `zenvim.bufferline.enable`        | bufferline with `<M-h>`, `<M-l>`, `<M-1>`…`<M-9>`, `<M-$>`    |
| `zenvim.miniMap.enable`           | mini.map minimap (`<leader>mm`)                               |
| `zenvim.noice.enable`             | noice UI, macro recording status in the winbar, `<leader>na`  |
| `zenvim.persistence.enable`       | session management (`<leader>ql`, `<leader>qL`, `<leader>qd`) |
| `zenvim.tacho.enable`             | typing speed in the winbar                                    |
| `zenvim.pentatonic.enable`        | pentatonic typing sounds                                      |
| `zenvim.duck.enable`              | duck.nvim (`<leader>dh`, `<leader>dc`, `<leader>dC`)          |
| `zenvim.cellularAutomaton.enable` | cellular-automaton (`<leader>fml`, `<leader>gol`)             |

## NixOS module

`nixosModules.zenvim` (also available as `nixosModules.default`) provides
`programs.zenvim`:

| Option                          | Type                    | Default  | Description                                               |
| ------------------------------- | ----------------------- | -------- | --------------------------------------------------------- |
| `programs.zenvim.enable`        | bool                    | `false`  | Install zenvim.                                           |
| `programs.zenvim.profile`       | `"full"` or `"minimal"` | `"full"` | Profile the configuration starts from.                    |
| `programs.zenvim.settings`      | Nixvim module           | `{}`     | Applied on top of the profile, e.g. to toggle `zenvim.*`. |
| `programs.zenvim.defaultEditor` | bool                    | `true`   | Set `EDITOR` to `nvim`.                                   |
| `programs.zenvim.package`       | package (read-only)     | –        | The resulting package.                                    |

```nix
programs.zenvim = {
  enable = true;
  profile = "minimal";
  settings = {
    zenvim.languages.nix.enable = true;
    zenvim.languages.nix.lint.enable = false;
    zenvim.tacho.enable = true;
  };
};
```

## Always enabled

snacks, neo-tree, lualine with navic, gitsigns, blink.cmp with ripgrep source,
treesitter with all grammars, which-key, nvim-surround, autoclose,
nvim-cursorline, tiny-inline-diagnostic, todo-comments, vim-sleuth, direnv,
web-devicons and the rose-pine colorscheme.
