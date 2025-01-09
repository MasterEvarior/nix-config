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
    disableSafeDirectories = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "See https://stackoverflow.com/questions/71849415/i-cannot-add-the-parent-directory-to-safe-directory-in-git";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.git;
      safeDirs = if cfg.disableSafeDirectories then { safe.directory = ''*''; } else { };
    in
    lib.mkIf cfg.enable {

      programs.git = {
        enable = true;
        userName = cfg.userName;
        userEmail = cfg.userEmail;
        aliases = {
          clear = "! clear";
          ss = "stash save";
          sl = "stash list";
          sa = "stash save";
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
          } // safeDirs;
        };
      };

      home.packages = with pkgs; [ git-ignore ];

    };
}
