{ pkgs, config, libs, ... }:
{
  networking.hostName = "Victimus"; # Define your hostname.
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.systemPackages = with pkgs; [

  ];
  nixpkgs.config = {
    allowUnfree = true;
  };

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
}
