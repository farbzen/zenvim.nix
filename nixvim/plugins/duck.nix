{
  config,
  lib,
  pkgs,
  ...
}: {
  options.zenvim.duck.enable = lib.mkEnableOption "duck.nvim" // {default = true;};

  config = lib.mkIf config.zenvim.duck.enable {
    extraPlugins = [pkgs.vimPlugins.duck-nvim];

    keymaps = [
      {
        mode = "n";
        key = "<leader>dh";
        action = lib.nixvim.mkRaw ''function() require("duck").hatch() end'';
        options.desc = "Hatch a duck";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = lib.nixvim.mkRaw ''function() require("duck").cook() end'';
        options.desc = "Cook a duck (How could you...)";
      }
      {
        mode = "n";
        key = "<leader>dC";
        action = lib.nixvim.mkRaw ''function() require("duck").cook_all() end'';
        options.desc = "Cook all the ducks (YOU MONSTER...)";
      }
    ];
  };
}
