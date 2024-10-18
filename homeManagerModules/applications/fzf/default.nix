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
      fzc = "result=$(fzf --select-1 --exit-0 --preview=\"bat --color=always {}\"); if [[ -d $result ]]; then code $result ; else code $(dirname $result); fi;";
      fzf = "fzf --exit-0 --preview=\"bat --color=always {}\"";
      cdf = "result=$(fzf --select-1 --exit-0 --preview=\"bat --color=always {}\"); if [[ -d $result ]]; then cd $result ; else cd $(dirname $result); fi;";
    };
  };
}
