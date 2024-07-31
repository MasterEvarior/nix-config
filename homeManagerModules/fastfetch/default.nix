{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.homeModules.fastfetch = {
    enable = lib.mkEnableOption "FastFech with custom JSON configuration";
  };

  config = lib.mkIf config.homeModules.fastfetch.enable {
    home.packages = with pkgs; [ fastfetch ];

    home.file.".config/fastfetch/config.jsonc".source = ./assets/config.jsonc;

  };
}
