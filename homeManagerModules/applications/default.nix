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
        micro.enable = lib.mkDefault enableByDefault;
        libreoffice.enable = lib.mkDefault enableByDefault;
        zoxide.enable = lib.mkDefault enableByDefault;
        lsd.enable = lib.mkDefault enableByDefault;
        playerctl.enable = lib.mkDefault enableByDefault;
        utils.enable = lib.mkDefault enableByDefault;
        btop.enable = lib.mkDefault enableByDefault;
      };
    };
}
