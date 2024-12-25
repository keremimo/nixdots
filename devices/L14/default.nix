{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./l14-hardware.nix
    ];

  networking.hostName = "L14"; # Define your hostname.
}
