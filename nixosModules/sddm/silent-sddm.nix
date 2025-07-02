{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

{
  options.modules.displayManager.sddm.silent-sddm = {
    enable = lib.mkEnableOption "Enable the SilentSDDM theme";
    flavor = lib.mkOption {
      default = "default";
      example = "default";
      type = lib.types.enum [
        "default"
        "rei"
        "ken"
        "silvia"
        "catppuccin-latte"
        "catppuccin-frappe"
        "catppuccin-macchiato"
        "catppuccin-mocha"
      ];
      description = "Which flavor should be selected, see https://github.com/uiriansan/SilentSDDM?tab=readme-ov-file#presets";
    };
  };

  config =
    let
      sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
        theme = "rei"; # select the config of your choice
      };
    in
    lib.mkIf config.modules.displayManager.sddm.silent-sddm.enable {
      # Stolen from the README
      # https://github.com/uiriansan/SilentSDDM?tab=readme-ov-file#nixos-flake

      environment.systemPackages = [ sddm-theme ];
      qt.enable = true;
      services.displayManager.sddm = {
        package = lib.mkForce (pkgs.kdePackages.sddm); # use qt6 version of sddm
        theme = sddm-theme.pname;
        # the following changes will require sddm to be restarted to take effect correctly. It is recomend to reboot after this
        extraPackages = sddm-theme.propagatedBuildInputs;
        settings = {
          # required for styling the virtual keyboard
          General = {
            GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
            InputMethod = "qtvirtualkeyboard";
          };
        };
      };
    };
}
