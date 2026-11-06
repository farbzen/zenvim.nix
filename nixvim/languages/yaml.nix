{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.zenvim.languages.yaml.lsp.enable {
    lsp.servers.yamlls = {
      enable = true;
      packageFallback = true;
    };
  };
}
