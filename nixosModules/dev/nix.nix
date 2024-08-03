{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    modules.dev.nix.enable = lib.mkEnableOption "Nix module";
  };

  config = lib.mkIf config.modules.dev.java.enable {
    environment.systemPackages = with pkgs; [
      nixfmt-rfc-style
      nixd
    ];

    environment.shellAliases = {
      # Update package cache for comma
      nuc = "nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'";
    };
  };
}
