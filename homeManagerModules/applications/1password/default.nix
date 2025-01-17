{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications."1password" = {
    enable = lib.mkEnableOption "1Password GUI and client";
    configureSSH = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether to a configure the SSH config for the 1Password agent";
    };
  };

  config = lib.mkIf config.homeModules.applications."1password".enable {
    home.packages = with pkgs; [
      _1password-cli
      _1password-gui
    ];

    programs.ssh = lib.mkIf config.homeModules.applications."1password".configureSSH {
      enable = true;
      matchBlocks = {
        "192.168.68.66" = lib.hm.dag.entryBefore [ "Host *" ] {
          identitiesOnly = true;
          identityFile = "~/.ssh/public-keys/homelab_1.pub";
        };
        "185.79.235.161" = lib.hm.dag.entryBefore [ "Host *" ] {
          identitiesOnly = true;
          identityFile = "~/.ssh/public-keys/cloudscale.pub";
        };
        "github.com" = lib.hm.dag.entryBefore [ "Host *" ] {
          identitiesOnly = true;
          identityFile = "~/.ssh/public-keys/github.pub";
        };
        "gitlab.fhnw.ch" = lib.hm.dag.entryBefore [ "Host *" ] {
          identitiesOnly = true;
          identityFile = "~/.ssh/public-keys/gitlab_fhnw.pub";
        };
        "gitlab.puzzle.ch" = lib.hm.dag.entryBefore [ "Host *" ] {
          identitiesOnly = true;
          identityFile = "~/.ssh/public-keys/gitlab_puzzle.pub";
        };
        "Host *" = {
          host = "*";
          extraOptions = {
            "IdentityAgent" = "~/.1password/agent.sock";
          };
        };
      };
    };

    home.sessionVariables = lib.mkIf config.homeModules.applications."1password".configureSSH {
      SSH_AUTH_SOCK = "~/.1password/agent.sock";
    };

    home.file.publicKeys = lib.mkIf config.homeModules.applications."1password".configureSSH {
      recursive = true;
      source = ./assets;
      target = ".ssh/public-keys";
    };
  };
}
