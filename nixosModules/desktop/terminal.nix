{pkgs, config, lib, ...}: 

{
  options.modules.desktop.terminal = {
    enable = lib.mkEnableOption "a customized terminal and shell";
  };

  config = lib.mkIf config.modules.desktop.terminal.enable {
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
  };
}