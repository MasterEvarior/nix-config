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
    ./swap.nix
    ./garbageCollection.nix
  ];

  modules.settings =
    let
      defaultTrue = lib.mkDefault true;
    in
    {
      mdns.enable = defaultTrue;
      shebang.enable = defaultTrue;
      garbageCollection.enable = defaultTrue;
      locale.enable = defaultTrue;
      unfree.enable = defaultTrue;
      bluetooth.enable = defaultTrue;
      flakes.enable = defaultTrue;
      fonts.enable = defaultTrue;
      printing.enable = defaultTrue;
      sound.enable = defaultTrue;
    };
}
