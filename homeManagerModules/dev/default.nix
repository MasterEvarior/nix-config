{
  lib,
  config,
  ...
}:

{
  imports = [
    ./ansible
    ./c
    ./containerization
    ./direnv
    ./git
    ./golang
    ./java
    ./js
    ./jupyter
    ./just
    ./kubernetes
    ./latex
    ./nix
    ./php
    ./python
    ./renovate
    ./terraform
    ./typst
  ];

  options.homeModules.dev.module = {
    enableDefaults = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether defaults should be enabled or not";
    };
    enableDirEnv = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to enable and setup direnv";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.module;
      enableByDefault = cfg.enableDefaults;
    in
    {
      homeModules.dev = {
        js = {
          enable = lib.mkDefault enableByDefault;
          typescript.enable = lib.mkDefault enableByDefault;
        };
        nix.enable = lib.mkDefault enableByDefault;
        typst.enable = lib.mkDefault enableByDefault;
        git.enable = lib.mkDefault enableByDefault;
        java.enable = lib.mkDefault enableByDefault;
        containerization.enable = lib.mkDefault enableByDefault;
        python.enable = lib.mkDefault enableByDefault;
        direnv.enable = lib.mkDefault enableByDefault;
        renovate.enable = lib.mkDefault enableByDefault;
      };
    };
}
