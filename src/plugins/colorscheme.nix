{lib, ...}: {
  colorschemes.rose-pine = {
    enable = true;
    settings = {
      variant = "main";
      styles.transparency = lib.nixvim.mkRaw "not vim.g.neovide";
    };
  };
}
