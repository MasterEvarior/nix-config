{ pkgs, ... }:

{
  users.users.htpc = {
    isNormalUser = true;
    name = "HTPC";
    description = "Home Theater PC";
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      firefox
    ];
  };

  home-manager.users.htpc = import ./home.nix;
}
