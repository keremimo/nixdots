{  pkgs, config, libs, ...  }:
{
    networking.hostName = "Victimus"; # Define your hostname.
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
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;

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
#   boot.extraModprobeConfig = ''
#   blacklist nouveau
#   options nouveau modeset=0
# '';
#
#   services.udev.extraRules = ''
#   # Remove NVIDIA USB xHCI Host Controller devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA USB Type-C UCSI devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA Audio devices, if present
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
#   # Remove NVIDIA VGA/3D controller devices
#   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
# '';
#   boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
}
