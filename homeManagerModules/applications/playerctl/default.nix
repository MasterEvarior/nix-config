{
  lib,
  config,
  pkgs,
  ...
}:

let
  aliasTyp =
    with lib.types;
    (submodule {
      options = {
        name = lib.mkOption {
          example = "sp-play";
          type = str;
          description = "Name of the alias, which can be typed in the terminal";
        };
        command = lib.mkOption {
          example = "playerctl -p spotify play";
          type = str;
          description = "Command that should be executed";
        };
      };
    });
in
{
  options.homeModules.applications.playerctl = {
    enable = lib.mkEnableOption "PlayerCtl a CLI to control media players";
    additionalAliases =
      with lib.types;
      lib.mkOption {
        default = [ ];
        example = [
          {
            name = "sp-play";
            command = "playerctl -p spotify play";
          }
        ];
        type = listOf aliasTyp;
        description = "List of additional aliases";
      };
  };

  config =
    let
      cfg = config.homeModules.applications.playerctl;
    in
    lib.mkIf config.homeModules.applications.playerctl.enable {
      home.packages = with pkgs; [
        playerctl
      ];

      home.shellAliases =
        let
          mkAdditionalAliases =
            additionalAliases:
            builtins.listToAttrs (
              map (a: {
                name = a.name;
                value = a.command;
              }) additionalAliases
            );
        in
        lib.mkMerge [
          {
            "skip" = "playerctl next";
            "next" = "playerctl next";
            "play" = "playerctl play";
            "resume" = "playerctl play";
            "pause" = "playerctl pause";
          }
          (mkAdditionalAliases cfg.additionalAliases)
        ];
    };
}
