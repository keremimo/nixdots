{ pkgs, ... }:
{
  programs.xwayland.enable = true;

  programs.hyprland.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
