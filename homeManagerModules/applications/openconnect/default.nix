{
  lib,
  config,
  inputs,
  ...
}:

{
  options.homeModules.applications.openconnect = {
    enable = lib.mkEnableOption "Open Connect VPN Client";
    aliases =
      with lib.types;
      lib.mkOption {
        default = [ ];
        example = [
          {
            name = "fhnw";
            server = "vpn.fhnw.ch";
            always-display-browser = true;
          }
        ];
        type = listOf (submodule {
          options = {
            name = lib.mkOption {
              example = "fhnw";
              type = strMatching "^[a-z]+$";
              description = "Name to concat to an alias, must be lowercase without spaces.";
            };
            server = lib.mkOption {
              example = "vpn.fhnw.ch";
              type = strMatching "^[a-z0-9\.]+$";
              description = "URL to connect to, should not include anything like 'https://'";
            };
            always-display-browser = lib.mkOption {
              default = true;
              example = true;
              type = lib.types.bool;
              description = "Wether or not to display the browser, regardless if it is necessary or not.";
            };
          };
        });
        description = "Additional aliases that should be created for VPNs, to make the login more convenient";
      };
  };

  config =
    let
      cfg = config.homeModules.applications.openconnect;
      package = inputs.openconnect-sso.packages.x86_64-linux.default; # https://github.com/vlaci/openconnect-sso/pull/152
      createAliases =
        with lib;
        input:
        listToAttrs (
          map (
            a:
            attrsets.nameValuePair "vpn-${a.name}" (
              "${package}/bin/openconnect-sso -s ${a.server} "
              + (if a.always-display-browser then "--browser-display-mode shown" else "")
            )
          ) input
        );
    in
    lib.mkIf config.homeModules.applications.openconnect.enable {
      home.packages = [
        package
      ];

      home.shellAliases = createAliases cfg.aliases;
    };
}
