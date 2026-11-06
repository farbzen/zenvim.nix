{
  config,
  lib,
  ...
}: let
  colorBase = "#191725";
  backgroundSelected = "#1F1D2E";
  foregroundSelected = "#FFFFFF";

  baseBackground = {bg = colorBase;};
  selectedBackground = {bg = backgroundSelected;};

  withSelectedVariant = names:
    lib.genAttrs names (_: baseBackground)
    // lib.genAttrs (map (name: "${name}_selected") names) (_: selectedBackground);

  bufferGotoKeymaps = map (index: {
    mode = "n";
    key = "<M-${toString index}>";
    action = "<cmd>BufferLineGoToBuffer ${toString index}<cr>";
    options.desc = "Jump to buffer ${toString index} in bufferline";
  }) (lib.range 1 9);
in {
  options.zenvim.bufferline.enable = lib.mkEnableOption "the bufferline" // {default = true;};

  config = lib.mkIf config.zenvim.bufferline.enable {
    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          always_show_bufferline = true;
          show_close_icon = false;
          separator_style = "slope";
          hover = {
            enabled = true;
            delay = 100;
            reveal = ["close"];
          };
          diagnostics = "nvim_lsp";
          diagnostics_indicator = lib.nixvim.mkRaw ''
            function(count, level)
              local icon = level:match("error") and " " or " "
              return " " .. icon .. count
            end
          '';
          offsets = [
            {
              filetype = "neotest-summary";
              text = "Tests";
              text_align = "left";
              separator = true;
            }
          ];
        };

        highlights =
          withSelectedVariant [
            "close_button"
            "modified"
            "numbers"
            "hint"
            "info"
            "warning"
            "error"
            "diagnostic"
            "hint_diagnostic"
            "info_diagnostic"
            "warning_diagnostic"
            "error_diagnostic"
            "duplicate"
            "pick"
          ]
          // {
            fill = {
              bg = colorBase;
              fg = colorBase;
            };
            separator = {
              fg = colorBase;
              bg = colorBase;
            };
            separator_selected = {
              bg = backgroundSelected;
              fg = colorBase;
            };
            separator_visible.fg = colorBase;
            tab_selected.fg = foregroundSelected;
            tab_separator.fg = colorBase;
            tab_separator_selected.fg = colorBase;
            background = baseBackground;
            trunc_marker = baseBackground;
            buffer_selected = selectedBackground;
            indicator_selected = selectedBackground;
          };
      };
    };

    keymaps =
      [
        {
          mode = "n";
          key = "<M-h>";
          action = "<cmd>BufferLineCyclePrev<cr>";
          options.desc = "Jump to previous buffer";
        }
        {
          mode = "n";
          key = "<M-l>";
          action = "<cmd>BufferLineCycleNext<cr>";
          options.desc = "Jump to next buffer";
        }
        {
          mode = "n";
          key = "<M-$>";
          action = "<cmd>BufferLineGoToBuffer -1<cr>";
          options.desc = "Jump to last buffer in bufferline";
        }
      ]
      ++ bufferGotoKeymaps;
  };
}
