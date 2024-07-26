{ pkgs, config, lib, ... }:

{
  options = {
    modules.dev.js.enable = lib.mkEnableOption "JavaScript module";
  };

  config = lib.mkIf config.modules.dev.js.enable {
    environment.systemPackages = with pkgs; [ nodejs_22 ];
  };
}
