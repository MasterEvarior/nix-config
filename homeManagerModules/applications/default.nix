{ lib, config, ... }:

{
  imports = [
    ./vscode
    ./fastfetch
    ./dooit
    ./deja-dup
    ./cypress
    ./comma
    ./onedrive
    ./1password
    ./spotify
    ./zotero
    ./chromium
    ./watson
    ./ms-teams
    ./zellij
    ./fzf
    ./github-cli
    ./signal
    ./license-cli
    ./treefmt
    ./b2-backup
    ./nano
  ];

  options.homeModules.applications.module = {
    enableDefaults = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether defaults should be enabled or not";
    };
  };

  config =
    let
      enableByDefault = config.homeModules.applications.module.enableDefaults;
    in
    {
      homeModules.applications = {
        vscode.enable = lib.mkDefault enableByDefault;
        fastfetch.enable = lib.mkDefault enableByDefault;
        "1password".enable = lib.mkDefault enableByDefault;
        spotify.enable = lib.mkDefault enableByDefault;
        comma.enable = lib.mkDefault enableByDefault;
        ms-teams.enable = lib.mkDefault enableByDefault;
        fzf.enable = lib.mkDefault enableByDefault;
        zellij.enable = lib.mkDefault enableByDefault;
        github-cli.enable = lib.mkDefault enableByDefault;
        license-cli.enable = lib.mkDefault enableByDefault;
        treefmt.enable = lib.mkDefault enableByDefault;
        nano.enable = lib.mkDefault enableByDefault;
      };
    };
}
