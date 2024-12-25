{ config
, pkgs
, lib
, ...
}:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "ghostty.desktop"
        "spotify.desktop"
        "nautilus.desktop"
      ];
      enabled-extensions = [
        "paperwm@paperwm.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "status-icons@gnome-shell-extensions.gcampax.github.com"
        "space-bar@luchrioh"
        "dash-to-panel@jderose9.github.com"
        "unite@hardpixel.eu"
      ];
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>q" ];
    };

    "org/gnome/shell/extensions/unite" = {
      greyscale-tray-icons = false;
      hide-activities-button = "always";
      hide-app-menu-icon = false;
      hide-window-titlebars = "always";
      restrict-to-primary-screen = false;
      show-appmenu-button = true;
      show-desktop-name = false;
      show-legacy-tray = true;
      show-window-buttons = "never";
      show-window-title = "never";
      use-activities-text = true;
      window-buttons-placement = "first";
      window-buttons-theme = "catppuccin";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 8;
      appicon-padding = 4;
      available-monitors = [ 2 0 1 ];
      dot-position = "BOTTOM";
      hide-overview-on-startup = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = -1;
      leftbox-size = 16;
      panel-element-positions-monitors-sync = true;
      primary-monitor = 2;
      status-icon-padding = -1;
      stockgs-force-hotcorner = false;
      stockgs-panelbtn-click-only = false;
      tray-padding = -1;
      tray-size = 16;
      window-preview-title-position = "TOP";
    };
  };
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.paperwm
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
    gnomeExtensions.applications-menu
    gnomeExtensions.unite-shell
  ];
}

