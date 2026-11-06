{
  config,
  lib,
  ...
}: let
  languageFeatures = import ./features.nix;

  featureDescriptions = {
    lsp = "language server";
    format = "formatter";
    lint = "linter";
    dap = "debug adapter";
    test = "test adapter";
    render = "in-buffer rendering";
  };

  mkLanguageOptions = language: features:
    {
      enable = lib.mkEnableOption "support for ${language}" // {default = true;};
    }
    // lib.genAttrs features (feature: {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.zenvim.languages.${language}.enable;
        defaultText = lib.literalExpression "config.zenvim.languages.${language}.enable";
        description = "Whether to enable the ${featureDescriptions.${feature}} for ${language}.";
      };
    });
in {
  imports = map (language: ./${language}.nix) (lib.attrNames languageFeatures);

  options.zenvim.languages = lib.mapAttrs mkLanguageOptions languageFeatures;

  config._module.args.anyLanguageUses = feature:
    lib.any (language: language.${feature}.enable or false) (lib.attrValues config.zenvim.languages);
}
