{
  config,
  lib,
  pkgs,
  ...
}: {
  options.zenvim.pentatonic.enable = lib.mkEnableOption "pentatonic.nvim" // {default = true;};

  config = lib.mkIf config.zenvim.pentatonic.enable {
    extraPlugins = [pkgs.vimPlugins.pentatonic-nvim];

    extraConfigLua = ''
      require("pentatonic").setup({ volume = 0.05 })
    '';
  };
}
