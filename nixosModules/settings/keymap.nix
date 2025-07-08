{
  lib,
  config,
  ...
}:

{
  options.modules.settings.keymap = {
    enable = lib.mkEnableOption "Keymaps";
  };

  config = lib.mkIf config.modules.settings.keymap.enable {
    console.keyMap = "sg";

    # Configure keymap in X11
    services.xserver = {
      enable = true;
      xkb.layout = "ch";
      xkb.variant = "de_nodeadkeys";
    };
  };
}
