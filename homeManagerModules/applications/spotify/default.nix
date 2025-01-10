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

        enabledExtensions = with spicePkgs.extensions; [
          wikify
        ];

        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
