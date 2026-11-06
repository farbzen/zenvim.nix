{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.zenvim.languages.tailwind.lsp.enable {
    lsp.servers.tailwindcss = {
      enable = true;
      packageFallback = true;
    };
  };
}
