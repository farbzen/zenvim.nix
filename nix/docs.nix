{
  self,
  nixvimConfiguration,
  lib,
  pkgs,
  stdenvNoCC,
  mdbook,
  nixosOptionsDoc,
}: let
  repositoryUrl = "https://github.com/farbzen/zenvim.nix";

  linkDeclarationToRepository = declaration: let
    subpath = lib.removePrefix "${self}/" (toString declaration);
  in {
    name = subpath;
    url = "${repositoryUrl}/blob/main/${subpath}";
  };

  mkOptionsMarkdown = options:
    (nixosOptionsDoc {
      inherit options;
      transformOptions = option:
        option // {declarations = map linkDeclarationToRepository option.declarations;};
    }).optionsCommonMark;

  nixosModuleEvaluation = lib.evalModules {
    modules = [
      (import ../modules/nixos.nix self)
      {
        _module = {
          args.pkgs = pkgs;
          check = false;
        };
      }
    ];
  };

  nixvimOptionsMarkdown = mkOptionsMarkdown {inherit (nixvimConfiguration.options) zenvim;};
  nixosOptionsMarkdown = mkOptionsMarkdown {inherit (nixosModuleEvaluation.options) programs;};
in
  stdenvNoCC.mkDerivation {
    pname = "zenvim-docs";
    version = lib.trim (builtins.readFile ../version);

    src = lib.fileset.toSource {
      root = ../.;
      fileset = lib.fileset.unions [
        ../book.toml
        ../docs
        ../CHANGELOG.md
      ];
    };

    nativeBuildInputs = [mdbook];

    buildPhase = ''
      runHook preBuild

      mkdir -p docs/reference
      {
        echo "# Nixvim options"
        echo
        echo "Generated from the option declarations of the \`full\` profile."
        echo
        cat ${nixvimOptionsMarkdown}
      } > docs/reference/nixvim-options.md
      {
        echo "# NixOS options"
        echo
        echo "Generated from the option declarations of \`nixosModules.zenvim\`."
        echo
        cat ${nixosOptionsMarkdown}
      } > docs/reference/nixos-options.md

      mdbook build --dest-dir "$out"

      runHook postBuild
    '';

    dontInstall = true;
  }
