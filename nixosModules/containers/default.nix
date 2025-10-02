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
      dockerNuclearScript = pkgs.writers.writePython3 "docker-nuclear" {
        libraries = with pkgs.python3Packages; [
          rich
          docker
        ];
      } (builtins.readFile ./assets/nuclear.py);
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
        dcdd = "docker compose down && docker volume prune -f";
        dcs = "docker compose stop";
        dcv = "docker compose config --quiet";

        # docker
        dk = "docker";
        dktop = "docker stats --format ''\"table {{.Container}}	{{.Name}} {{.MemUsage}} {{.NetIO}}	{{.BlockIO}}\"";
        dkp = "docker ps";
        dke = "docker exec -it";
        dkl = "docker logs -f";
        dkrm = "docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker volume prune";
        dkvprune = "docker volue prune --force";
        dkprune = "docker container prune --force && docker image prune --force && && docker volume prune --force && docker system prune";
        dkimyeet = "docker rmi -f $(docker images -aq)"; # delete all unused images
        dknuclear = "${dockerNuclearScript}";
      };

      virtualisation.podman = {
        enable = cfg.podman.enable;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
}
