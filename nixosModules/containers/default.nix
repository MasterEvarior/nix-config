{ lib, config, ... }:

{
  options = {
    modules.containers.enable = lib.mkEnableOption "Containerization with Docker";
  };

  config = lib.mkIf config.modules.containers.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "daily";
    };

    environment.shellAliases = {
      # docker compose
      dcu = "docker compose up";
      dcd = "docker compose down";
      dcs = "docker compose stop";
      dcv = "docker compose config --quiet";

      # docker 
      dktop = "docker stats --format ''\"table {{.Container}}	{{.Name}}	{{.CPUPerc}}  {{.MemPerc}}	{{.NetIO}}	{{.BlockIO}}''\"";
      dkimyeet = "docker rmi -f $(docker images -aq)"; # delete all unused images
    };
  };
}
