{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.modules.terminal = {
    enable = lib.mkEnableOption "Terminal and ZSH";
    terminal = lib.mkOption {
      default = "kitty";
      example = "alacritty";
      type = lib.types.enum [
        "alacritty"
        "kitty"
      ];
      description = "Which terminal to use";
    };
  };

  config =
    let
      cfg = config.modules.terminal;
      package = if cfg.terminal == "alacritty" then pkgs.alacritty else pkgs.kitty;
    in
    lib.mkIf config.modules.terminal.enable {
      environment.systemPackages = [ package ];

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
