{
  description = "zenvim – a Neovim configuration built with Nixvim";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.nixvim.flakeModules.default];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };

      flake = rec {
        nixvimModules = {
          full = ./profiles/full.nix;
          minimal = ./profiles/minimal.nix;

          default = nixvimModules.full;
        };

        nixosModules = {
          zenvim = import ./modules/nixos.nix self;

          default = nixosModules.zenvim;
        };
      };

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: let
        mkConfiguration = profileModules:
          inputs.nixvim.lib.evalNixvim {
            inherit system;
            modules =
              [
                self.nixvimModules.default
                {nixpkgs.source = inputs.nixpkgs;}
              ]
              ++ profileModules;
          };
      in {
        formatter = pkgs.alejandra;

        packages.docs = pkgs.callPackage ./nix/docs.nix {
          inherit self;
          nixvimConfiguration = config.nixvimConfigurations.full;
        };

        nixvimConfigurations = rec {
          full = mkConfiguration [];
          minimal = mkConfiguration [self.nixvimModules.minimal];

          default = full;
        };
      };
    };
}
