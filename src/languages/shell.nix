{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.shell;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.bashls = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft = {
        bash = ["shfmt"];
        sh = ["shfmt"];
      };
      extraPackagesAfter = [pkgs.shfmt];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt = {
        bash = ["shellcheck"];
        sh = ["shellcheck"];
      };
      extraPackagesAfter = [pkgs.shellcheck];
    })
  ];
}
