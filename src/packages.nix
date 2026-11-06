{pkgs, ...}: {
  extraPackagesAfter = with pkgs; [
    fd
    gcc
    lazygit
    noto-fonts-color-emoji
    ripgrep
    tree-sitter
  ];
}
