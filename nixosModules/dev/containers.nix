{ lib, config, ... }:

{
  options = {
    modules.dev.containers.enable = lib.mkEnableOption "containers";
  };

  config = lib.mkIf config.modules.dev.containers.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "daily";
    };

    environment.shellAliases = {
      # docker compose
      dcu = "docker compose up";
      dcd = "docker compose down";
    
      # docker 
      dktop = "docker stats --format ''\"table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}''\"";
    };
  };
}
