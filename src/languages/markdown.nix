{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zenvim.languages.markdown;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.format.enable {
      plugins.conform-nvim.settings.formatters_by_ft.markdown = ["deno_fmt"];
      extraPackagesAfter = [pkgs.deno];
    })
    (lib.mkIf cfg.render.enable {
      plugins.render-markdown = {
        enable = true;
        settings.enabled = false;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>mp";
          action = "<cmd>RenderMarkdown preview<cr>";
          options.desc = "Open markdown preview";
        }
        {
          mode = "n";
          key = "<leader>mt";
          action = "<cmd>RenderMarkdown toggle<cr>";
          options.desc = "Toggle markdown rendering";
        }
      ];
    })
  ];
}
