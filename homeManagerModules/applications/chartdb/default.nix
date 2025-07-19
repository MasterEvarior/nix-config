{
  lib,
  config,
  osConfig,
  ...
}:

{
  options.homeModules.applications.chartdb = {
    enable = lib.mkEnableOption "ChartDB";
    name = lib.mkOption {
      default = "chartdb-systemd-service";
      example = "chartdb-systemd-service";
      type = lib.types.str;
      description = "Name of the container";
    };
    image = lib.mkOption {
      default = "ghcr.io/chartdb/chartdb";
      example = "ghcr.io/chartdb/chartdb";
      type = lib.types.str;
      description = "The image to use";
    };
    version = lib.mkOption {
      default = "1.13.2";
      example = "latest";
      type = lib.types.str;
      description = "The version to use";
    };
    port = lib.mkOption {
      default = 1234;
      example = 8080;
      type = (lib.types.ints.between 1024 49151);
      description = "On which port the web interface should be exposed";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.chartdb;
      image = cfg.image + ":" + cfg.version;
      dockerOsConfig = osConfig.virtualisation.docker;
      dockerBin =
        (if dockerOsConfig.rootless.enable then dockerOsConfig.rootless.package else dockerOsConfig.package)
        + "/bin/docker";
    in
    lib.mkIf config.homeModules.applications.chartdb.enable {
      assertions = [
        {
          assertion = osConfig.modules.containers.enable;
          message = "Containers need to be enabled at OS level for the chartdb home manager module to work";
        }
      ];

      systemd.user = {
        enable = true;
        services = {
          chartdb = {
            Unit = {
              Description = "ChartDB Container";
            };

            Service = {
              TimeoutStartSec = 0;
              ExecStartPre = [
                "-${dockerBin} stop ${cfg.name}"
                "-${dockerBin} rm ${cfg.name}"
                "${dockerBin} pull ${image}"
              ];
              ExecStart = "${dockerBin} run --rm --name ${cfg.name} -p ${toString cfg.port}:80 ${image}";
            };

            Install = {
              WantedBy = [ "default.target" ];
            };
          };
        };
      };
    };
}
