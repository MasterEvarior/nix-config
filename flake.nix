{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";

      # The `follows` ensures that the versions are kept consistent with
      # the current flake. It works like inheritance in OOP 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # https://github.com/catppuccin/vscode?tab=readme-ov-file#nix-home-manager-users
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      grub2-themes,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = (nixpkgs.legacyPackages.${system}.extend inputs.catppuccin-vsc.overlays.default);
    in
    {
      nixosConfigurations = {
        "arrakis" = lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/arrakis/configuration.nix
            grub2-themes.nixosModules.default

            # idk what this does :(
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

        "caladan" = lib.nixosSystem {
          system = "${system}";
          modules = [
            ./hosts/caladan/configuration.nix
            grub2-themes.nixosModules.default

            # idk what this does :(
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };

      homeConfigurations = {
        "giannin" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/giannin/home.nix ];
        };
        "work" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/work/home.nix ];
        };
      };
    };
}
