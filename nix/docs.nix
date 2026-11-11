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
  revision = self.rev or "main";

  repositoryPrefix = "${self}/";

  linkDeclarationToRepository = declaration: let
    declarationPath = toString declaration;
    declarationFile =
      if lib.pathIsDirectory declarationPath
      then "${declarationPath}/default.nix"
      else declarationPath;
    subpath = lib.removePrefix repositoryPrefix declarationFile;
  in
    if lib.hasPrefix repositoryPrefix declarationPath
    then {
      name = subpath;
      url = "${repositoryUrl}/blob/${revision}/${subpath}";
    }
    else declaration;

  mkOptionsMarkdown = options:
    (nixosOptionsDoc {
      inherit options;
      transformOptions = option:
        option // {declarations = map linkDeclarationToRepository option.declarations;};
    }).optionsCommonMark;

  nixosModuleEvaluation = lib.evalModules {
    modules = [
      self.nixosModules.zenvim
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
