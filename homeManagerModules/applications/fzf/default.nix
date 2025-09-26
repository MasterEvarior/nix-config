{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.applications.fzf = {
    enable = lib.mkEnableOption "fzf for fuzzy searching";
  };

  config =
    let
      isDefaultShell = shellPkg: (osConfig.users.defaultUserShell == shellPkg);
    in
    lib.mkIf config.homeModules.applications.fzf.enable {
      home.packages = with pkgs; [ fzf ];

      home.shellAliases = {
        fzc = "result=$(fzf --select-1 --exit-0 --preview=\"bat --color=always {}\"); if [[ -d $result ]]; then code $result ; else code $(dirname $result); fi;";
        fzf = "fzf --exit-0 --preview=\"bat --color=always {}\"";
        cdf = "result=$(fzf --select-1 --exit-0 --preview=\"bat --color=always {}\"); if [[ -d $result ]]; then cd $result ; else cd $(dirname $result); fi;";
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = isDefaultShell pkgs.zsh;
        enableBashIntegration = isDefaultShell pkgs.bash;
        enableFishIntegration = isDefaultShell pkgs.fish;
      };

      # this sets the theme
      # https://github.com/catppuccin/fzf
      programs.zsh.initContent = "export FZF_DEFAULT_OPTS=\" --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi\"";
    };
}
