{lib, ...}: let
  mkSnacksKeymap = key: call: desc: {
    mode = "n";
    inherit key;
    action = lib.nixvim.mkRaw "function() Snacks.${call}() end";
    options.desc = desc;
  };

  enabled = {enabled = true;};
in {
  plugins = {
    todo-comments.enable = true;

    snacks = {
      enable = true;
      settings = {
        animate = enabled;
        bigfile = enabled;
        dim = enabled;
        indent = enabled;
        input = enabled;
        lazygit = enabled;
        notifier = enabled;
        picker = enabled;
        quickfile = enabled;
        scope = enabled;
        scratch = {
          enabled = true;
          ft = "markdown";
        };
        statuscolumn = enabled;
        terminal = enabled;
        words = enabled;
      };
    };
  };

  keymaps = [
    (mkSnacksKeymap "<C-M-o>" "picker.projects" "List recent projects")
    (mkSnacksKeymap "<leader>bo" "picker.buffers" "Show open buffers")
    (mkSnacksKeymap "<leader>ff" "picker.files" "Find file")
    (mkSnacksKeymap "<leader>fg" "picker.grep" "Find content in files")
    ((mkSnacksKeymap "<leader>fw" "picker.grep_word" "Find current word or selection in files")
      // {mode = ["n" "x"];})
    (mkSnacksKeymap "<leader>lu" "picker.undo" "Show undo history")
    (mkSnacksKeymap "<leader>bw" "bufdelete.delete" "Close current buffer")
    (mkSnacksKeymap "<leader>bc" "bufdelete.other" "Close all except the current buffer")
    (mkSnacksKeymap "gd" "picker.lsp_definitions" "Go to definition")
    (mkSnacksKeymap "<leader>lr" "picker.lsp_references" "Show LSP references")
    (mkSnacksKeymap "<leader>ls" "picker.lsp_symbols" "Show LSP symbols")
    (mkSnacksKeymap "<leader>lD" "picker.diagnostics" "Show diagnostics")
    (mkSnacksKeymap "<leader>ld" "picker.diagnostics_buffer" "Show diagnostics for current buffer")
    (mkSnacksKeymap "<leader>ll" "picker.loclist" "Show location list")
    (mkSnacksKeymap "<leader>lq" "picker.qflist" "Show quickfix list")
    (mkSnacksKeymap "<leader>lt" "picker.todo_comments" "Show TODO comments")
    (mkSnacksKeymap "<leader>gg" "lazygit.open" "Open Lazygit")
    (mkSnacksKeymap "<leader>tt" "terminal" "Toggle terminal")
    {
      mode = "n";
      key = "<leader>ds";
      action = lib.nixvim.mkRaw ''
        function()
          if Snacks.dim.enabled then
            Snacks.dim.disable()
          else
            Snacks.dim.enable()
          end
        end
      '';
      options.desc = "Dim code around the current block";
    }
    (mkSnacksKeymap "<leader>s" "scratch.open" "Open scratchpad")
    (mkSnacksKeymap "<leader>S" "scratch.select" "Select scratchpad")
    (mkSnacksKeymap "<leader>nh" "picker.notifications" "Show notification history")
  ];
}
