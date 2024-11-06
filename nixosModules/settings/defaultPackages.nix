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
    htop
  ];

  environment.interactiveShellInit = ''
    alias ls='lsd'
    alias cat='bat'
    alias htop='btop'
  '';
}
