{ lib, ... }:

{
  imports = [
    ./bluetooth.nix
    ./cross-compilation.nix
    ./keymap.nix
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
      bluetooth.enable = defaultTrue;
      cross-compilation.enable = defaultTrue;
      keymap.enable = defaultTrue;
      flakes.enable = defaultTrue;
      fonts.enable = defaultTrue;
      garbageCollection.enable = defaultTrue;
      locale.enable = defaultTrue;
      mdns.enable = defaultTrue;
      printing.enable = defaultTrue;
      shebang.enable = defaultTrue;
      sound.enable = defaultTrue;
      swap.enable = defaultTrue;
      unfree.enable = defaultTrue;
    };
}
