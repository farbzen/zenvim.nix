# Profiles

A profile is a Nixvim module that sets the default state of all
[options](options.md). zenvim ships two of them.

| Profile   | Module                  | Package                     | Contents                                                                                                        |
| --------- | ----------------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `full`    | `nixvimModules.full`    | `packages.<system>.full`    | All languages with LSP, formatter, linter, DAP and test adapters, claudecode, bufferline and all extras.        |
| `minimal` | `nixvimModules.minimal` | `packages.<system>.minimal` | Core editing only: snacks, neo-tree, lualine, gitsigns, blink.cmp, treesitter, which-key – no languages, no AI. |

`full` is also exported as `default`, both for the module and for the package.

## How the profiles work

`nixvimModules.full` is the actual configuration: it imports every module from
`nixvim/` and all options default to `true`.

`nixvimModules.minimal` contains no configuration of its own. It only sets every
language and every optional feature to `false` – with `lib.mkDefault`:

```nix
{lib, ...}: let
  disabled = {enable = lib.mkDefault false;};
in {
  zenvim = {
    languages = lib.genAttrs (lib.attrNames (import ../nixvim/languages/features.nix)) (_: disabled);
    ai.claudecode = disabled;
    bufferline = disabled;
    # …
  };
}
```

Because of `mkDefault`, a plain assignment in your own module wins without
`mkForce`. The minimal profile is therefore always used _together with_ the full
module (`nixvimModules.default` + `nixvimModules.minimal`).

## Starting from a profile

Start from `minimal` and switch single features on:

```nix
programs.zenvim = {
  enable = true;
  profile = "minimal";
  settings = {
    zenvim.languages.nix.enable = true;
    zenvim.persistence.enable = true;
  };
};
```

Or start from `full` and switch single features off:

```nix
programs.zenvim.settings = {
  zenvim.ai.claudecode.enable = false;
  zenvim.pentatonic.enable = false;
  zenvim.languages.rust.dap.enable = false;
};
```

## What is always enabled

Independent of the profile, the following is always part of the configuration:
snacks, neo-tree, lualine with navic, gitsigns, blink.cmp with ripgrep source,
treesitter with all grammars, which-key, nvim-surround, autoclose,
nvim-cursorline, tiny-inline-diagnostic, todo-comments, vim-sleuth, direnv,
web-devicons and the rose-pine colorscheme. See [Plugins](plugins.md) for
details.
