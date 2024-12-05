{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.openshift = {
    enable = lib.mkEnableOption "Openshift CLI and more";
  };

  config = lib.mkIf config.homeModules.dev.openshift.enable {
  
    home.packages = with pkgs; [
      ocm
      openshift
      kubectl
    ];
  };
}