{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.projects.bfh = {
    enable = lib.mkEnableOption "BFH";
    vpn = lib.mkOption {
      description = "VPN configuration options";
      default = { };
      type =
        with lib.types;
        submodule {
          options = {
            package = lib.mkPackageOption pkgs "openconnect" { };
            username = lib.mkOption {
              default = "ext-brag2";
              example = "your-user";
              type = lib.types.str;
              description = "User to use to connect";
            };
            server = lib.mkOption {
              default = "vpnext.bfh.ch";
              example = "your.vpn.example.com";
              type = lib.types.str;
              description = "VPN Server to connect to";
            };
            protocol = lib.mkOption {
              default = "anyconnect";
              example = "anyconnect";
              type = lib.types.enum [
                "anyconnect"
                "nc"
                "gp"
                "pulse"
                "f5"
                "fortinet"
                "array"
              ];
              description = "Which protocol to use to connect";
            };
            os = lib.mkOption {
              default = "mac-intel";
              example = "mac-intel";
              type = lib.types.str;
              description = "Specify an OS (linux is for some reason not an option)";
            };
          };
        };
    };
    kube = lib.mkOption {
      description = "Everything todo with Kubernetes";
      default = { };
      type =
        with lib.types;
        submodule {
          options = {
            additionalContexts = lib.mkOption {
              default = [
                "k8s-test.bfh.ch"
                "k8s.bfh.ch"
              ];
              type = listOf str;
              description = "For env, there is a separate file in .kube, which needs to be set";
            };
          };
        };
    };
  };

  config =
    let
      cfg = config.homeModules.projects.bfh;
    in
    lib.mkIf config.homeModules.projects.bfh.enable {
      home = {
        shellAliases = {
          bfh-connect-vpn = "sudo ${lib.getExe pkgs.openconnect} --user=${cfg.vpn.username} --os=${cfg.vpn.os} --protocol=${cfg.vpn.protocol} --server=${cfg.vpn.server}";
          bfh-connect-ssh-tunnel = "ssh -D 9999 -q -C -N jenkins.k8s-test.bfh.ch -vvv";
        };

        packages = with pkgs; [
          keepass

          # All needed for rust-script
        ];
      };

      programs.zsh.initContent = lib.mkOrder 1000 ''
        export KUBECONFIG="${
          builtins.concatStringsSep ":" (
            map (e: "$HOME/.kube/${e}") ([ "config" ] ++ cfg.kube.additionalContexts)
          )
        }"
      '';

      homeModules.applications."1password".ssh = {
        configureSSH = true;
        additionalPublicKeys =
          let
            bfhPublicCertificate = ./assets/BFH.pub;
            bfhUser = "ext-brag2";
          in
          [
            {
              host = "ssh.esb.bfh.ch";
              user = bfhUser;
              file = bfhPublicCertificate;
            }
            {
              host = "master*.k8s.bfh.ch";
              user = bfhUser;
              proxyJump = bfhUser + "@ssh.esb.bfh.ch";
              file = bfhPublicCertificate;
              localForwards = [
                {
                  bind.port = 16443;
                  host = {
                    address = "127.1";
                    port = 6443;
                  };
                }
              ];
            }
            {
              host = "*.esb.bfh.ch *.k8s.bfh.ch !ssh.esb.bfh.ch !node1.ssh.esb.bfh.ch !node2.ssh.esb.bfh.ch";
              user = bfhUser;
              proxyJump = bfhUser + "@ssh.esb.bfh.ch";
              file = bfhPublicCertificate;
            }
            {
              host = "ssh.esb-test.bfh.ch";
              user = bfhUser;
              file = bfhPublicCertificate;
            }
            {
              host = "master*.k8s-test.bfh.ch";
              user = bfhUser;
              file = bfhPublicCertificate;
              proxyJump = bfhUser + "@ssh.esb-test.bfh.ch";
              localForwards = [
                {
                  bind.port = 16443;
                  host = {
                    address = "127.1";
                    port = 6443;
                  };
                }
              ];
            }
            {
              host = "*.esb-test.bfh.ch *.k8s-test.bfh.ch !ssh.esb-test.bfh.ch !node1.ssh.esb-test.bfh.ch !node2.ssh.esb-test.bfh.ch";
              user = bfhUser;
              proxyJump = bfhUser + "@ssh.esb-test.bfh.ch";
              file = bfhPublicCertificate;
            }
            {
              host = "*.bfh.ch !*.esb.bfh.ch !*.k8s.bfh.ch !*.esb-test.bfh.ch !*.k8s-test.bfh.ch";
              user = bfhUser;
              proxyJump = bfhUser + "@ssh.bfh.science";
              file = bfhPublicCertificate;
            }
            {
              host = "ssh.bfh.science";
              user = bfhUser;
              file = bfhPublicCertificate;
            }
          ];
      };
    };
}
