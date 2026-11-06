{lib, ...}: {
  autoGroups.YankHighlight.clear = true;

  autoCmd = [
    {
      event = "FileType";
      desc = "remove formatoptions";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.opt.formatoptions:remove({ "c", "r", "o" })
        end
      '';
    }
    {
      event = "BufReadPost";
      desc = "Close empty unnamed buffers once a real file is opened";
      callback = lib.nixvim.mkRaw ''
        function()
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if
              vim.api.nvim_buf_is_loaded(bufnr)
              and vim.api.nvim_buf_get_name(bufnr) == ""
              and vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == ""
            then
              local total_characters = 0

              for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
                total_characters = total_characters + #line
              end

              if total_characters == 0 then
                vim.api.nvim_buf_delete(bufnr, { force = true })
              end
            end
          end
        end
      '';
    }
    {
      event = "TextYankPost";
      group = "YankHighlight";
      pattern = "*";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
  ];

  userCommands = {
    W = {
      command = "write";
      bang = true;
    };
    Q = {
      command = "quit";
      bang = true;
    };
  };
}
