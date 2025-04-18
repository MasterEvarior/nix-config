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
  };

  config =
    let
      cfg = config.homeModules.dev.module;
      enableByDefault = lib.mkDefault cfg.enableDefaults;
    in
    {
      homeModules.dev = {
        js = {
          enable = enableByDefault;
          typescript.enable = enableByDefault;
        };
        nix.enable = enableByDefault;
        typst.enable = enableByDefault;
        git.enable = enableByDefault;
        java.enable = enableByDefault;
        containerization.enable = enableByDefault;
        python.enable = enableByDefault;
        direnv.enable = enableByDefault;
        renovate.enable = enableByDefault;
      };
    };
}
