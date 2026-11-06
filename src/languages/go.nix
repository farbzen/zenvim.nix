{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.go;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.gopls = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.go = ["gofmt" "golines"];
      extraPackagesAfter = [pkgs.golines];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt.go = ["staticcheck"];
    })
    (lib.mkIf cfg.dap.enable {
      plugins.dap-go.enable = true;
    })
  ];
}
