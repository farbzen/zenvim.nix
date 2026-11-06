{
  plugins.tiny-inline-diagnostic = {
    enable = true;
    settings = {
      disabled_ft = ["neo-tree"];
      options = {
        multilines.enabled = true;
        add_messages.display_count = true;
        show_source.enabled = true;
        use_icons_from_diagnostic = true;
        overflow.padding = 8;
      };
    };
  };

  diagnostic.settings.virtual_text = false;
}
