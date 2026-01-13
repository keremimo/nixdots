{ pkgs, config, libs, ... }:

{
  boot = {
    extraModprobeConfig = ''
      options nvidia-drm modeset=1 nvidia-drm.fbdev=1"
    '';
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
    ];
  };

  environment.systemPackages = with pkgs; [
    obs-studio
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true;
    dynamicBoost.enable = true;
    # powerManagement.finegrained = true;
    open = true;
    forceFullCompositionPipeline = false;
    gsp.enable = true;
    nvidiaSettings = true;
  };

  networking.hostName = "sci-supreme"; # Define your hostname.
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      NMI_WATCHDOG = 0;
      TLP_WARN_LEVEL = 3;
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "quiet";
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 1200000;
    };
  };
}
