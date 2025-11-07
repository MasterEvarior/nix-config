{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications."1password" =
    let
      publicKeyType =
        with lib.types;
        listOf (submodule {
          options = {
            host = lib.mkOption {
              example = "example.com";
              type = lib.types.str;
              description = "Domain or IP you want to SSH key to work for";
            };
            proxyJump = lib.mkOption {
              default = null;
              example = "example@ssh.example.com";
              type = lib.types.nullOr lib.types.str;
              description = "Optional ProxyJump option";
            };
            user = lib.mkOption {
              default = null;
              example = "little-timmy";
              type = lib.types.nullOr lib.types.str;
              description = "Optional User option";
            };
            localForwards = lib.mkOption {
              type = types.listOf types.attrs;
              default = [ ];
            };
            identitiesOnly = lib.mkOption {
              default = true;
              example = false;
              type = lib.types.bool;
              description = "Specifies that ssh should only use the authentication identity explicitly configured in the ~/.ssh/config files or passed on the ssh command-line, even if ssh-agent offers more identities.";
            };
            file = lib.mkOption {
              example = ./your-key.pub;
              type = lib.types.path;
              description = "Path to your public key";
            };
          };
        });
    in
    {
      enable = lib.mkEnableOption "1Password GUI and client";
      ssh = {
        configureSSH = lib.mkOption {
          default = true;
          example = true;
          type = lib.types.bool;
          description = "Wether to a configure the SSH config for the 1Password agent";
        };
        additionalPublicKeys = lib.mkOption {
          default = [ ];
          type = publicKeyType;
          description = "List of additional public SSH keys";
        };
      };
    };

  config =
    let
      cfg = config.homeModules.applications."1password";
      getFileName = keyPath: builtins.baseNameOf (toString keyPath);
      getStablePath = keyPath: "${config.home.homeDirectory}/.ssh/public-keys/${getFileName keyPath}";
      generateHomeFileEntries =
        keysList:
        lib.listToAttrs (
          lib.map (key: {
            name = ".ssh/public-keys/${getFileName key.file}";
            value = {
              text = builtins.readFile key.file;
            };
          }) keysList
        );
    in
    lib.mkIf config.homeModules.applications."1password".enable {
      home.packages = with pkgs; [
        _1password-cli
        _1password-gui
      ];

      programs.ssh =
        let
          mkMatchBlock =
            {
              pk,
              pj ? null,
              u ? null,
              lf ? [ ],
              io,
            }:
            lib.hm.dag.entryBefore [ "Host *" ] {
              identitiesOnly = io;
              identityFile = (toString pk);
              proxyJump = pj;
              user = u;
              localForwards = lf;
            };
          convertToMatchBlocks =
            additionalKeysList:
            (builtins.listToAttrs (
              lib.map (ak: {
                name = ak.host;
                value = mkMatchBlock {
                  pk = (getStablePath ak.file);
                  pj = ak.proxyJump;
                  u = ak.user;
                  io = ak.identitiesOnly;
                  lf = ak.localForwards;
                };
              }) additionalKeysList
            ));
        in
        lib.mkIf cfg.ssh.configureSSH {
          enable = true;
          matchBlocks = lib.mkMerge [
            {
              "github.com" = mkMatchBlock {
                pk = "${config.home.homeDirectory}/.ssh/public-keys/github.pub";
                io = true;
              };
              "Host *" = {
                host = "*";
                extraOptions = {
                  "IdentityAgent" = "${config.home.homeDirectory}/.1password/agent.sock";
                };
              };
            }
            (convertToMatchBlocks cfg.ssh.additionalPublicKeys)
          ];
        };

      home.sessionVariables = lib.mkIf cfg.ssh.configureSSH {
        SSH_AUTH_SOCK = "~/.1password/agent.sock";
      };

      home.file = lib.mkIf cfg.ssh.configureSSH (
        lib.mkMerge [
          {
            ".ssh/public-keys/github.pub" = {
              text = builtins.readFile ./assets/github.pub;
            };
          }
          (generateHomeFileEntries cfg.ssh.additionalPublicKeys)
        ]
      );
    };
}
