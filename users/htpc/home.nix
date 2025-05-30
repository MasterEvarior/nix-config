{
  pkgs,
  ...
}:

let
  username = "htpc";
in
{
  imports = [ ./../../homeManagerModules ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-desktop
    vlc
    firefox

    # Nix
    git
  ];

  homeModules = {
    applications = {
      module.enableDefaults = false;
      flex-launcher = {
        enable = true;
        autostart = true;
        config = ''
          [Settings]
          DefaultMenu=Main
          MaxButtons=4
          BackgroundMode=Color
          BackgroundColor=000000
          BackgroundOverlay=false
          BackgroundOverlayColor=000000
          BackgroundOverlayOpacity=50%
          IconSize=256
          IconSpacing=5%
          TitleFont=${./assets/flex-launcher/fonts/OpenSans-Regular.ttf}
          TitleFontSize=36
          TitleColor=FFFFFF
          TitleShadows=false
          TitleShadowColor=000000
          TitleOpacity=100%
          TitleOversizeMode=Shrink
          TitlePadding=20
          HighlightFillColor=FFFFFF
          HighlightFillOpacity=25%
          HighlightOutlineSize=0
          HighlightOutlineColor=0000FF
          HighlightOutlineOpacity=100%
          HighlightCornerRadius=0
          HighlightVPadding=30
          HighlightHPadding=30
          ButtonCenterline=50%
          ScrollIndicators=true
          ScrollIndicatorFillColor=FFFFFF
          ScrollIndicatorOutlineSize=0
          ScrollIndicatorOutlineColor=000000
          ScrollIndicatorOpacity=100%
          OnLaunch=Hide
          ResetOnBack=false
          MouseSelect=false
           
          [Clock]
          Enabled=false
          ShowDate=false
          Alignment=Left
          Font=${./assets/flex-launcher/fonts/SourceSansPro-Regular.ttf}
          FontSize=50
          FontColor=FFFFFF
          Shadows=false
          ShadowColor=000000
          Margin=5%
          Opacity=100%
          TimeFormat=Auto
          DateFormat=Auto
          IncludeWeekday=true
           
          [Screensaver]
          Enabled=false
          IdleTime=300
          Intensity=70%
          PauseSlideshow=true
           
          [Hotkeys]
          # Esc to quit
          Hotkey1=1B;:quit
           
          [Gamepad]
          Enabled=false
          LStickX-=:left
          LStickX+=:right
          ButtonA=:select
          ButtonB=:back
          ButtonDPadLeft=:left
          ButtonDPadRight=:right
           
          # Menu configurations
          [Main]
          Entry1=Plex;${./assets/flex-launcher/icons/plex.png};plex-desktop
          Entry2=Firefox;${./assets/flex-launcher/icons/steam.png};/usr/share/applications/steam.desktop;BigPicture
          Entry3=System;${./assets/flex-launcher/icons/system.png};:submenu System
           
          [System]
          Entry1=Shutdown;${./assets/flex-launcher/icons/system.png};:shutdown
          Entry2=Restart;${./assets/flex-launcher/icons/restart.png};:restart
          Entry3=Sleep;${./assets/flex-launcher/icons/sleep.png};:sleep
        '';
      };
    };
    dev.module.enableDefaults = false;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
