{
  lib,
  osConfig,
  ...
}:

{
  imports = [
    ./sway
  ];

  config =
    let
      osDesktopConfig = osConfig.modules.desktop;
    in
    {
      homeModules.desktop.sway.module.enable = lib.mkDefault osDesktopConfig.sway.enable;
    };
}
