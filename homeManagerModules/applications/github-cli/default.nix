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

    home.file.".config/gh-dash/config.yml".source = ./assets/dash/config.yml;

    programs.git.aliases = {
      clean-branches = "!(gh poi protect main; gh poi protect master; gh poi protect dev; gh poi protect development; gh poi)";
      dash = "!(gh dash)";
      workflow-status = "!(gh run list --limit 10)";
      workflow-status-monitor = "!(while true; do gh run list --limit 10; sleep 3; clear; done)";
      pr-to-review = "!(gh pr list --search 'is:open user-review-requested:@me')";
      pr-for-dependency-upgrades = "!(gh pr list --search 'is:open Update in:title')";
      pr-list = "!(gh pr list)";
    };
  };
}
