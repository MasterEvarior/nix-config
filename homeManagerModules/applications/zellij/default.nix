{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.zellij = {
    enable = lib.mkEnableOption "Zellij";
  };

  config = lib.mkIf config.homeModules.applications.zellij.enable {
    home.packages = with pkgs; [ zellij ];

    home.file.".config/zellij/config.kdl".source = ./assets/config.kdl;
  };
}
