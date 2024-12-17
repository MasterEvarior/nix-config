{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.js.react = {
    enable = lib.mkEnableOption "React";
  };

  config = lib.mkIf config.homeModules.dev.js.react.enable {
    home.packages = with pkgs; [
      create-react-app
    ];
  };
}
