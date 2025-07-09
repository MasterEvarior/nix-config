{
  lib,
  config,
  pkgs,
  ...
}:

let
  shareType =
    with lib.types;
    (submodule {
      options = {
        path = lib.mkOption {
          example = "/tower/movies";
          type = lib.types.strMatching "^(\/[a-z]+)+$";
          description = "Path the share should be mounted under. Needs to start with a '/' and be a valid file path";
        };
        source = lib.mkOption {
          example = "//10.0.0.1/movies";
          type = lib.types.strMatching "^\/\/[a-zA-Z0-9\.]+(\/[a-zA-Z0-9\.]+)*$";
          description = "Source for the SMB/Samba/CIFS server";
        };
        fsType = lib.mkOption {
          default = "cifs";
          example = "cifs";
          type = lib.types.enum [
            "cifs"
          ];
          description = "Which file system should be mounted";
        };
      };
    });
  mkShare =
    s:
    builtins.listToAttrs [
      {
        name = "/mnt/share" + s.path;
        value = {
          device = s.source;
          fsType = s.fsType;
          options =
            let
              # this line prevents hanging on network split
              automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
            in
            [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
        };
      }
    ];
in
{
  options.modules.smb = {
    enable = lib.mkEnableOption "SMB/Samba/CIFS";
    shares = lib.mkOption {
      default = [ ];
      example = {
        path = "/tower/movies";
        source = "//10.0.0.1/movies";
        fsType = "cifs";
      };
      type = lib.types.listOf shareType;
      description = "List of shares to mount";
    };
  };

  config =
    let
      cfg = config.modules.smb;
    in
    lib.mkIf config.modules.smb.enable {
      environment.systemPackages = [ pkgs.cifs-utils ];
      fileSystems = lib.foldl' (a: b: a // b) { } (map (s: mkShare s) cfg.shares);
    };
}
