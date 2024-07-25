{ lib, config, ... }:

{
  options = {
    dev.containers.enable = lib.mkEnableOption "Enable containers";
  };

  config = lib.mkIf config.dev.containers.enable {
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
