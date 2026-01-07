{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  networking.hostName = "sci-desk"; # Define your hostname.
}
