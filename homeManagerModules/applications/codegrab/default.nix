{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.codegrab = {
    enable = lib.mkEnableOption "Interactive CLI tool for selecting and bundling code into a single, LLM-ready output file";
  };

  config = lib.mkIf config.homeModules.applications.codegrab.enable {
    home.packages = with pkgs-unstable; [
      codegrab
    ];
  };
}
