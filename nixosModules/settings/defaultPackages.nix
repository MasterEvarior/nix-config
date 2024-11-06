{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Text editor
    nano

    # Browser
    firefox

    # Modern unix
    bat
    lsd
    eza
    btop

    # Div
    file
  ];

  environment.interactiveShellInit = ''
    alias cat='bat';
    alias htop='btop';
  '';
}
