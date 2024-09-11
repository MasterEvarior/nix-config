{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.comma = {
    enable = lib.mkEnableOption "Comma";
  };

  config = lib.mkIf config.homeModules.comma.enable { home.packages = with pkgs; [ comma ]; };
}
