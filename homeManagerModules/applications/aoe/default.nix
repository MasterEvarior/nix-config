{
  lib,
  config,
  pkgs,
  aoe,
  ...
}:

{
  options.homeModules.applications.aoe = {
    enable = lib.mkEnableOption "Agent of Empires, a session manager for AI coding agents";
  };

  config = lib.mkIf config.homeModules.applications.aoe.enable {
    home.packages = [
      aoe
      pkgs.tmux
    ];
  };
}
