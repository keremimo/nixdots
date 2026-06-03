{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/desktop
      ../../modules/nixos/services/desktop-media.nix
      ../../modules/nixos/services/flatpak.nix
      ../../modules/nixos/services/gpu.nix
      ../../modules/nixos/services/mosh.nix
      ../../modules/nixos/services/printing.nix
      ../../modules/nixos/services/ssh.nix
      ../../modules/nixos/services/tailscale.nix
      ../../modules/nixos/services/virtualization.nix
      ../../modules/nixos/programs/gaming.nix
      ../../modules/nixos/programs/obsstudio.nix
    ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  networking.hostName = "sci-desk"; # Define your hostname.
}
