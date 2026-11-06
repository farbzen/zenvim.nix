{
  globals = {
    mapleader = " ";
    maplocalleader = " ";
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    omni_sql_no_default_maps = 1;
  };

  opts = {
    clipboard = "unnamedplus";
    exrc = true;
    mousemoveevent = true;
    number = true;
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    wrap = false;
    hlsearch = true;
    cursorlineopt = "number";
    breakindent = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    termguicolors = true;
    inccommand = "split";
  };

  diagnostic.settings.signs = let
    perSeverity = error: warn: info: hint: {
      __raw = ''
        {
          [vim.diagnostic.severity.ERROR] = "${error}",
          [vim.diagnostic.severity.WARN] = "${warn}",
          [vim.diagnostic.severity.INFO] = "${info}",
          [vim.diagnostic.severity.HINT] = "${hint}",
        }
      '';
    };
  in {
    text = perSeverity " " " " " " " ";
    linehl = perSeverity "" "" "" "";
    numhl = perSeverity "" "" "" "";
  };

  extraConfigLua = ''
    if vim.g.neovide then
      vim.o.guifont = "JetBrainsMono Nerd Font,Noto Color Emoji:h13"
      vim.opt.linespace = 5

      vim.g.neovide_padding_top = 16
      vim.g.neovide_padding_right = 16
      vim.g.neovide_padding_bottom = 16
      vim.g.neovide_padding_left = 16

      vim.g.neovide_floating_corner_radius = 0.5
      vim.g.neovide_opacity = 0.95
      vim.g.neovide_normal_opacity = 0.8

      vim.g.neovide_cursor_vfx_mode = "pixiedust"
      vim.g.neovide_scroll_animation_length = 0.2

      vim.g.neovide_underline_stroke_scale = 2

      local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
      end

      vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.2)
      end, { desc = "Zoom in" })
      vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.2)
      end, { desc = "Zoom out" })
    end
  '';
}
