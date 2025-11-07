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
        additionalExtensions = with pkgs-unstable; [
          vscode-extensions.elijah-potter.harper
        ];
      };
    };
}
