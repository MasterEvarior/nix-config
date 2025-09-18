{ pkgs, ... }:

let
  username = "giannin";
  avatar = ./assets/avatar.png;
in
{
  users.users."${username}" = {
    isNormalUser = true;
    name = username;
    description = "Personal account";
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
    ];

    packages = with pkgs; [
      firefox
      micro
    ];
  };

  home-manager.users.giannin = import ./home.nix;
  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/${username}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n"
    "L+ /var/lib/AccountsService/icons/${username}  -    -    -    -  ${avatar}"
  ];
}
