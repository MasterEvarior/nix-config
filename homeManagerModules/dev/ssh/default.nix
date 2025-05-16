{
  lib,
  config,
  ...
}:

{
  options.homeModules.dev.ssh = {
    enable = lib.mkEnableOption "SSH";
    passwordMatchBlocks = lib.mkOption {
      default = [ ];
      example = [
        "example.com"
        "another.com"
      ];
      type = lib.types.listOf lib.types.str;
      description = "A list of hosts, that should directly be tried with passwords.";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.ssh;
    in
    lib.mkIf config.homeModules.dev.ssh.enable {
      programs.ssh =
        let
          mkPasswordMatchBlocks =
            list:
            (builtins.listToAttrs (
              lib.map (listEntry: {
                name = listEntry;
                value = (
                  lib.hm.dag.entryBefore [ "Host *" ] {
                    extraOptions = {
                      "PreferredAuthentications" = "password";
                      "PubkeyAuthentication" = "no";
                    };
                  }
                );
              }) list
            ));
        in
        {
          enable = true;
          matchBlocks = lib.mkMerge [
            (mkPasswordMatchBlocks cfg.passwordMatchBlocks)
          ];
        };
    };
}
