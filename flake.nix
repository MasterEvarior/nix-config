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
      hmConfiguration = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        home-manager.extraSpecialArgs = { inherit inputs; };
      };
      systemModules = configPath: [
        configPath
        inputs.grub2-themes.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        hmConfiguration
      ];
      mkSystem =
        _hostname:
        lib.nixosSystem {
          system = "${system}";
          modules = systemModules ./hosts/arrakis/configuration.nix;
        };
      mkHome =
        homePath:
        inputs.home-manager.lib.homeManagerConfiguration {
          modules = [
            homePath
          ];
        };
    in
    {
      nixosConfigurations = {
        "arrakis" = mkSystem "arrakis";
        "caladan" = mkSystem "caladan";
      };

      homeConfigurations = {
        "giannin" = mkHome ./users/giannin/home.nix;
        "work" = mkHome ./users/work/home.nix;
        "htpc" = mkHome ./users/htpc/home.nix;
      };
    };
}
