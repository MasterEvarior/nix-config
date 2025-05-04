{
  lib,
  osConfig,
  ...
}:

{
  imports = [
    ./sway
    ./wofi.nix
    ./dunst.nix
  ];

  config =
    let
      osDesktopConfig = osConfig.modules.desktop;
    in
    {
      homeModules.desktop.sway.enable = lib.mkDefault osDesktopConfig.sway.enable;
    };
}
