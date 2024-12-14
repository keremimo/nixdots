{  pkgs, config, libs, ...  }:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
  package = config.boot.kernelPackages.nvidiaPackages.beta;
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;

    prime = {
      amdgpuBusId = "PCI:06:00:0";
      nvidiaBusId = "PCI:01:00:0";
      reverseSync.enable = true;
      allowExternalGpu = false;
    };

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
  };
}
