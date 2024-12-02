{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.github-cli = {
    enable = lib.mkEnableOption "GitHub Cli";
  };

  config = lib.mkIf config.homeModules.applications.github-cli.enable {
  
      programs.gh = {
        enable = true;

        extensions = with pkgs; [
          gh-dash
          gh-poi
        ];
      };
  };
}