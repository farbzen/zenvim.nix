{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.nix;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.nil_ls = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.nix = ["alejandra"];
      extraPackagesAfter = [pkgs.alejandra];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt.nix = ["statix"];
      extraPackagesAfter = [pkgs.statix];
    })
  ];
}
