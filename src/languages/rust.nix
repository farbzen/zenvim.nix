{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.rust;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      plugins = {
        rustaceanvim.enable = true;
        crates.enable = true;
      };
      dependencies.rust-analyzer.enable = false;
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.rust = ["rustfmt"];
    })
    (lib.mkIf cfg.dap.enable {
      plugins.dap-lldb = {
        enable = true;
        settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
      };
    })
    (lib.mkIf cfg.test.enable {
      plugins.neotest.adapters.rust.enable = true;
    })
  ];
}
