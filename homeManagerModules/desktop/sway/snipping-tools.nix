{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.snipping-tools = {
    enable = lib.mkEnableOption "Everything needed for screenshots";
  };

  config = lib.mkIf config.homeModules.desktop.sway.snipping-tools.enable {
    home.packages = with pkgs; [
      grim
      slurp
      swappy
    ];

    homeModules.desktop.sway.additionalKeybindings =
      let
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        swappy = "${pkgs.swappy}/bin/swappy";
        command = ''exec "${grim} -g $(${slurp}) - | ${swappy} -f -"'';
      in
      {
        "+Shift+p" = command;
        "+Print" = command;
      };

    home.file.".config/swappy/config".text = ''
      [Default]
      save_dir=${config.home.homeDirectory}/Pictures/swappy
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=sans-serif
      paint_mode=brush
      early_exit=false
      fill_shape=false
      auto_save=false
      custom_color=rgb(233, 12, 12)
    '';
  };
}
