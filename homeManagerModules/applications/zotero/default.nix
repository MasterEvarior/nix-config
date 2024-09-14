{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.zotero = {
    enable = lib.mkEnableOption "Zotero";
  };

  config = lib.mkIf config.homeModules.applications.zotero.enable {
    home.packages = with pkgs; [ zotero ];
  };
}
