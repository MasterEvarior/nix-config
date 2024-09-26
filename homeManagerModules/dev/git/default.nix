{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.git = {
    enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf config.homeModules.dev.git.enable {

    programs.git = {
      enable = true;
      aliases = {
        aa = "add --all";
        amend = "commit --amend --no-edit";
        graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      extraConfig = {
        pull = {
          rebase = false;
        };
      };
    };

  };
}
