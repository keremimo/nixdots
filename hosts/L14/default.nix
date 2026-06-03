{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./l14-hardware.nix
      ../../modules/nixos/desktop
      ../../modules/nixos/services/flatpak.nix
      ../../modules/nixos/services/mosh.nix
      ../../modules/nixos/services/printing.nix
      ../../modules/nixos/services/ssh.nix
      ../../modules/nixos/services/tailscale.nix
      ../../modules/nixos/services/virtualization.nix
    ];

  networking.hostName = "L14"; # Define your hostname.
}
