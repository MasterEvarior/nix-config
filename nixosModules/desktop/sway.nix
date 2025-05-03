{
  lib,
  config,
  ...
}:

{
  options.modules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf config.modules.desktop.sway.enable {
    programs.sway = {
      enable = true;
      xwayland.enable = true;
    };

    # required per the wiki
    security.polkit.enable = true;
  };
}
