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
      languageServers = [
        {
          yaml-language-server = {
            command = lib.getExe pkgs.yaml-language-server;
            args = [ "--stdio" ];
          };
        }
      ];
    };
  };
}
