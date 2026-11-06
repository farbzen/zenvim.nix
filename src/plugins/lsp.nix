{
  anyLanguageUses,
  lib,
  ...
}: {
  config = lib.mkIf (anyLanguageUses "lsp") {
    plugins.lspconfig.enable = true;

    lsp = {
      inlayHints.enable = true;

      keymaps = [
        {
          key = "K";
          lspBufAction = "hover";
          options.desc = "Hover";
        }
        {
          key = "<C-k>";
          lspBufAction = "signature_help";
          options.desc = "Signature Documentation";
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>lR";
        action = "<cmd>lsp restart<cr>";
        options.desc = "Restart LSP";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = lib.nixvim.mkRaw ''
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        '';
        options.desc = "Toggle LSP inlay hints";
      }
    ];
  };
}
