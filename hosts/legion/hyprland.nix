{ pkgs, ... }:
{
  # Legion-specific Hyprland configuration for NVIDIA RTX 4080 + Intel iGPU hybrid

  # Import base Hyprland configuration
  imports = [
    ../../modules/home/desktop/hyprland.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      # NVIDIA-specific environment variables for hybrid graphics
      env = [
        # Force hardware cursors (important for NVIDIA)
        "WLR_NO_HARDWARE_CURSORS,1"

        # NVIDIA-specific variables
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"

        # Disable VSync to let tearing work
        "WLR_DRM_NO_ATOMIC,1"

        # NVIDIA performance hints
        "__GL_GSYNC_ALLOWED,1"
        "__GL_VRR_ALLOWED,1"
      ];

      # Legion-specific monitor configuration (example - adjust to your setup)
      monitor = [
        # Legion typically has 2560x1600 or 1920x1200 @165Hz+ screen
        "eDP-1,preferred,auto,1.0"  # Built-in display
        ",preferred,auto,1"          # External monitors auto-detect
      ];

      # Enable variable refresh rate (VRR) for smoother gaming
      misc = {
        vrr = 2;  # 2 = always enable VRR
        vfr = true;  # Variable framerate for power saving when idle
      };

      # Window rules for gaming with NVIDIA
      windowrulev2 = [
        # Enable immediate/tearing for gaming windows (zero latency)
        "immediate, class:^(steam_app_).*"
        "immediate, class:^(cs2)$"
        "immediate, class:^(dota2)$"
        "immediate, title:^(.*Minecraft.*)$"
        "immediate, class:^(gamescope)$"

        # Full screen games
        "fullscreen, class:^(steam_app_).*"
        "fullscreen, class:^(gamescope)$"

        # No animations for games (performance)
        "noanim, class:^(steam_app_).*"
        "noanim, class:^(gamescope)$"

        # No borders for fullscreen games
        "noborder, class:^(steam_app_).*,fullscreen:1"
        "noborder, class:^(gamescope)$"

        # Pin games to workspace 10 (optional)
        # "workspace 10 silent, class:^(steam_app_).*"
      ];

      # Render settings optimized for NVIDIA
      render = {
        # Explicit sync for NVIDIA (reduces tearing in windowed mode)
        explicit_sync = 1;
        explicit_sync_kms = 1;

        # Direct scanout for fullscreen (best performance)
        direct_scanout = true;
      };

      # Cursor settings for NVIDIA
      cursor = {
        no_hardware_cursors = true;  # NVIDIA often has cursor issues
        enable_hyprcursor = true;
      };
    };
  };

  # Ensure NVIDIA offload wrapper is available for specific apps
  home.packages = with pkgs; [
    # Script to easily launch apps with NVIDIA GPU
    (pkgs.writeShellScriptBin "nvidia-run" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
