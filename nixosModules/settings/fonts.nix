{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.settings.fonts = {
    enable = lib.mkEnableOption "Fonts";
  };

  config =
    let
      allNerdfonts = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    in
    lib.mkIf config.modules.settings.fonts.enable {
      fonts = {
        fontDir.enable = true;
        packages =
          with pkgs;
          [
            jetbrains-mono
            cascadia-code
            libertine
          ]
          ++ allNerdfonts;
      };
    };
}
