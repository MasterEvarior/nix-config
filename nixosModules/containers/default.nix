{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    modules.containers.enable = lib.mkEnableOption "Containerization with Docker";
    modules.containers.rootless = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "Wether or not to use Docker rootless. This needs a restart afterwards.";
    };
  };

  config = lib.mkIf config.modules.containers.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "daily";
      rootless = {
        enable = config.modules.containers.rootless;
        setSocketVariable = config.modules.containers.rootless;
      };
    };

    environment.systemPackages = with pkgs; [
      docker-sbom
      docker-buildx
    ];

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
