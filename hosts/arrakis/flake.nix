{
  description = "Arrakis configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";

      # The `follows` ensures that the versions are kept consistent with
      # the current flake. It works like inheritance in OOP 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, grub2-themes, ... }: 
    let 
      system = "x86_64-linux";
    in
  {

    nixosConfigurations.arrakis = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [
        ./configuration.nix
        

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users = {
            work = import ../../users/work/home.nix;
          };
        
        }

        grub2-themes.nixosModules.default
      ];
    };
  };
}
