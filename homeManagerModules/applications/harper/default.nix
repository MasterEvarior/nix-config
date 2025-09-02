{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.harper = {
    enable = lib.mkEnableOption "Offline, privacy-first grammar checker. Fast, open-source, Rust-powered ";
    dialect = lib.mkOption {
      default = "British";
      example = "British";
      type = lib.types.enum [
        "American"
        "Canadian"
        "Australian"
        "British"

      ];
      description = "Which dialect of English to check for";
    };
    isolateEnglish = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Only lint English text in mixed language documents";
    };
  };

  config =
    let
      utils = pkgs-unstable.vscode-utils;
      vscExtension = utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "harper";
          publisher = "elijah-potter";
          version = "0.61.0";
          hash = "sha256-m9PN1BZf6rLrNnX8meX2TjGx8zGLl0GgnHEgQirh9Oc=";
        };

        meta = {
          changelog = "https://github.com/Automattic/harper/releases";
          description = "The grammar checker for developers as a Visual Studio Code extension";
          downloadPage = "https://marketplace.visualstudio.com/items?itemName=elijah-potter.harper";
          homepage = "https://github.com/automattic/harper";
          license = lib.licenses.asl20;
          maintainers = [ lib.maintainers.MasterEvarior ];
        };
      };
      cfg = config.homeModules.applications.harper;
    in
    lib.mkIf config.homeModules.applications.harper.enable {
      home.packages = with pkgs-unstable; [
        harper
      ];

      homeModules.applications.vscode = {
        additionalUserSettings = {
          harper = {
            dialect = cfg.dialect;
            path = pkgs-unstable.harper + "/bin/harper-ls";
            "isolateEnglish" = cfg.isolateEnglish;
          };
        };
        additionalExtensions = [
          vscExtension
        ];
      };
    };
}
