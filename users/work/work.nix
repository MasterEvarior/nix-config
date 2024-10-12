{ ... }:

{
  users.users.work = {
    isNormalUser = true;
    name = "work";
    description = "Work account";
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  services = {
    gvfs.enable = true;
    openssh.enable = true;
    duplicity = {
      enable = true;
      frequency = null;
      targetUrl = "";
    };
  };

  home-manager.users.work = import ./home.nix;
}
