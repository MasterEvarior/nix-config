{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.gitlab-cli = {
    enable = lib.mkEnableOption "GitLab CLI";
  };

  config = lib.mkIf config.homeModules.applications.gitlab-cli.enable {
    home.packages = with pkgs; [
      glab
    ];
  };
}
