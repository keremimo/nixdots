{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/services/desktop-media.nix
      ../../modules/nixos/programs/gaming.nix
      ../../modules/nixos/programs/session-switch.nix
    ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  networking.hostName = "sci-desk"; # Define your hostname.
}
