{
  lib,
  config,
  ...
}:

{
  imports = [
    ./1password
    ./act
    ./b2-backup
    ./bemoji
    ./bitwarden
    ./bruno
    ./btop
    ./chromium
    ./chartdb
    ./codesnap
    ./comma
    ./cypress
    ./deja-dup
    ./dooit
    ./fastfetch
    ./firefox
    ./flex-launcher
    ./fzf
    ./gemini-cli
    ./github-cli
    ./gitlab-cli
    ./gowall
    ./lazygit
    ./libreoffice
    ./license-cli
    ./lsd
    ./mdbook
    ./micro
    ./ms-teams
    ./nano
    ./onedrive
    ./openconnect
    ./playerctl
    ./signal
    ./spotify
    ./treefmt
    ./utils
    ./vscode
    ./watson
    ./yazi
    ./zathura
    ./zellij
    ./zen-browser
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
        firefox.enable = enableByDefault;
        "1password".enable = enableByDefault;
        spotify.enable = enableByDefault;
        comma.enable = enableByDefault;
        ms-teams.enable = enableByDefault;
        fzf.enable = enableByDefault;
        github-cli.enable = enableByDefault;
        license-cli.enable = enableByDefault;
        treefmt.enable = enableByDefault;
        micro.enable = enableByDefault;
        lazygit.enable = enableByDefault;
        libreoffice.enable = enableByDefault;
        zoxide.enable = enableByDefault;
        lsd.enable = enableByDefault;
        playerctl.enable = enableByDefault;
        utils.enable = enableByDefault;
        btop.enable = enableByDefault;
        yazi.enable = enableByDefault;
      };
    };
}
