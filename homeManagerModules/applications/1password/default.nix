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
      _1password
      _1password-gui
    ];

    programs.ssh = lib.mkIf config.homeModules.applications."1password".configureSSH {
      enable = true;
      matchBlocks = {
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
  };
}
