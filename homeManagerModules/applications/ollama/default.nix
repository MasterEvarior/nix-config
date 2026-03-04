{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.ollama = {
    enable = lib.mkEnableOption "Ollama";
    package = lib.mkPackageOption pkgs-unstable "ollama" { };
  };

  config =
    let
      cfg = config.homeModules.applications.ollama;
    in
    lib.mkIf config.homeModules.applications.ollama.enable {
      services.ollama = {
        enable = true;
        package = cfg.package;
      };
    };
}
