{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.nix = {
    enable = lib.mkEnableOption "Nix";
  };

  config = lib.mkIf config.homeModules.dev.nix.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nixd
    ];

    home.shellAliases = {
      # Update package cache for comma
      nuc = "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";

      # Update a flake
      nuf = "nix flake update";

      # Apply current config
      nrs = "sudo nixos-rebuild --flake . switch";
    };

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
    ];
  };
}
