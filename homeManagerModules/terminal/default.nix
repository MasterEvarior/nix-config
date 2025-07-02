{ config, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./oh-my-posh.nix
  ];

  options.homeModules.terminal = {
    enable = lib.mkEnableOption "shell and terminal configuration";
    terminal = lib.mkOption {
      default = "alacritty";
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
      cfg = config.homeModules.terminal;
      enableAlacritty = (cfg.terminal == "alacritty");
      enableKitty = (cfg.terminal == "kitty");
    in
    lib.mkIf config.homeModules.terminal.enable {
      assertions = [
        {
          assertion = !(enableAlacritty && enableKitty);
          message = "Can only enable one terminal at the time";
        }
      ];

      programs.zsh = {
        enable = true;
        initContent = ''
          # initContent

          # enables autocompletion and the key-based interface
          autoload -Uz compinit
          compinit
          zstyle ':completion:*' menu select

          autoload -U colors && colors

          autoload -Uz add-zsh-hook vcs_info
          setopt prompt_subst
          add-zsh-hook precmd vcs_info
          zstyle ':vcs_info:git:*' formats '%b'
        '';
      };

      homeModules.terminal = {
        oh-my-posh.enable = lib.mkDefault true;
        alacritty.enable = enableAlacritty;
      };
    };
}
