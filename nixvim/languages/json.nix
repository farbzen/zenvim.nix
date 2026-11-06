{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.json;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.jsonls = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.json = ["deno_fmt"];
      extraPackagesAfter = [pkgs.deno];
    })
  ];
}
