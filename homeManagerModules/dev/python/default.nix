{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.python = {
    enable = lib.mkEnableOption "Python";
    additionalPackages = lib.mkOption {
      default = [ ];
      example = [
        pkgs.python311Packages.pip
        pkgs.python311Packages.ipykernel
      ];
      type = lib.types.listOf lib.types.package;
      description = "A list of packages you want to install additionally";
    };
  };

  config = lib.mkIf config.homeModules.dev.python.enable {
    home.packages = with pkgs; [
      (python3.withPackages (
        pythonPkgs: with pythonPkgs; config.homeModules.dev.python.additionalPackages
      ))
    ];
  };
}
