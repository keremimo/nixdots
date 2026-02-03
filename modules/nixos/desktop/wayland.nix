{ pkgs, config, ... }:
{
  programs.xwayland.enable = true;

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "*";
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  # Fix portal discovery for Hyprland
  systemd.user.services.xdg-desktop-portal.serviceConfig = {
    Environment = "NIX_XDG_DESKTOP_PORTAL_DIR=${config.system.path}/share/xdg-desktop-portal/portals";
  };
}
