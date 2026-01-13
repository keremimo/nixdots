{ pkgs, ... }:
{
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.desktopManager.gnome.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "kerem";
  };

  # Workaround for GNOME autologin issues
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-disk-utility
    gnome-backgrounds
    gnome-tour
    gnome-user-docs
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];
}
