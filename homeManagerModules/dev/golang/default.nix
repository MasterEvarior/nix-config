{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.golang = {
    enable = lib.mkEnableOption "Golang";
  };

  config = lib.mkIf config.homeModules.dev.golang.enable {
    home.packages = with pkgs; [
      go
      jetbrains.goland
    ];
  };

}
