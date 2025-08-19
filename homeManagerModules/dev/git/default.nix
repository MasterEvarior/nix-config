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
    defaultBranchName = lib.mkOption {
      default = "main";
      example = "main";
      type = lib.types.str;
      description = "How the default branch should be named when creating a new project";
    };
    delta = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to enable a better diff view";
    };
    enableConventionalCommitsHelper = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Install CGZ to help with conventional commits";
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
        aliases = rec {
          clear = "! clear";
          ss = "stash save";
          sl = "stash list";
          sa = "stash apply";
          sd = "stash drop";
          s = "status";
          pl = "pull";
          ps = "push";
          a = "add";
          aa = "add --all";
          diffn = "diff --name-status";
          amend = "commit --amend --no-edit";
          graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          cm = "commit -m";
          unstage = "reset --";
          count = ''!echo "Total commits: $(git rev-list --count HEAD)"'';
          drop = "stash drop";
          recent = "log -3";
          latest = "log -1";
          last = latest;
          hardreset = "reset --hard HEAD";
          yeet = hardreset;
        };
        extraConfig = {
          pull = {
            rebase = config.homeModules.dev.git.rebase;
          }
          // safeDirs;
          push.autoSetupRemote = true;
          init.defaultBranch = cfg.defaultBranchName;
          color.ui = true;
        };
        delta = {
          enable = cfg.delta;
          options = {
            navigate = true;
            light = false;
            side-by-side = true;
            syntax-theme = "ansi";
          };
        };
      };

      home.packages = with pkgs; [
        git-ignore
      ];
    };
}
