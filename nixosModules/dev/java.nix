{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    modules.dev.java.enable = lib.mkEnableOption "Java module";
  };

  config = lib.mkIf config.modules.dev.java.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-ultimate
      maven
      gradle_7
    ];

    programs.java = {
      package = pkgs.jdk21;
      enable = true;
    };
  };
}
