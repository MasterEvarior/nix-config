{pkgs, ...}: 

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -hl";
      lll = "ls -ahl";
    };
  };

  users.defaultUserShell = pkgs.zsh;
}