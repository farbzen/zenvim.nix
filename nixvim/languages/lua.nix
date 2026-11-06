{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.lua;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      plugins.lazydev.enable = true;
      lsp.servers.lua_ls = {
        enable = true;
        packageFallback = true;
        config.settings.Lua = {
          signatureHelp.enabled = true;
          diagnostics = {
            globals = ["hl" "vim"];
            disable = ["missing-fields"];
          };
        };
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.lua = ["stylua"];
      extraPackagesAfter = [pkgs.stylua];
    })
    (lib.mkIf cfg.test.enable {
      plugins.neotest.adapters.plenary.enable = true;
    })
  ];
}
