{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.fzf = {
    enable = lib.mkEnableOption "fzf for fuzzy searching";
  };

  config = lib.mkIf config.homeModules.applications.fzf.enable {
    home.packages = with pkgs; [ fzf ];

    home.shellAliases = {
      ivs = "code --new-window $(fzf --preview=\"bat --color=always {}\")";
      fzf = "fzf --preview=\"bat --color=always {}\"";
    };
  };
}
