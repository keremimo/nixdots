# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, ...
}: {
  imports = [
    ./t480-hardware.nix
  ];

  services.displayManager.sddm = {
    enable = true;
    settings = {
      Autologin = {
        Session = "Hyprland";
        User = "kerem";
      };
    };
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  networking.hostName = "ThinkChad"; # Define your hostname.

}
