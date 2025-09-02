{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.harper = {
    enable = lib.mkEnableOption "Offline, privacy-first grammar checker. Fast, open-source, Rust-powered ";
  };

  config = lib.mkIf config.homeModules.applications.harper.enable {
    home.packages = with pkgs; [
      harper
    ];
  };
}
