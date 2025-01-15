{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.bitwarden = {
    enable = lib.mkEnableOption "Bitwarden";
    cli = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Should the CLI be installed in addition to the desktop app";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.bitwarden;
    in
    lib.mkIf config.homeModules.applications.bitwarden.enable {
      home.packages =
        with pkgs;
        [
          bitwarden-desktop
        ]
        ++ lib.optionals (cfg.cli) [ bitwarden-cli ];
    };
}
