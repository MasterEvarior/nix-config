{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.opencode = {
    enable = lib.mkEnableOption "Opencode CLI";
  };

  config = lib.mkIf config.homeModules.applications.opencode.enable {
    programs.opencode = {
      enable = true;
    };
  };
}
