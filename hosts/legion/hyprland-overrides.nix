{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = lib.mkAfter [
      "LIBVA_DRIVER_NAME,nvidia"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_GSYNC_ALLOWED,1"
      "__GL_VRR_ALLOWED,1"
    ];

    monitor = lib.mkForce [
      "eDP-1,preferred,auto,1.33"
      ",preferred,auto,1"
    ];

    misc = {
      vrr = lib.mkForce 2;
      vfr = lib.mkForce true;
    };

    windowrulev2 = lib.mkAfter [
      "immediate, class:^(steam_app_).*"
      "immediate, class:^(cs2)$"
      "immediate, class:^(dota2)$"
      "immediate, title:^(.*Minecraft.*)$"
    ];

    render = {
      direct_scanout = true;
    };
  };

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
