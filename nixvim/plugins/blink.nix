{
  plugins = {
    blink-ripgrep.enable = true;

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          "<CR>" = ["select_and_accept" "fallback"];
          "<C-e>" = ["hide" "fallback"];
          "<Tab>" = ["select_next" "fallback"];
          "<S-Tab>" = ["select_prev" "fallback"];
          "<C-d>" = ["scroll_documentation_down" "fallback"];
          "<C-u>" = ["scroll_documentation_up" "fallback"];
        };
        sources = {
          default = ["lsp" "path" "snippets" "buffer" "ripgrep"];
          providers.ripgrep = {
            module = "blink-ripgrep";
            name = "Ripgrep";
            opts = {
              prefix_min_len = 3;
              context_size = 5;
              max_filesize = "1M";
              project_root_marker = ".git";
              project_root_fallback = true;
              search_casing = "--ignore-case";
              additional_rg_options = [];
              fallback_to_regex_highlighting = true;
              ignore_paths = [];
              additional_paths = [];
              debug = false;
            };
          };
        };
        fuzzy.implementation = "rust";
      };
    };
  };
}
