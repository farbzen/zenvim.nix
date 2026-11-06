{
  anyLanguageUses,
  config,
  lib,
  ...
}: let
  inherit (lib.nixvim) mkRaw;

  emptySection = separator: {
    __unkeyed-1 = "";
    draw_empty = true;
    inherit separator;
  };

  truncate = length: ''
    if #str > (${toString length} + 3) then
      return str:sub(1, ${toString length}) .. "..."
    end

    return str
  '';
in {
  plugins = {
    navic = {
      enable = true;
      settings = {
        lsp.auto_attach = true;
        depth_limit = 3;
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = "";
            right = "";
          };
          ignore_focus = [
            "dapui_watches"
            "dapui_breakpoints"
            "dapui_scopes"
            "dapui_console"
            "dapui_stacks"
            "dap-repl"
            "neotest-summary"
            "neo-tree"
            "snacks_picker_list"
            "snacks_terminal"
          ];
        };

        winbar = {
          lualine_a = [
            {
              __unkeyed-1 = mkRaw ''
                function()
                  return ""
                end
              '';
              separator.left = "▎";
            }
            (emptySection {right = "";})
          ];
          lualine_b = [
            {
              __unkeyed-1 = mkRaw ''
                function()
                  local str = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                  ${truncate 26}
                end
              '';
            }
          ];
          lualine_c = ["navic"];
          lualine_x =
            lib.optional config.zenvim.noice.enable
            {
              __unkeyed-1 = mkRaw ''require("noice").api.status.mode.get'';
              fmt = mkRaw ''
                function(str)
                  local noice_status = require("noice").api.status.mode
                  if noice_status.has() and string.find(noice_status.get(), "recording") then
                    return str:gsub(".*(recording%W%W%w).*", "%1")
                  end

                  return ""
                end
              '';
            };
          lualine_y =
            [
              (emptySection {left = "";})
            ]
            ++ lib.optional (anyLanguageUses "dap")
            {
              __unkeyed-1 = mkRaw ''
                function()
                  local status = require("dap").status()
                  if status == "" then
                    return ""
                  elseif string.find(status, "Running") == 1 then
                    return ""
                  elseif string.find(status, "Stopped") == 1 then
                    return ""
                  end
                  return ""
                end
              '';
            }
            ++ lib.optional config.zenvim.tacho.enable "tacho";
          lualine_z = [
            (emptySection {left = "";})
            "progress"
          ];
        };

        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              separator.left = "▎";
            }
            (emptySection {
              left = "";
              right = "";
            })
          ];
          lualine_b = [
            {
              __unkeyed-1 = "filetype";
              colored = true;
              icon_only = true;
              icon.align = "left";
            }
            {
              __unkeyed-1 = "filename";
              symbols = {
                modified = " ";
                readonly = " ";
              };
            }
          ];
          lualine_c = [
            "diff"
            {
              __unkeyed-1 = "diagnostics";
              sources = ["nvim_lsp" "nvim_diagnostic" "nvim_diagnostic" "vim_lsp" "coc"];
              symbols = {
                error = "󰅙  ";
                warn = "  ";
                info = "  ";
                hint = "󰌵 ";
              };
              colored = true;
              update_in_insert = false;
              always_visible = false;
              diagnostics_color = {
                color_error.fg = "red";
                color_warn.fg = "yellow";
                color_info.fg = "cyan";
              };
            }
          ];
          lualine_x = [
            {
              __unkeyed-1 = mkRaw ''
                function()
                  local excluded_buf_ft = {
                    toggleterm = true,
                    NvimTree = true,
                    ["neo-tree"] = true,
                    TelescopePrompt = true,
                  }

                  if excluded_buf_ft[vim.bo.filetype] then
                    return ""
                  end

                  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

                  if vim.tbl_isempty(clients) then
                    return ""
                  end

                  local active_clients = {}
                  for _, client in ipairs(clients) do
                    table.insert(active_clients, client.name)
                  end

                  return table.concat(active_clients, ", ")
                end
              '';
              icon = " ";
              separator.left = "";
            }
          ];
          lualine_y = [
            (emptySection {
              left = "";
              right = "";
            })
            {
              __unkeyed-1 = "searchcount";
              maxcount = 999;
              timeout = 120;
            }
            {
              __unkeyed-1 = "branch";
              fmt = mkRaw ''
                function(str)
                  ${truncate 16}
                end
              '';
              icon = " •";
            }
          ];
          lualine_z = [
            (emptySection {
              left = "";
              right = "";
            })
            "location"
            {
              __unkeyed-1 = "fileformat";
              color.fg = "black";
              symbols = {
                unix = "";
                dos = "";
                mac = "";
              };
            }
          ];
        };
      };
    };
  };
}
