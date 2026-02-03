{ pkgs, ... }:
{
  # XDG Desktop Portal configuration for Hyprland
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.ScreenCast=hyprland
    org.freedesktop.impl.portal.Screenshot=hyprland
    org.freedesktop.impl.portal.GlobalShortcuts=hyprland
  '';

  # Hyprpaper configuration
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Wallpapers/137722971_p0.jpg
    wallpaper = ,~/Wallpapers/137722971_p0.jpg
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # Monitor configuration
      monitor = [
        "eDP-1,highrr,0x0,1"
        "desc:Microstep MPG321UX OLED 0x01010101,3840x2160@240,0x0,1.5"
        "desc:GWD ARZOPA 0000001186600,highrr@,300x1440,1"
      ];

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Banana"
        "QT_QPA_PLATFORM,wayland;xcb"
        "CLUTTER_BACKEND,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "MOZ_ENABLE_WAYLAND,1"
        "STEAM_USE_DYNAMIC_VRS,1"
      ];

      # Program variables
      "$terminal" = "ghostty";
      "$fileManager" = "dolphin";
      "$menu" = "fuzzel";
      "$browser" = "google-chrome-stable";
      "$mainMod" = "SUPER";

      # Autostart programs
      exec-once = [
        "waybar"
        "swww-daemon"
        "swaync"
        "hyprpaper"
        "hyprctl setcursor Banana 24"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Banana'"
        "nm-applet --indicator & disown"
        "udiskie"
        "systemctl --user start xdg-desktop-portal-hyprland.service"
      ];

      # General settings
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 5;
          passes = 1;
          new_optimizations = true;
          vibrancy = 0.0696;
        };
      };

      # Animations
      animations = {
        enabled = false;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # XWayland
      xwayland = {
        force_zero_scaling = true;
        use_nearest_neighbor = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        vfr = true;
      };

      # Input configuration
      input = {
        kb_layout = "us";
        scroll_factor = 0.5;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        repeat_rate = 40;
        repeat_delay = 230;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.2;
        };
      };

      # Per-device input configs
      device = [
        {
          name = "tpps/2-ibm-trackpoint";
          sensitivity = 1;
        }
        {
          name = "synaptics-tm3276-022";
          sensitivity = 0.5;
        }
      ];

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:blueman-manager"
        "float, class:pavucontrol"
        "float, class:nm-connection-editor"

        # Steam-specific rules
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "immediate, class:^(steam_app_).*"
        "nofocus, class:^(steam)$, title:^(notificationtoasts.*)$"

        # Gamescope rules
        "fullscreen, class:^(gamescope)$"
        "immediate, class:^(gamescope)$"
        "noborder, class:^(gamescope)$"
        "noanim, class:^(gamescope)$"
      ];

      # Keybindings
      bind = [
        # Program launches
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, C, exec, $browser"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating,"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, J, togglesplit,"
        "$mainMod, RETURN, fullscreen,"
        "$mainMod SHIFT, G, exec, switch-to-gaming"

        # Move focus
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Workspace navigation
        "$mainMod ctrl, right, movetoworkspace, +1"
        "$mainMod ctrl, left, movetoworkspace, -1"
        "$mainMod, right, workspace, +1"
        "$mainMod, left, workspace, -1"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Lock screen
        "$mainMod, P, exec, swaylock"

        # Brightness controls
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # Screenshots
        "$mainMod, P, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, P, exec, grim -g \"$(slurp)\" - | magick png:- -colorspace Gray -depth 8 -resample 400x400 tif:- | tesseract --oem 2 --psm 6 -l eng - - | wl-copy"
      ];

      # Repeatable binds for volume
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      # Locked binds for media
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        ", mouse:277, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
