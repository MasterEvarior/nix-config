{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.git = {
    enable = lib.mkEnableOption "Git";
    userName = lib.mkOption {
      default = "";
      example = "Max";
      type = lib.types.str;
    };
    userEmail = lib.mkOption {
      default = "";
      example = "max@example.com";
      type = lib.types.str;
    };
    rebase = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether to rebase on pull";
    };
  };

  config =
    let
      conf = config.homeModules.dev.git;
    in
    lib.mkIf conf.enable {

      programs.git = {
        enable = true;
        userName = conf.userName;
        userEmail = conf.userEmail;
        aliases = {
          clear = "! clear";
          ss = "stash save";
          s = "status";
          pl = "pull";
          ps = "push";
          a = "add";
          aa = "add --all";
          amend = "commit --amend --no-edit";
          graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          cm = "commit -m";
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
