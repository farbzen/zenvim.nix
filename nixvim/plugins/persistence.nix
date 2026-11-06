{
  config,
  lib,
  ...
}: {
  options.zenvim.persistence.enable = lib.mkEnableOption "session management with persistence.nvim" // {default = true;};

  config = lib.mkIf config.zenvim.persistence.enable {
    plugins.persistence = {
      enable = true;
      settings = {
        dir = lib.nixvim.mkRaw ''vim.fn.stdpath("state") .. "/sessions/"'';
        need = 1;
        branch = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ql";
        action = lib.nixvim.mkRaw ''require("persistence").load'';
        options.desc = "Load the last session";
      }
      {
        mode = "n";
        key = "<leader>qL";
        action = lib.nixvim.mkRaw ''require("persistence").select'';
        options.desc = "Select a session to load";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = lib.nixvim.mkRaw ''require("persistence").stop'';
        options.desc = "Disable persistence (no save on exit)";
      }
    ];
  };
}
