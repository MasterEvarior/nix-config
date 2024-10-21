{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.signal = {
    enable = lib.mkEnableOption "Signal Desktop Client";
  };

  config = lib.mkIf config.homeModules.applications.signal.enable {
    home.packages = with pkgs; [ signal-desktop ];
  };
}
