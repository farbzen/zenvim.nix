{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.zenvim.languages.docker.lsp.enable {
    lsp.servers.dockerls = {
      enable = true;
      packageFallback = true;
    };
  };
}
