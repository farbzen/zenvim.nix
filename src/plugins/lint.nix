{
  anyLanguageUses,
  lib,
  ...
}: {
  config = lib.mkIf (anyLanguageUses "lint") {
    plugins.lint = {
      enable = true;
      autoCmd.event = ["BufWritePost" "BufReadPost" "InsertLeave"];
    };
  };
}
