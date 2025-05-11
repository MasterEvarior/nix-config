{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.settings.fonts = {
    enable = lib.mkEnableOption "Fonts";
  };

  config = lib.mkIf config.modules.settings.fonts.enable {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerdfonts
      cascadia-code

      # Waybar
      font-awesome
    ];
  };
}
