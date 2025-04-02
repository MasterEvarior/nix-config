{ lib, config, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
    ./nix
    ./typst
    ./jupyter
    ./git
    ./terraform
    ./java
    ./python
    ./kubernetes
    ./just
    ./php
    ./latex
    ./containerization
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
      };

      programs.direnv = {
        enable = cfg.enableDirEnv;
        enableZshIntegration = cfg.enableDirEnv;
        nix-direnv.enable = cfg.enableDirEnv;
      };
    };
}
