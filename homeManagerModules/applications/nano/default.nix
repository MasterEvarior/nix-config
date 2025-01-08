{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.nano = {
    enable = lib.mkEnableOption "Nano Customization";
  };

  config = lib.mkIf config.homeModules.applications.nano.enable {
    home.packages = with pkgs; [
      nano
      nanorc
    ];

    home.file.".config/nano/nanorc".text = ''
      include ${pkgs.nanorc}/share/*
    '';
  };
}
