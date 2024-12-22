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
  ];
}
