{lib, ...}: let
  disabled = {enable = lib.mkDefault false;};
in {
  zenvim = {
    languages = lib.genAttrs (lib.attrNames (import ../languages/features.nix)) (_: disabled);

    ai.claudecode = disabled;
    bufferline = disabled;
    cellularAutomaton = disabled;
    duck = disabled;
    miniMap = disabled;
    noice = disabled;
    pentatonic = disabled;
    persistence = disabled;
    tacho = disabled;
  };
}
