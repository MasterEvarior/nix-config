{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options.homeModules.applications.spotify = {
    enable = lib.mkEnableOption "Spotify Desktop App";
  };

  config = lib.mkIf config.homeModules.applications.spotify.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };

    homeModules.applications.playerctl.additionalAliases = [
      {
        name = "spause";
        command = "playerctl -p spotify pause";
      }
      {
        name = "splay";
        command = "playerctl -p spotify play";
      }
      {
        name = "spresume";
        command = "playerctl -p spotify play";
      }
      {
        name = "spskip";
        command = "playerctl -p spotify next";
      }
      {
        name = "sprev";
        command = "playerctl -p spotify previous";
      }
    ];
  };
}
