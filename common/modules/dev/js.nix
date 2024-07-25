{ pkgs, config, lib, ... }:

{
  options = {
    dev.js.enable = lib.mkEnableOption "Enable JavaScript module";
  };

  config = lib.mkIf config.dev.js.enable {
    environment.systemPackages = with pkgs; [ nodejs_21 ];
  };
}
