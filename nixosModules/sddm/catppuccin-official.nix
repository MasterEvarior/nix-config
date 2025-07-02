{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.displayManager.sddm.catppuccin-official = {
    enable = lib.mkEnableOption "Enable the official Catppuccin theme";
    flavor = lib.mkOption {
      default = "mocha";
      example = "mocha";
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      description = "Change the flavor of catppuccin";
    };
    wallpaper = lib.mkOption {
      example = ./your/wallpaper;
      type = lib.types.path;
      description = "Path to your wallpaper";
    };
    loginBackground = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
    };
  };

  config =
    let
      cfg = config.modules.displayManager.sddm.catppuccin-official;
    in
    lib.mkIf config.modules.displayManager.sddm.catppuccin-official.enable {
      environment.systemPackages = [
        (pkgs.catppuccin-sddm.override {
          flavor = cfg.flavor;
          background = "${cfg.wallpaper}";
          loginBackground = cfg.loginBackground;
        })
      ];

      services.displayManager.sddm = {
        theme = "catppuccin-mocha";
      };
    };
}
