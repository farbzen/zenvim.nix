{
  config,
  lib,
  pkgs,
  ...
}: {
  options.zenvim.cellularAutomaton.enable = lib.mkEnableOption "cellular-automaton.nvim" // {default = true;};

  config = lib.mkIf config.zenvim.cellularAutomaton.enable {
    extraPlugins = [pkgs.vimPlugins.cellular-automaton-nvim];

    keymaps = [
      {
        mode = "n";
        key = "<leader>fml";
        action = "<cmd>CellularAutomaton make_it_rain<cr>";
        options.desc = "Make it rain";
      }
      {
        mode = "n";
        key = "<leader>gol";
        action = "<cmd>CellularAutomaton game_of_life<cr>";
        options.desc = "Game of life";
      }
    ];
  };
}
