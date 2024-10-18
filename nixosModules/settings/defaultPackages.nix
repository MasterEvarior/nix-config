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

    # Div
    file
    htop
  ];

  environment.interactiveShellInit = ''
    alias ls='lsd'
    alias cat='bat'
  '';
}
