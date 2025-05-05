{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.gowall = {
    enable = lib.mkEnableOption "Gowall";
  };

  config = lib.mkIf config.homeModules.applications.gowall.enable {
    home.packages = with pkgs; [
      gowall

      # https://achno.github.io/gowall-docs/imageUpscaling#warning--known-issues
      realesrgan-ncnn-vulkan
    ];

    home.file.".config/gowall/config.yml".source = ./assets/config.yml;
  };
}
