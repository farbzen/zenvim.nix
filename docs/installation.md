# Installation

## Prerequisites

- [Nix](https://nixos.org/download) with the `nix-command` and `flakes`
  experimental features enabled.
- A [Nerd Font](https://www.nerdfonts.com) in your terminal; icons in the
  statusline, bufferline, file explorer and diagnostics rely on it.
- An `x86_64-linux` or `aarch64-linux` system.

## Try it without installing

```sh
nix run github:farbzen/zenvim.nix          # full profile
nix run github:farbzen/zenvim.nix#full
nix run github:farbzen/zenvim.nix#minimal
```

Arguments after `--` are passed to Neovim:

```sh
nix run github:farbzen/zenvim.nix -- README.md
```

## Install on NixOS

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

The module installs the resulting package into `environment.systemPackages` and,
unless `defaultEditor = false`, sets `EDITOR=nvim`. `settings` accepts any
Nixvim module, so besides the `zenvim.*` switches you can also set plain Nixvim
options there. All options are listed in the
[NixOS options reference](https://zenvim.farbzen.de/reference/nixos-options.html).

> **Note:** `follows = "nixpkgs"` makes zenvim build against your system's
> nixpkgs. Leave it out to use the exact versions pinned in zenvim's
> `flake.lock`.

## Install with any other Nix setup

The packages are ordinary derivations, so they can be added to a Home Manager
configuration or a devshell:

```nix
home.packages = [inputs.zenvim.packages.${pkgs.stdenv.hostPlatform.system}.full];
```

## Build your own variant

`nixvimModules.default` contains the complete configuration. Combine it with a
profile and your own overrides and evaluate it with Nixvim:

```nix
let
  configuration = inputs.nixvim.lib.evalNixvim {
    system = "x86_64-linux";
    modules = [
      inputs.zenvim.nixvimModules.default
      inputs.zenvim.nixvimModules.minimal
      {nixpkgs.source = inputs.nixpkgs;}
      {
        zenvim.languages.python.enable = true;
        zenvim.languages.python.dap.enable = false;
      }
    ];
  };
in
  configuration.config.build.package
```

Because the variant is a Nixvim configuration, every Nixvim option is available
in your own modules as well, e.g. `plugins.<name>.enable` or `opts.*`.

## Tools you provide yourself

A few tools are deliberately not bundled and are expected from the system or the
project environment:

| Tool            | Needed for                                    |
| --------------- | --------------------------------------------- |
| `claude`        | claudecode (`zenvim.ai.claudecode`)           |
| `rust-analyzer` | Rust LSP via rustaceanvim                     |
| `rustfmt`       | Rust formatting                               |
| `gofmt`         | Go formatting (together with bundled golines) |
| `staticcheck`   | Go linting                                    |
| `ruff`, `isort` | Python formatting and linting                 |

See [Languages](languages.md) for what each language bundles.
