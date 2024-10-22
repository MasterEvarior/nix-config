{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.modules.terminal = {
    enable = lib.mkEnableOption "Alacritty and ZSH";
  };

  config = lib.mkIf config.modules.terminal.enable {
    environment.systemPackages = with pkgs; [ alacritty ];

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
  };
}
