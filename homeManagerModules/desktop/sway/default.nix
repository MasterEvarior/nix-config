{
  lib,
  config,
  ...
}:

{
  options.homeModules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf config.homeModules.desktop.sway.enable {
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = true;
      config = {
        terminal = "alacrittz";

        "input type:keyboard" = {
          xkb_layout = "ch(de_nodeadkeys)";
          xkb_variant = "de";
        };

        startup = [ ];
      };
    };
  };
}
