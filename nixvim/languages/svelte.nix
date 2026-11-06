{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.svelte;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.svelte = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.svelte = ["prettierd"];
      extraPackagesAfter = [pkgs.prettierd];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt.svelte = ["eslint"];
      extraPackagesAfter = [pkgs.eslint];
    })
  ];
}
