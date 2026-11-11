# Troubleshooting

## Icons are missing or show as boxes

The statusline, bufferline, neo-tree and the diagnostic signs use Nerd Font
glyphs. Configure a [Nerd Font](https://www.nerdfonts.com) in your terminal. In
Neovide, `JetBrainsMono Nerd Font` must be installed.

## A formatter, linter or language server does nothing

1. Check that the language and the feature are enabled, e.g.
   `zenvim.languages.go.lint.enable`. The `minimal` profile disables all
   languages.
2. Check whether the tool is bundled. `claude`, `rust-analyzer`, `rustfmt`,
   `gofmt`, `staticcheck`, `ruff` and `isort` are not – install them in the
   system or the project environment (see [Languages](languages.md)).
3. Run `:checkhealth vim.lsp` or `:ConformInfo` for details.

## The wrong tool version is used

Bundled tools are appended to the _end_ of `PATH`, so a version from the project
environment always wins. That is intended: projects can pin their own formatter
or language server, e.g. through a devshell loaded by direnv. If you expect the
bundled version, check `:!which <tool>`.

## The project environment is not picked up

direnv.vim loads `.envrc` files, but only after you allowed them with
`direnv allow` in the shell. Start Neovim from inside the project directory.

## claudecode opens but nothing happens

The `claude` CLI is not bundled. Install Claude Code and make sure `claude` is
on `PATH`, or disable the integration with
`zenvim.ai.claudecode.enable = false`.

## The configuration does not build

`nix flake check` builds one check per profile that starts Neovim headless and
fails on any error or warning. Run it to see the message:

```sh
nix flake check -L
```

## Getting help

Open an issue at
[github.com/farbzen/zenvim.nix](https://github.com/farbzen/zenvim.nix/issues).
