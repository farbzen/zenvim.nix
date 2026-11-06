{
  plugins.gitsigns = {
    enable = true;
    settings.current_line_blame = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
      options.desc = "Toggle git blame on current line";
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action = "<cmd>Gitsigns preview_hunk<cr>";
      options.desc = "Preview git hunk";
    }
    {
      mode = "n";
      key = "<leader>ghP";
      action = "<cmd>Gitsigns preview_hunk_inline<cr>";
      options.desc = "Preview git hunk inline";
    }
    {
      mode = "n";
      key = "<leader>ghs";
      action = "<cmd>Gitsigns stage_hunk<cr>";
      options.desc = "Stage git hunk";
    }
    {
      mode = "n";
      key = "<leader>ghr";
      action = "<cmd>Gitsigns reset_hunk<cr>";
      options.desc = "Reset git hunk";
    }
  ];
}
