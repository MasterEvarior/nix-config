{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.dates = "daily";
  };

  environment.shellAliases = {
    dcu = "docker compose up";
    dcd = "docker compose down";
  };
}
