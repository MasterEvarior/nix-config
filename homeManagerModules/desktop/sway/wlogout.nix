{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.wlogout = {
    enable = lib.mkEnableOption "Logout/Suspend/Restart application for wayland";
    theme = lib.mkOption {
      example = {
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
      };
      type = lib.types.attrs;
      description = "Theme";
    };
  };

  config =
    let
      theme = config.homeModules.desktop.sway.wlogout.theme;
      configDir = ".config/wlogout/";
      iconDir = "${configDir}/icons/";
      modifier = config.wayland.windowManager.sway.config.modifier;
    in
    lib.mkIf config.homeModules.desktop.sway.wlogout.enable {
      home.packages = with pkgs; [
        wlogout
      ];

      homeModules.desktop.sway.additionalKeybindings = {
        "${modifier}+Shift+e" = "exec --no-startup-id wlogout";
      };

      home.file."${configDir}layout".text = ''
        {
            "label" : "lock",
            "action" : "loginctl lock-session",
            "text" : "Lock",
            "keybind" : "l"
        }
        {
            "label" : "hibernate",
            "action" : "systemctl hibernate",
            "text" : "Hibernate",
            "keybind" : "h"
        }
        {
            "label" : "logout",
            "action" : "loginctl terminate-user $USER",
            "text" : "Logout",
            "keybind" : "e"
        }
        {
            "label" : "shutdown",
            "action" : "systemctl poweroff",
            "text" : "Shutdown",
            "keybind" : "s"
        }
        {
            "label" : "suspend",
            "action" : "systemctl suspend",
            "text" : "Suspend",
            "keybind" : "u"
        }
        {
            "label" : "reboot",
            "action" : "systemctl reboot",
            "text" : "Reboot",
            "keybind" : "r"
        }
      '';

      home.file."${configDir}style.css".text = ''
        * {
        	background-image: none;
        	box-shadow: none;
        }

        window {
        	background-color: rgba(36, 39, 58, 0.90);
        }

        button {
        	border-radius: 0;
        	border-color: ${theme.rosewater};
        	text-decoration-color: ${theme.text};
        	color: ${theme.text};
        	background-color: ${theme.mantle};
        	border-style: solid;
        	border-width: 1px;
        	background-repeat: no-repeat;
        	background-position: center;
        	background-size: 25%;
        }

        button:focus, button:active, button:hover {
        	/* 20% Overlay 2, 80% mantle */
        	background-color: rgb(53, 57, 75);
        	outline-style: none;
        }

        #lock {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/lock.svg");
        }

        #logout {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/logout.svg");
        }

        #suspend {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/suspend.svg");
        }

        #hibernate {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/hibernate.svg");
        }

        #shutdown {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/shutdown.svg");
        }

        #reboot {
            background-image: url("${config.home.homeDirectory}/.config/wlogout/icons/reboot.svg");
        }
      '';

      # Icons are copied from catppuccin GitHub and just change the fill color according to the theme
      # https://github.com/catppuccin/wlogout/tree/main/icons/wlogout/macchiato/rosewater
      home.file."${iconDir}hibernate.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><g><path d="M500,10C229.4,10,10,229.4,10,500s219.4,490,490,490s490-219.4,490-490S770.6,10,500,10z M500,885.1c-212.7,0-385.1-172.4-385.1-385.1S287.3,114.9,500,114.9S885.1,287.3,885.1,500S712.7,885.1,500,885.1z M576.5,308.7v382.4c0,42.2-34.2,76.5-76.5,76.5c-42.3,0-76.5-34.2-76.5-76.5V308.7c0-42.2,34.2-76.5,76.5-76.5C542.2,232.3,576.5,266.5,576.5,308.7z"/></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g></g>
        </svg>
      '';

      home.file."${iconDir}lock.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><g><path d="M321.8,455.5h356.4V321.8c0-49.2-17.4-91.2-52.2-126c-34.8-34.8-76.8-52.2-126-52.2c-49.2,0-91.2,17.4-126,52.2c-34.8,34.8-52.2,76.8-52.2,126L321.8,455.5L321.8,455.5z M900.9,522.3v400.9c0,18.6-6.5,34.3-19.5,47.3c-13,13-28.8,19.5-47.3,19.5H165.9c-18.6,0-34.3-6.5-47.3-19.5s-19.5-28.8-19.5-47.3V522.3c0-18.6,6.5-34.3,19.5-47.3c13-13,28.8-19.5,47.3-19.5h22.3V321.8c0-85.4,30.6-158.7,91.9-219.9C341.3,40.6,414.6,10,500,10c85.4,0,158.7,30.6,219.9,91.9c61.3,61.3,91.9,134.6,91.9,219.9v133.6h22.3c18.6,0,34.3,6.5,47.3,19.5C894.4,487.9,900.9,503.7,900.9,522.3L900.9,522.3z"/></g></g>
        </svg>
      '';

      home.file."${iconDir}logout.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><path d="M622.5,990H50.8C26.3,990,10,973.7,10,949.2V50.8C10,26.3,26.3,10,50.8,10h571.7c24.5,0,40.8,16.3,40.8,40.8v285.8c0,24.5-16.3,40.8-40.8,40.8s-40.8-16.3-40.8-40.8v-245h-490v816.7h490v-245c0-24.5,16.3-40.8,40.8-40.8s40.8,16.3,40.8,40.8v285.8C663.3,973.7,647,990,622.5,990z"/><path d="M949.2,540.8H336.7c-24.5,0-40.8-16.3-40.8-40.8c0-24.5,16.3-40.8,40.8-40.8h612.5c24.5,0,40.8,16.3,40.8,40.8C990,524.5,973.7,540.8,949.2,540.8z"/><path d="M949.2,540.8c-12.3,0-20.4-4.1-28.6-12.3L757.3,365.3c-16.3-16.3-16.3-40.8,0-57.2c16.3-16.3,40.8-16.3,57.2,0l163.3,163.3c16.3,16.3,16.3,40.8,0,57.2C969.6,536.8,961.4,540.8,949.2,540.8z"/><path d="M785.8,704.2c-12.3,0-20.4-4.1-28.6-12.3c-16.3-16.3-16.3-40.8,0-57.2l163.3-163.3c16.3-16.3,40.8-16.3,57.2,0c16.3,16.3,16.3,40.8,0,57.2L814.4,691.9C806.3,700.1,798.1,704.2,785.8,704.2z"/></g>
        </svg>
      '';

      home.file."${iconDir}reboot.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><path d="M134.6,285.6C64.9,420.7,60.1,590,137.1,723.4L42,668.5l-32,55.4c93.1,52.1,133.6,75.9,184,106.2c28.5-51.5,52.8-94.4,107.4-186.1L246,612l-53.4,92.5C65.4,502.7,167.2,200.3,398.8,126.2C638,29.3,929,223.5,931.5,481.5c19.6,236.7-208.9,443.6-439.3,416.2l-29.5,51c277.7,54.4,556.5-201.7,524.7-483.1C976.1,170.8,637.1-41.2,367.1,77.5C262.8,114.2,183.1,191.5,134.6,285.6z"/></g>
        </svg>
      '';
      home.file."${iconDir}shutdown.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><path d="M764,152.1c30.9,22,58.3,46.8,82.4,74.6c24,27.8,44.6,57.8,61.8,90.1c17.2,32.3,30.2,66.4,39.1,102.4c8.9,36,13.4,72.6,13.4,109.6c0,63.8-12.2,123.7-36.5,179.6c-24.4,55.9-57.3,104.7-98.8,146.2c-41.5,41.5-90.2,74.5-146.2,98.8C623.2,977.8,563.3,990,499.5,990c-63.1,0-122.7-12.2-178.6-36.5c-55.9-24.4-104.8-57.3-146.7-98.8c-41.9-41.5-74.8-90.2-98.8-146.2c-24-55.9-36-115.8-36-179.6c0-36.4,4.3-72.1,12.9-107.1c8.6-35,20.8-68.3,36.5-99.9c15.8-31.6,35.3-61.1,58.7-88.5c23.3-27.5,49.4-52.2,78.2-74.1c15.1-11,31.4-15.1,48.9-12.4c17.5,2.7,31.7,11.3,42.7,25.7c11,14.4,15.1,30.5,12.4,48.4c-2.7,17.8-11.3,32.3-25.7,43.2c-43.2,31.6-76.4,70.3-99.3,116.3c-23,46-34.5,95.4-34.5,148.2c0,45.3,8.6,88,25.7,128.2c17.2,40.1,40.7,75.1,70.5,105c29.9,29.9,64.9,53.5,105,71c40.1,17.5,82.9,26.3,128.2,26.3c45.3,0,88-8.7,128.2-26.3c40.1-17.5,75.1-41.2,105-71s53.5-64.9,71-105c17.5-40.1,26.3-82.9,26.3-128.2c0-53.5-12.4-104.1-37.1-151.8c-24.7-47.7-59.4-87-104-117.9c-15.1-10.3-24.2-24.4-27.3-42.2c-3.1-17.8,0.5-34.3,10.8-49.4c10.3-14.4,24.4-23.2,42.2-26.2C732.5,138.2,748.9,141.8,764,152.1L764,152.1z M499.5,531.9c-17.8,0-33.1-6.3-45.8-19c-12.7-12.7-19-28-19-45.8V75.9c0-17.8,6.3-33.3,19-46.3c12.7-13,28-19.6,45.8-19.6c18.5,0,34.1,6.5,46.8,19.6c12.7,13,19,28.5,19,46.3v391.2c0,17.8-6.3,33.1-19,45.8C533.6,525.6,518,531.9,499.5,531.9L499.5,531.9z"/></g>
        </svg>
      '';
      home.file."${iconDir}suspend.svg".text = ''
        <?xml version="1.0" encoding="utf-8"?>
        <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon -->
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg fill="${theme.rosewater}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 1000" enable-background="new 0 0 1000 1000" xml:space="preserve">
        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
        <g><path d="M500,990c-66.1,0-130.3-13-190.7-38.5c-58.4-24.7-110.8-60-155.7-105s-80.3-97.4-105-155.7C23,630.3,10,566.1,10,500c0-66.1,13-130.3,38.5-190.7c24.7-58.4,60-110.8,105-155.7c45-45,97.4-80.3,155.7-105C369.7,23,433.9,10,500,10c66.1,0,130.3,13,190.7,38.5c58.4,24.7,110.8,60,155.7,105c45,45,80.3,97.4,105,155.7C977,369.7,990,433.9,990,500c0,66.1-13,130.3-38.5,190.7c-24.7,58.4-60,110.8-105,155.7s-97.4,80.3-155.7,105C630.3,977,566.1,990,500,990z M500,79.6c-112.3,0-217.9,43.7-297.3,123.1C123.3,282.1,79.6,387.7,79.6,500s43.7,217.9,123.1,297.3c79.4,79.4,185,123.1,297.3,123.1c112.3,0,217.9-43.7,297.3-123.1c79.4-79.4,123.1-185,123.1-297.3s-43.7-217.9-123.1-297.3C717.9,123.3,612.3,79.6,500,79.6z"/><path d="M322.5,290.6h108v412h-108V290.6z"/><path d="M561.6,290.6h107.9v412H561.6V290.6z"/></g>
        </svg>
      '';
    };
}
