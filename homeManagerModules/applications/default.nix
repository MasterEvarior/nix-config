{ lib, ... }:

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
  ];

  homeModules.applications = {
    vscode.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
    "1password".enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;
    comma.enable = lib.mkDefault true;
  };
}
