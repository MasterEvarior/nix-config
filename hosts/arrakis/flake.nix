{
  description = "Arrakis configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";

      # The `follows` ensures that the versions are kept consistent with
      # the current flake. It works like inheritance in OOP 
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    let 
      system = "x86_64-linux";
    in
  {

    nixosConfigurations.Arrakis = nixpkgs.lib.nixosSystem {
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
      ];
    };
  };
}
