{pkgs, ...}: 

{
  users.users.work = {
    isNormalUser = true;
    name = "work";
    description = "Work account";
    useDefaultShell = true;
    extraGroups = [ "networkmanager" "wheel" "docker"];
  };

  home-manager.users.work = import ./home.nix;
}