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
      hmExtraSpecialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations = {
        "arrakis" = lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/arrakis/configuration.nix

            inputs.grub2-themes.nixosModules.default
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
              home-manager.extraSpecialArgs = hmExtraSpecialArgs;
            }
          ];
        };

        "caladan" = lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/caladan/configuration.nix

            inputs.grub2-themes.nixosModules.default
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
              ];
              home-manager.extraSpecialArgs = hmExtraSpecialArgs;
            }
          ];
        };
      };

      homeConfigurations = {
        "giannin" = inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            ./users/giannin/home.nix
          ];
        };
        "work" = inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            ./users/work/home.nix
          ];
        };
      };
    };
}
