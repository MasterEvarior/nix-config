{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.btop = {
    enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf config.homeModules.applications.btop.enable {
    home.packages = with pkgs; [
      btop
    ];

    home.file.".config/btop/btop.conf".source = ./assets/btop.conf;
    home.file.themes = {
      recursive = true;
      source = ./assets/themes;
      target = ".config/btop/themes/";
    };
  };
}
