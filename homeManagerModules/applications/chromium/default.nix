{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.chromium = {
    enable = lib.mkEnableOption "Chromium";
  };

  config = lib.mkIf config.homeModules.applications.chromium.enable {
    home.packages = with pkgs; [ chromium ];

    programs.chromium = {
      enable = true;
      dictionaries = with pkgs; [ hunspellDictsChromium.de_DE ];
    };
  };
}
