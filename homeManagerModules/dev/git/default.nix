{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.git = {
    enable = lib.mkEnableOption "Git";
    rebase = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether to rebase on pull";
    };
  };

  config = lib.mkIf config.homeModules.dev.git.enable {

    programs.git = {
      enable = true;
      aliases = {
        clear = "! clear";
        ss = "stash save";
        s = "status";
        a = "add";
        aa = "add --all";
        amend = "commit --amend --no-edit";
        graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      extraConfig = {
        pull = {
          rebase = config.homeModules.dev.git.rebase;
        };
      };
    };

    home.packages = with pkgs; [ git-ignore ];

  };
}
