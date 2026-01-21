{ pkgs, lib, ... }:
{
  # Legion-specific Hyprland overrides for NVIDIA RTX 4080 + Intel iGPU hybrid
  # This extends the base Hyprland config from modules/home/desktop/hyprland.nix

  wayland.windowManager.hyprland.settings = {
    # Add NVIDIA-specific environment variables
    env = lib.mkAfter [
      # NVIDIA hybrid graphics
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_GSYNC_ALLOWED,1"
      "__GL_VRR_ALLOWED,1"
    ];

    # Legion display override (adjust based on your model)
    monitor = lib.mkForce [
      "eDP-1,preferred,auto,1.33"  # Built-in Legion display
      ",preferred,auto,1"          # Auto-detect external monitors
    ];

    # Enable VRR for gaming
    misc = {
      vrr = lib.mkForce 2;  # Always enable VRR
      vfr = lib.mkForce true;
    };

    # Add gaming-specific window rules
    windowrulev2 = lib.mkAfter [
      # Immediate tearing for gaming (zero latency)
      "immediate, class:^(steam_app_).*"
      "immediate, class:^(cs2)$"
      "immediate, class:^(dota2)$"
      "immediate, title:^(.*Minecraft.*)$"
    ];

    # NVIDIA-specific render settings
    render = {
      direct_scanout = true;
    };
  };

  # Add nvidia-run script for manual GPU offload
  home.packages = with pkgs; [
    (writeShellScriptBin "nvidia-run" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
