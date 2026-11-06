{
  config,
  lib,
  ...
}: {
  options.zenvim.miniMap.enable = lib.mkEnableOption "the mini.map minimap" // {default = true;};

  config = lib.mkIf config.zenvim.miniMap.enable {
    plugins.mini-map = {
      enable = true;
      settings = {
        integrations = lib.nixvim.mkRaw ''
          {
            require("mini.map").gen_integration.builtin_search(),
            require("mini.map").gen_integration.diagnostic(),
            require("mini.map").gen_integration.gitsigns(),
          }
        '';
        window.winblend = 0;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>mm";
        action = lib.nixvim.mkRaw ''require("mini.map").toggle'';
        options.desc = "Toggle minimap";
      }
    ];
  };
}
