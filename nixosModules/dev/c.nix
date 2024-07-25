{ pkgs, lib, config, ... }:

{
  options = {
    modules.dev.c.enable = lib.mkEnableOption "C/C++ module";
  };

  config = lib.mkIf config.modules.dev.c.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.clion
      gcc
      gnumake
    ];
  };
}
