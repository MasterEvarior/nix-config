{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # https://github.com/catppuccin/vscode?tab=readme-ov-file#nix-home-manager-users
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      lib = inputs.nixpkgs.lib;
      mkSystem =
        hostname:
        lib.nixosSystem {
          system = "x86_64-linux";
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
              home-manager.extraSpecialArgs = { inherit inputs; };
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
      ];
    };
}
