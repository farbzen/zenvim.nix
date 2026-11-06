{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.css;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.css = ["prettierd"];
      extraPackagesAfter = [pkgs.prettierd];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt.css = ["stylelint"];
      extraPackagesAfter = [pkgs.stylelint];
    })
  ];
}
