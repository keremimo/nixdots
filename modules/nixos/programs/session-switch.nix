{ pkgs, lib, ... }:
{
  # Create systemd user service for on-demand gamescope
  systemd.user.services.gamescope-gaming = {
    description = "Gamescope Gaming Session";
    # Don't auto-start - only start when called
    wantedBy = [ ];

    serviceConfig = {
      Type = "simple";
      Restart = "no";
      # Start gamescope with Steam in gamepadui mode
      ExecStart = "${pkgs.writeShellScript "start-gamescope" ''
        # Inherit display environment from Hyprland
        export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
        export DISPLAY="''${DISPLAY:-:0}"
        export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
        # Allow Steam's "Return to Desktop" button to stop the gamescope session
        export STEAM_SHUTDOWN_CMD="switch-to-desktop"

        # Performance environment variables
        export STEAM_USE_DYNAMIC_VRS=1
        export ENABLE_GAMESCOPE_WSI=1
        export DXVK_HDR=1
        export RADV_PERFTEST=gpl,nggc
        export mesa_glthread=true
        export __GL_THREADED_OPTIMIZATIONS=1

        # Run gamescope with performance optimizations
        # Use SDL backend for better nested compositor performance
        exec ${pkgs.gamescope}/bin/gamescope \
          -W 3840 -H 2160 \
          -w 3840 -h 2160 \
          -r 240 \
          --adaptive-sync \
          --hdr-enabled \
          --fullscreen \
          --force-grab-cursor \
          --steam \
          -- ${pkgs.steam}/bin/steam -gamepadui
      ''}";
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "switch-to-gaming" ''
      # Check if gamescope service is running
      if ${pkgs.systemd}/bin/systemctl --user is-active --quiet gamescope-gaming.service; then
        echo "Gamescope is already running. Focusing window..."
        ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow "class:^(gamescope)$" 2>/dev/null || true
      else
        echo "Starting gamescope gaming session..."
        ${pkgs.systemd}/bin/systemctl --user start gamescope-gaming.service
        echo "Waiting for gamescope to start..."
        sleep 2
        ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow "class:^(gamescope)$" 2>/dev/null || true
      fi
    '')

    (writeShellScriptBin "stop-gaming" ''
      echo "Stopping gamescope session..."
      ${pkgs.systemd}/bin/systemctl --user stop gamescope-gaming.service
    '')

    (writeShellScriptBin "gaming-status" ''
      echo "Gamescope service status:"
      ${pkgs.systemd}/bin/systemctl --user status gamescope-gaming.service --no-pager
      echo ""
      echo "Recent logs:"
      ${pkgs.systemd}/bin/journalctl --user -u gamescope-gaming.service -n 20 --no-pager
    '')

    (writeShellScriptBin "gaming-with-obs" ''
      echo "Starting gamescope with OBS capture enabled..."
      export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
      export DISPLAY="''${DISPLAY:-:0}"
      export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
      export STEAM_SHUTDOWN_CMD="switch-to-desktop"

      ${pkgs.obs-studio-plugins.obs-vkcapture}/bin/obs-gamecapture \
        ${pkgs.gamescope}/bin/gamescope \
          -W 3840 -H 2160 \
          -w 3840 -h 2160 \
          -r 240 \
          --adaptive-sync \
          --hdr-enabled \
          --prefer-output DP-1 \
          --fullscreen \
          --force-grab-cursor \
          --immediate-flips \
          --steam \
          -- ${pkgs.steam}/bin/steam -gamepadui
    '')
  ];

  # Create a desktop entry for switching to gaming mode
  environment.etc."xdg/applications/switch-to-gaming.desktop".text = ''
    [Desktop Entry]
    Name=Gaming Mode
    Comment=Launch gamescope gaming session
    Exec=switch-to-gaming
    Icon=steam
    Type=Application
    Categories=Game;System;
    Terminal=false
  '';
}
