{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.codegrab = {
    enable = lib.mkEnableOption "Interactive CLI tool for selecting and bundling code into a single, LLM-ready output file";
    package = lib.mkPackageOption pkgs-unstable "codegrab" { };
  };

  config =
    let
      cfg = config.homeModules.applications.codegrab;
    in
    lib.mkIf config.homeModules.applications.codegrab.enable {
      home.packages = [
        cfg.package
      ];

      home.shellAliases = {
        grab = "${lib.getExe cfg.package} --theme catppuccin-macchiato --icons";
      };
    };
}
