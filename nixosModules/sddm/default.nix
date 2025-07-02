{
  lib,
  config,
  ...
}:

{
  imports = [
    ./catppuccin-official.nix
    ./silent-sddm.nix
  ];

  options.modules.displayManager.sddm = {
    enable = lib.mkEnableOption "SDDM theming";
    theme = lib.mkOption {
      default = "Catppuccin-Official";
      example = "Catppuccin-Official";
      type = lib.types.enum [
        "Catppuccin-Official"
        "Silent-SDDM"
      ];
      description = "Which (if any) theme to enable";
    };
  };

  config =
    let
      cfg = config.modules.displayManager.sddm;
      enableCatppuccin = cfg.theme == "Catppuccin-Official";
      enableSilent = cfg.theme == "Silent-SDDM";
    in
    lib.mkIf (config.services.displayManager.sddm.enable && cfg.enable) {
      assertions = [
        {
          assertion = !(enableCatppuccin && enableSilent);
          message = "Can only enable one SDDM theme at the time";
        }
      ];

      modules.displayManager.sddm.catppuccin-official.enable = enableCatppuccin;
      modules.displayManager.sddm.silent-sddm.enable = enableSilent;
    };
}
