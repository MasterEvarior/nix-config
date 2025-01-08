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
    ./openshift
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
      enableByDefault = config.homeModules.dev.module.enableDefaults;
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
      };
    };
}
