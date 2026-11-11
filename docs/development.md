# Development

## Repository layout

| Path                   | Content                                                           |
| ---------------------- | ----------------------------------------------------------------- |
| `flake.nix`            | Flake outputs, built with flake-parts and the Nixvim flake module |
| `nixvim/*.nix`         | General settings: options, autocommands, smart numbers, packages  |
| `nixvim/plugins/`      | One module per plugin, imported by `default.nix`                  |
| `nixvim/languages/`    | One module per language, plus `features.nix` and `default.nix`    |
| `profiles/full.nix`    | Imports everything from `nixvim/`                                 |
| `profiles/minimal.nix` | Sets all optional features to `lib.mkDefault false`               |
| `modules/nixos.nix`    | The NixOS module `programs.zenvim`                                |
| `nix/docs.nix`         | Builds this book, including the generated option reference        |
| `docs/`, `book.toml`   | Sources of this book                                              |

## Everyday commands

```sh
nix run .                 # run the full profile from the checkout
nix run .#minimal         # run the minimal profile
nix flake check           # start every profile headless, fail on errors/warnings
nix fmt                   # format Nix files with alejandra
nix build .#docs          # build this book into ./result
```

A `devenv.nix` with Nix language support is available for `direnv`/devenv users.

## Adding a language

1. Add the language and its features to `nixvim/languages/features.nix`:

   ```nix
   zig = ["lsp" "format"];
   ```

   This creates `zenvim.languages.zig.enable`, `…lsp.enable` and
   `…format.enable`, imports `nixvim/languages/zig.nix` and makes the `minimal`
   profile disable it.

2. Create `nixvim/languages/zig.nix` and guard each feature with its option:

   ```nix
   {config, lib, pkgs, ...}: let
     cfg = config.zenvim.languages.zig;
   in {
     config = lib.mkMerge [
       (lib.mkIf cfg.lsp.enable {
         lsp.servers.zls = {
           enable = true;
           packageFallback = true;
         };
       })
       (lib.mkIf cfg.format.enable {
         plugins.conform-nvim.settings.formatters_by_ft.zig = ["zigfmt"];
       })
     ];
   }
   ```

   Use `packageFallback = true` for language servers and `extraPackagesAfter`
   for other tools, so project versions take precedence.

3. Shared plugins such as conform or nvim-lint switch on automatically through
   `anyLanguageUses "<feature>"`, which is passed to every module as an argument
   by `nixvim/languages/default.nix`.

A new feature kind (besides `lsp`, `format`, `lint`, `dap`, `test`, `render`)
also needs a description in `featureDescriptions` in
`nixvim/languages/default.nix`.

## Adding a plugin

Create `nixvim/plugins/<name>.nix` and import it in
`nixvim/plugins/default.nix`. A plugin that is part of every profile simply sets
its configuration. An optional plugin declares a switch that defaults to `true`:

```nix
{config, lib, ...}: {
  options.zenvim.<name>.enable = lib.mkEnableOption "<description>" // {default = true;};

  config = lib.mkIf config.zenvim.<name>.enable {
    plugins.<name>.enable = true;
  };
}
```

Then add `<name> = disabled;` to `profiles/minimal.nix` and document the option
in [Options](options.md). The [option reference](reference/nixvim-options.md)
picks it up automatically.

Keymaps belong to the module of the plugin they use and always get an
`options.desc`, which is shown by which-key. Add them to [Keymaps](keymaps.md)
as well.

## Documentation

This book is written with [mdBook](https://rust-lang.github.io/mdBook/). The
sources are in `docs/`, the configuration in `book.toml`. `nix/docs.nix`
generates the pages under `docs/reference/` from the option declarations with
`nixosOptionsDoc` before running `mdbook build`; they are not checked in.

```sh
nix build .#docs
xdg-open result/index.html
```

A GitHub Actions workflow (`.github/workflows/docs.yml`) builds the book on
every push to `main` and publishes it to GitHub Pages.

## Versioning and changelog

The project follows [Semantic Versioning](https://semver.org); the current
version is stored in `version`. Changes are recorded in the
[changelog](changelog.md), and commit messages follow
[Conventional Commits](https://www.conventionalcommits.org).
