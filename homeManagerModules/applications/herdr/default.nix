{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.herdr = {
    enable = lib.mkEnableOption "Herdr, an agent multiplexer that lives in your terminal";
    package = lib.mkPackageOption pkgs-unstable "herdr" { };
    settings = lib.mkOption {
      type = (pkgs-unstable.formats.toml { }).type;
      default = { };
      example = {
        theme.name = "catppuccin-macchiato";
      };
      description = "Settings written to ~/.config/herdr/config.toml. See https://herdr.dev/docs/config-reference/";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.herdr;
    in
    lib.mkIf cfg.enable {
      home.packages = [ cfg.package ];

      xdg.configFile."herdr/config.toml" = lib.mkIf (cfg.settings != { }) {
        source = (pkgs-unstable.formats.toml { }).generate "herdr-config.toml" cfg.settings;
      };
    };
}
