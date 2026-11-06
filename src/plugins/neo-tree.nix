{
  plugins.neo-tree = {
    enable = true;
    settings = {
      popup_border_style = "rounded";
      filesystem = {
        filtered_items.visible = true;
        follow_current_file.enabled = true;
        close_if_last_window = true;
        window = {
          position = "float";
          mappings = {
            l = "open";
            h = "close_node";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-o>";
      action = "<cmd>Neotree<cr>";
      options.desc = "Open file explorer";
    }
  ];
}
