{ pkgs, config, libs, ... }:

{
  imports = [
    ./optimizations.nix
  ];

  boot = {
    extraModprobeConfig = ''
      options nvidia-drm modeset=1 nvidia-drm.fbdev=1
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
    obs-studio
    nvtopPackages.full  # Better GPU monitoring with Intel + NVIDIA
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # Modesetting is required.
    modesetting.enable = true;

    # Critical for battery life and hybrid graphics
    powerManagement = {
      enable = true;
      finegrained = true;  # Enable fine-grained power management (NVIDIA Optimus)
    };

    dynamicBoost.enable = true;
    open = true;  # Using open-source kernel modules
    forceFullCompositionPipeline = false;
    gsp.enable = true;
    nvidiaSettings = true;

    # Hybrid graphics configuration - Use Intel by default, NVIDIA on demand
    prime = {
      # Enable PRIME offload mode for maximum battery life
      offload = {
        enable = true;
        enableOffloadCmd = true;  # Provides nvidia-offload command
      };

      # Find your bus IDs with: lspci | grep -E 'VGA|3D'
      # These are example values - you'll need to verify with lspci
      intelBusId = "PCI:0:2:0";    # Intel integrated GPU
      nvidiaBusId = "PCI:1:0:0";   # RTX 4080 discrete GPU
    };
  };

  networking.hostName = "sci-supreme"; # Define your hostname.

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver     # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver     # LIBVA_DRIVER_NAME=i965 (older but sometimes better)
      libva-vdpau-driver
      libvdpau-va-gl
      intel-compute-runtime  # OpenCL support
    ];
  };

  # Hardware video acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHd";  # Use Intel iHD driver for better efficiency
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Fan control for Legion laptops
  boot.kernelModules = [ "legion_laptop" ];

  # Note: TLP configuration is now in optimizations.nix
  # The comprehensive power management settings include:
  # - CPU frequency scaling optimized for i9-14900HX
  # - Turbo boost disabled on battery
  # - Maximum frequency limited to base clock (2.2GHz) on battery
  # - Fine-grained NVIDIA power management
  # - Aggressive power saving for all devices
  # - Battery charge thresholds (75-80%) to extend battery life
}
