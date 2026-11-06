{
  config,
  lib,
  pkgs,
  ...
}: {
  options.zenvim.tacho.enable = lib.mkEnableOption "the tacho.nvim typing speed meter" // {default = true;};

  config = lib.mkIf config.zenvim.tacho.enable {
    extraPlugins = [pkgs.vimPlugins.tacho-nvim];

    extraConfigLua = ''
      require("tacho").setup({
        idle_timeout_ms = 1000,
        statusline_format = "󰼭 {wpm}",
      })
    '';
  };
}
