{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.deja-dup = {
    enable = lib.mkEnableOption "Deja-Dup";
  };

  config = lib.mkIf config.homeModules.deja-dup.enable {
    home.packages = with pkgs; [ deja-dup ];
  };
}