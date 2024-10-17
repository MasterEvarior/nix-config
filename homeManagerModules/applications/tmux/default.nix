{ lib, config, ... }:

{
  options.homeModules.applications.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf config.homeModules.applications.tmux.enable {
    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      clock24 = true;
      baseIndex = 1;
      mouse = true;
      shortcut = "a";
    };
  };
}
