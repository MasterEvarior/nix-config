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

    programs.ssh =
      let
        mkMatchBlock =
          publicKey:
          lib.hm.dag.entryBefore [ "Host *" ] {
            identitiesOnly = true;
            identityFile = publicKey;
          };
      in
      lib.mkIf config.homeModules.applications."1password".configureSSH {
        enable = true;
        matchBlocks = {
          "webtransfer.ch" = mkMatchBlock "~/.ssh/public-keys/webtransfer.pub";
          "192.168.68.66" = mkMatchBlock "~/.ssh/public-keys/homelab_1.pub";
          "185.79.235.161" = mkMatchBlock "~/.ssh/public-keys/cloudscale.pub";
          "github.com" = mkMatchBlock "~/.ssh/public-keys/github.pub";
          "gitlab.fhnw.ch" = mkMatchBlock "~/.ssh/public-keys/gitlab_fhnw.pub";
          "gitlab.puzzle.ch" = mkMatchBlock "~/.ssh/public-keys/gitlab_puzzle.pub";
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
