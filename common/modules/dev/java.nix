{ pkgs, lib, config, ... }:

{
  options = {
    dev.java.enable = lib.mkEnableOption "Enable Java module";
  };

  config = lib.mkIf config.dev.java.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-ultimate
      maven
      gradle_7
    ];

    programs.java = {
      package=pkgs.jdk21;
      enable=true;
    };
  };
}
