{
  config,
  lib,
  ...
}: {
  options.zenvim.noice.enable = lib.mkEnableOption "noice.nvim" // {default = true;};

  config = lib.mkIf config.zenvim.noice.enable {
    plugins.noice = {
      enable = true;
      settings.presets = {
        bottom_search = true;
        command_palette = true;
        lsp_doc_border = true;
        long_message_to_split = true;
        inc_rename = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>na";
        action = "<cmd>NoiceAll<cr>";
        options.desc = "Show snacks history";
      }
    ];
  };
}
