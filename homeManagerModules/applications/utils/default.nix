{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.utils = {
    enable = lib.mkEnableOption "Utility tools";
  };

  config = lib.mkIf config.homeModules.applications.utils.enable {
    home.packages = with pkgs; [
      # Documents
      pandoc
      poppler_utils

      # Network
      wget
      curl
    ];

    home.shellAliases = {
      "pdftopng" = "pdftoppm -singlefile -png -f ";
    };
  };
}
