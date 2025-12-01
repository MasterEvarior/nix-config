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
    rerere = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Enable the 'reuse recorded resolution' feature";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.git;
      safeDirs = if cfg.disableSafeDirectories then { safe.directory = ''*''; } else { };
      ccScript = pkgs.writers.writePython3 "git-cc-script" {
        libraries = with pkgs.python3Packages; [
          questionary
        ];
      } (builtins.readFile ./assets/conventional-commits.py);
    in
    lib.mkIf cfg.enable {

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = cfg.userName;
            email = cfg.userEmail;
          };

          pull = {
            rebase = config.homeModules.dev.git.rebase;
          }
          // safeDirs;

          push.autoSetupRemote = true;
          init.defaultBranch = cfg.defaultBranchName;
          color.ui = true;
          rerere.enabled = cfg.rerere;

          alias = rec {
            clear = "! clear";
            diffn = "diff --name-status";
            unstage = "reset --";
            hardreset = "reset --hard HEAD";
            yeet = hardreset;

            # Stash
            ss = "stash save";
            sl = "stash list";
            sa = "stash apply";
            sd = "stash drop";
            s = "status";
            drop = "stash drop";

            # Switch
            sw = "switch";
            swc = "switch --create";

            # Push & Pull
            pl = "pull";
            plr = "pull --rebase";
            ps = "push";
            psf = "push --force";
            psfwl = "push --force-with-lease=";
            a = "add";
            aa = "add --all";

            # Commit
            amend = "commit --amend --no-edit";
            cm = "commit -m";
            cc = "!${ccScript}";

            # Log
            count = ''!echo "Total commits: $(git rev-list --count HEAD)"'';
            recent = "log -3";
            latest = "log -1";
            last = latest;
            graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

            # Rebase
            rb = "!git fetch origin && git rebase $(git symbolic-ref refs/remotes/origin/HEAD --short)";
            rbb = "!f() { git rebase origin/$1; }; f";
            rbc = "rebase --continue";
            rbs = "rebase --skip";
            rba = "rebase --abort";
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
      };

      home.packages = with pkgs; [
        git-ignore
      ];
    };
}
