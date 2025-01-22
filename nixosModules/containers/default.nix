{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    modules.containers.enable = lib.mkEnableOption "Containerization";
    modules.containers.docker = {
      rootless = lib.mkOption {
        default = false;
        example = false;
        type = lib.types.bool;
        description = "Wether or not to use Docker rootless. This needs a restart afterwards.";
      };
    };
    modules.containers.podman = {
      enable = lib.mkEnableOption "Wether to enable Podman or not";
    };
  };

  config =
    let
      cfg = config.modules.containers;
    in
    lib.mkIf config.modules.containers.enable {
      virtualisation.docker = {
        enable = true;
        autoPrune.enable = true;
        autoPrune.dates = "daily";
        rootless = {
          enable = config.modules.containers.docker.rootless;
          setSocketVariable = config.modules.containers.docker.rootless;
        };
      };

      environment.systemPackages =
        with pkgs;
        [
          docker-sbom
          docker-buildx
        ]
        ++ lib.lists.optionals (cfg.podman.enable) [
          podman-compose
        ];

      environment.shellAliases = {
        # docker compose
        dcu = "docker compose up";
        dcd = "docker compose down";
        dcs = "docker compose stop";
        dcv = "docker compose config --quiet";

        # docker
        dktop = "docker stats --format ''\"table {{.Container}}	{{.Name}}	{{.CPUPerc}}  {{.MemPerc}}	{{.NetIO}}	{{.BlockIO}}\"";
        dkprune = "docker container prune --force && docker image prune --force";
        dkimyeet = "docker rmi -f $(docker images -aq)"; # delete all unused images
      };

      virtualisation.podman = {
        enable = cfg.podman.enable;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
}
