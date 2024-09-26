{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.grub2Theme = {
    enabled = lib.mkEnableOption "a custom grub2theme";
    resolution = lib.mkOption {
      default = "4k";
      example = "4k";
      type = lib.types.enum [
        "1080p"
        "2k"
        "4k"
        "ultrawide"
        "ultrawide2k"
      ];
      description = "The screen resolution to use for grub2.";
    };
    backgroundImage = lib.mkOption {
      example = "my/background.png";
      type = lib.types.path;
      description = "The path of the image to use for background (must be jpg or png).";
    };
  };

  config =
    let
      cfg = config.modules.grub2Theme;
    in
    lib.mkIf cfg.enabled {
      boot.loader = {
        grub.enable = true;
        grub.configurationLimit = 20;
        grub.efiSupport = true;

        # this will tell Grub that there is no need to install itself
        # because it is a UEFI boot
        # https://discourse.nixos.org/t/question-about-grub-and-nodev/37867/2
        grub.device = "nodev";

        efi.canTouchEfiVariables = true;

        # https://github.com/vinceliuice/grub2-themes/issues/190
        grub2-theme = {
          enable = true;
          theme = "stylish";
          footer = true;
          screen = cfg.resolution;
          splashImage = cfg.backgroundImage;
        };
      };

      # Updating the kernel to make it (hopefully) compatible with the Lenovo docking stations
      boot.kernelPackages = pkgs.linuxPackages_6_10;

      environment.systemPackages = with pkgs; [
        # this is needed to scale the custom background correctly
        imagemagick
      ];
    };
}
