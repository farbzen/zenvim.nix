{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.zenvim.languages.sql.lsp.enable {
    lsp.servers.sqls = {
      enable = true;
      packageFallback = true;
    };
  };
}
