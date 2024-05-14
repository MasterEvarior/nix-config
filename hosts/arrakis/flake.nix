{
  description = "Arrakis configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let 
      system = "x86_64-linux";
    in
  {

    nixosConfigurations.Arrakis = nixpkgs.lib.nixosSystem {
      system = "${system}";
      modules = [
        ./default.nix
      ];
    };
  };
}
