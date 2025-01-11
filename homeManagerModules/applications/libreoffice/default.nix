{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.libreoffice = {
    enable = lib.mkEnableOption "Libreoffice";
  };

  config = lib.mkIf config.homeModules.applications.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice-qt
      hunspell
      hyphenDicts.de_CH
    ];
  };
}
