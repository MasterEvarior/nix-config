{ ... }:

let
  username = "work";
  avatar = ./assets/avatar.png;
in
{
  users.users."${username}" = {
    isNormalUser = true;
    name = username;
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

  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/${username}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n"
    "L+ /var/lib/AccountsService/icons/${username}  -    -    -    -  ${avatar}"
  ];
}
