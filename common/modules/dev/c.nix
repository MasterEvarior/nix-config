{ pkgs, lib, config, ... }:

{
  options = {
    dev.c.enable = lib.mkEnableOption "Enable C/C++ module";
  };

  config = lib.mkIf config.dev.c.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.clion
      gcc
      gnumake
    ];
  };
}
