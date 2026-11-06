{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.typescript;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      plugins.typescript-tools.enable = true;
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft = {
        javascript = ["deno_fmt"];
        typescript = ["deno_fmt"];
      };
      extraPackagesAfter = [pkgs.deno];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt = {
        javascript = ["eslint"];
        typescript = ["eslint"];
      };
      extraPackagesAfter = [pkgs.eslint];
    })
  ];
}
