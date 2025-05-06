{ lib, ... }:

{
  imports = [
    ./bluetooth.nix
    ./locale.nix
    ./printing.nix
    ./unfree.nix
    ./flakes.nix
    ./fonts.nix
    ./defaultPackages.nix
    ./mdns.nix
    ./shebang.nix
    ./sound.nix
    ./garbageCollection.nix
  ];

  modules.settings = {
    mdns.enable = lib.mkDefault true;
    shebang.enable = lib.mkDefault true;
    garbageCollection.enable = lib.mkDefault true;
  };
}
