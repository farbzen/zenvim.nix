{
  anyLanguageUses,
  lib,
  ...
}: let
  mkNeotestKeymap = key: action: desc: {
    mode = "n";
    inherit key;
    action = lib.nixvim.mkRaw action;
    options.desc = desc;
  };
in {
  config = lib.mkIf (anyLanguageUses "test") {
    plugins = {
      neotest = {
        enable = true;
        settings.floating.border = "rounded";
      };

      coverage = {
        enable = true;
        settings.auto_reload = true;
      };
    };

    keymaps = [
      (mkNeotestKeymap "<leader>tr" ''require("neotest").run.run'' "Run current test(s)")
      (mkNeotestKeymap "<leader>td" ''
        function()
          require("neotest").run.run({ strategy = "dap" })
        end
      '' "Debug current test(s)")
      (mkNeotestKeymap "<leader>ta" ''require("neotest").run.attach'' "Attach to current test(s)")
      (mkNeotestKeymap "<leader>to" ''require("neotest").output_panel.toggle'' "Toggle test output panel")
      (mkNeotestKeymap "<leader>ts" ''require("neotest").summary.toggle'' "Toggle test summary")
      {
        mode = "n";
        key = "<leader>tcs";
        action = "<cmd>Coverage<cr>";
        options.desc = "Show test coverage";
      }
      {
        mode = "n";
        key = "<leader>tcc";
        action = "<cmd>CoverageClear<cr>";
        options.desc = "Clear test coverage";
      }
      {
        mode = "n";
        key = "<leader>tcS";
        action = "<cmd>CoverageSummary<cr>";
        options.desc = "Show test coverage summary";
      }
    ];
  };
}
