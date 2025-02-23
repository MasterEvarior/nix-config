{ pkgs, ... }:

{
  users.users.giannin = {
    isNormalUser = true;
    name = "giannin";
    description = "Personal account";
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      firefox
    ];
  };

  home-manager.users.giannin = import ./home.nix;
}
