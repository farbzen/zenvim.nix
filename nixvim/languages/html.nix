{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.html;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.html = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft = {
        html = ["prettierd"];
        htmldjango = ["prettierd"];
      };
      extraPackagesAfter = [pkgs.prettierd];
    })
  ];
}
