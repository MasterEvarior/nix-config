{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options.homeModules.applications.spotify.spicetify = {
    enable = lib.mkEnableOption "Spotify customization with Spicetify";
  };

  config = lib.mkIf config.homeModules.applications.spotify.spicetify.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [ keyboardShortcut ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
