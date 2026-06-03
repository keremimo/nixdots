{ pkgs, config, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./optimizations.nix
    ../../modules/nixos/desktop
    ../../modules/nixos/services/desktop-media.nix
    ../../modules/nixos/services/flatpak.nix
    ../../modules/nixos/services/mosh.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/ssh.nix
    ../../modules/nixos/services/tailscale.nix
    ../../modules/nixos/services/virtualization.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/programs/obsstudio.nix
  ];

  boot = {
    extraModprobeConfig = ''
      options nvidia-drm modeset=1 fbdev=1
      # NVIDIA power management for hybrid graphics
      options nvidia NVreg_DynamicPowerManagement=0x02
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
    '';
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    dynamicBoost.enable = true;
    open = true;
    forceFullCompositionPipeline = false;
    gsp.enable = true;
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  networking.hostName = "sci-supreme";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  boot.kernelModules = [ "legion_laptop" ];
}
