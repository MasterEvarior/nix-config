{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Text editor
    micro

    # Browser
    firefox

    # Modern unix
    bat
    lsd
    eza
    btop
    dust

    # Div
    file
    tree
    unzip
  ];

  environment.interactiveShellInit = ''
    alias cat='bat';
    alias htop='btop';
  '';
}
