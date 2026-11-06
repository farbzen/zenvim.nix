{
  anyLanguageUses,
  lib,
  ...
}: let
  mkDapKeymap = key: action: desc: {
    mode = "n";
    inherit key;
    action = lib.nixvim.mkRaw action;
    options.desc = "DAP: ${desc}";
  };
in {
  config = lib.mkIf (anyLanguageUses "dap") {
    plugins = {
      dap.enable = true;

      dap-ui = {
        enable = true;
        settings.layouts = [
          {
            elements = [
              {
                id = "console";
                size = 0.7;
              }
              {
                id = "watches";
                size = 0.15;
              }
              {
                id = "breakpoints";
                size = 0.15;
              }
            ];
            size = 8;
            position = "bottom";
          }
        ];
      };
    };

    keymaps = [
      (mkDapKeymap "<F4>" ''
        function()
          require("dap").close()
          require("dapui").close()
        end
      '' "Close")
      (mkDapKeymap "<F5>" ''require("dap").continue'' "Start/Continue")
      (mkDapKeymap "<F6>" ''require("dap").restart'' "Restart")
      (mkDapKeymap "<F10>" ''require("dap").step_over'' "Step over")
      (mkDapKeymap "<F11>" ''require("dap").step_into'' "Step into")
      (mkDapKeymap "<F12>" ''require("dap").step_out'' "Step out")
      (mkDapKeymap "<leader>db" ''require("dap").toggle_breakpoint'' "Toggle breakpoint")
      (mkDapKeymap "<leader>dr" ''require("dap").repl.open'' "Open REPL")
      (mkDapKeymap "<leader>du" ''require("dapui").toggle'' "Open UI")
    ];
  };
}
