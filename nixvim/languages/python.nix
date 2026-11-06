{
  config,
  lib,
  ...
}: let
  cfg = config.zenvim.languages.python;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.lsp.enable {
      lsp.servers.pyright = {
        enable = true;
        packageFallback = true;
      };
    })
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.python = ["isort" "ruff_format"];
    })
    (lib.mkIf cfg.lint.enable {
      plugins.lint.lintersByFt.python = ["ruff"];
    })
    (lib.mkIf cfg.dap.enable {
      plugins.dap-python.enable = true;
    })
    (lib.mkIf cfg.test.enable {
      plugins.neotest.adapters.python = {
        enable = true;
        settings.dap.justMyCode = false;
      };
    })
  ];
}
