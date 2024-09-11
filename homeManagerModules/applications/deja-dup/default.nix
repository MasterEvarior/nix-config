{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.deja-dup = {
    enable = lib.mkEnableOption "Deja-Dup";
  };

  config = lib.mkIf config.homeModules.applications.deja-dup.enable {
    home.packages = with pkgs; [ deja-dup ];
  };
}
