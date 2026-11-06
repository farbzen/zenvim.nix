{
  config,
  lib,
  ...
}: let
  toggleKey = "<C-,>";
in {
  options.zenvim.ai.claudecode.enable = lib.mkEnableOption "the Claude Code integration" // {default = true;};

  config = lib.mkIf config.zenvim.ai.claudecode.enable {
    plugins.claudecode = {
      enable = true;
      settings.log_level = "warn";
      settings.terminal = {
        provider = "snacks";
        snacks_win_opts = {
          position = "float";
          width = 0.9;
          height = 0.9;
          border = "rounded";
          keys.claude_hide = {
            __unkeyed-1 = toggleKey;
            __unkeyed-2 = lib.nixvim.mkRaw ''
              function(self)
                self:hide()
              end
            '';
            mode = "t";
            desc = "Hide";
          };
        };
      };
    };

    dependencies.claude-code.enable = false;

    keymaps = [
      {
        mode = "n";
        key = toggleKey;
        action = "<cmd>ClaudeCodeFocus<cr>";
        options.desc = "Toggle Claude Code";
      }
    ];
  };
}
