{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.yaml = {
    enable = lib.mkEnableOption "YAML language servers, formatters, ...";
  };

  config = lib.mkIf config.homeModules.dev.yaml.enable {
    homeModules.applications.helix = {
      additionalPackages = with pkgs; [
        yaml-language-server
        yamllint
      ];
    };
  };
}
