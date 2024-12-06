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

    programs.git.aliases = {
      clean-branches = "!(gh poi protect main; gh poi protect master; gh poi protect dev; gh poi protect development; gh poi)";
    };
  };
}
