{ config, pkgs, ... }:
{
  # NVIDIA Enabled below:
  boot = {
    extraModprobeConfig = ''
      options nvidia-drm modeset=1 nvidia-drm.fbdev=1"
    '';
    blacklistedKernelModules = [
      "nouveau"
      "amdgpu"
    ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    forceFullCompositionPipeline = false;
    gsp.enable = false;
    nvidiaSettings = true;
  };
}
