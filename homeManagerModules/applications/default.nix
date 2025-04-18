{
  lib,
  config,
  ...
}:

{
  imports = [
    ./1password
    ./b2-backup
    ./bitwarden
    ./btop
    ./chromium
    ./comma
    ./cypress
    ./deja-dup
    ./dooit
    ./fastfetch
    ./fzf
    ./github-cli
    ./gitlab-cli
    ./libreoffice
    ./license-cli
    ./lsd
    ./micro
    ./ms-teams
    ./nano
    ./onedrive
    ./playerctl
    ./signal
    ./spotify
    ./treefmt
    ./utils
    ./vscode
    ./watson
    ./zellij
    ./zotero
    ./zoxide
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
      enableByDefault = lib.mkDefault config.homeModules.applications.module.enableDefaults;
    in
    {
      homeModules.applications = {
        vscode.enable = enableByDefault;
        fastfetch.enable = enableByDefault;
        "1password".enable = enableByDefault;
        spotify.enable = enableByDefault;
        comma.enable = enableByDefault;
        ms-teams.enable = enableByDefault;
        fzf.enable = enableByDefault;
        zellij.enable = enableByDefault;
        github-cli.enable = enableByDefault;
        license-cli.enable = enableByDefault;
        treefmt.enable = enableByDefault;
        micro.enable = enableByDefault;
        libreoffice.enable = enableByDefault;
        zoxide.enable = enableByDefault;
        lsd.enable = enableByDefault;
        playerctl.enable = enableByDefault;
        utils.enable = enableByDefault;
        btop.enable = enableByDefault;
      };
    };
}
