{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Connect to school VPN
    openconnect-sso = {
      url = "github:ThinkChaos/openconnect-sso/fix/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret Managment with SOPS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-sops-secrets = {
      url = "git+ssh://git@github.com/MasterEvarior/nix-secrets?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      lib = inputs.nixpkgs.lib;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      mkSystem =
        hostname:
        lib.nixosSystem {
          system = system;
          modules = [
            (./. + "/hosts/${hostname}/configuration.nix")
            inputs.grub2-themes.nixosModules.default
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = ".hm.backup";
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.spicetify-nix.homeManagerModules.default
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit pkgs-unstable;
              };
            }
          ];
        };
      mkSystems =
        hostnames:
        builtins.listToAttrs (
          map (h: {
            name = h;
            value = (mkSystem h);
          }) hostnames
        );
    in
    {
      nixosConfigurations = mkSystems [
        "arrakis"
        "caladan"
        "gammu"
      ];
    };
}
