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
  ];

  modules.settings = {
    mdns.enable = lib.mkDefault true;
    shebang.enable = lib.mkDefault true;
  };
}
