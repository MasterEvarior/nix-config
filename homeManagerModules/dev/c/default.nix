{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.c = {
    enable = lib.mkEnableOption "C/C++";
  };

  config = lib.mkIf config.homeModules.dev.c.enable {
    home.packages = with pkgs; [
      jetbrains.clion
      gcc
      gnumake
    ];
  };
}
