{
  anyLanguageUses,
  lib,
  ...
}: {
  config = lib.mkIf (anyLanguageUses "format") {
    plugins.conform-nvim.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>lf";
        action = lib.nixvim.mkRaw ''
          function()
            require("conform").format({ async = true })
          end
        '';
        options.desc = "Format current file";
      }
    ];
  };
}
