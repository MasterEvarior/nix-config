{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.java = {
    enable = lib.mkEnableOption "Java";
  };

  config = lib.mkIf config.homeModules.dev.java.enable {
    home.packages = with pkgs; [
      jetbrains.idea-ultimate
      maven
      gradle
    ];

    programs.java = {
      package = pkgs.jdk23;
      enable = true;
    };
  };
}
