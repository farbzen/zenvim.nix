self: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.zenvim;
  configurations = self.nixvimConfigurations.${pkgs.stdenv.hostPlatform.system};
in {
  options.programs.zenvim = {
    enable = lib.mkEnableOption "zenvim, a Neovim configuration built with Nixvim";

    profile = lib.mkOption {
      type = lib.types.enum ["full" "minimal"];
      default = "full";
      description = "The zenvim profile the configuration starts from.";
    };

    settings = lib.mkOption {
      type = lib.types.deferredModule;
      default = {};
      example = lib.literalExpression ''
        {
          zenvim.languages.python.enable = true;
          zenvim.ai.claudecode.enable = false;
        }
      '';
      description = "Nixvim module applied on top of the selected profile, e.g. to toggle single `zenvim.*` options.";
    };

    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to set `EDITOR` to `nvim`.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "The resulting zenvim package.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zenvim.package =
      (configurations.${cfg.profile}.extendModules {modules = [cfg.settings];}).config.build.package;

    environment = {
      systemPackages = [cfg.package];
      variables.EDITOR = lib.mkIf cfg.defaultEditor "nvim";
    };
  };
}
