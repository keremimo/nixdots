{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Disable gaming/Steam for lean configuration
  programs.steam.enable = false;

  # Disable heavy services for 4GB RAM system
  virtualisation.docker.enable = false;
  systemd.services.lactd.enable = false; # AMD GPU tool not needed for Intel graphics

  networking.hostName = "sci-go";
}
