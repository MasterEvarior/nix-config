{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.lsd = {
    enable = lib.mkEnableOption "LSDeluxe";
  };

  config = lib.mkIf config.homeModules.applications.lsd.enable {
    home.packages = with pkgs; [
      lsd
    ];

    home.shellAliases = {
      ls = "lsd -l";
    };

    home.file.".config/lsd/config.yaml".source = ./assets/config.yaml;
    home.file.".config/lsd/colors.yaml".source = ./assets/colors.yaml;
  };
}
