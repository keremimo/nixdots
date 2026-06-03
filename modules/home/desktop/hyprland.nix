{ lib, pkgs, ... }:
let
  lua = lib.generators.mkLuaInline;

  mainMod = "SUPER";
  terminal = "ghostty";
  fileManager = "dolphin";
  menu = "fuzzel";
  browser = "google-chrome-stable";

  execExpr = command: "hl.dsp.exec_cmd(${builtins.toJSON command})";
  exec = command: lua (execExpr command);
  bind = keys: action: { _args = [ keys (lua action) ]; };
  bindExec = keys: command: { _args = [ keys (exec command) ]; };
  bindFlag = keys: action: flags: { _args = [ keys (lua action) flags ]; };
  bindExecFlag = keys: command: flags: { _args = [ keys (exec command) flags ]; };
  hyprctl = command: execExpr "hyprctl dispatch ${command}";

  env = name: value: { _args = [ name value ]; };
  monitor = output: mode: position: scale: {
    inherit output mode position scale;
  };
in
{
  home.packages = [
    pkgs.dms-shell
  ];

  # XDG Desktop Portal configuration for Hyprland
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.ScreenCast=hyprland
    org.freedesktop.impl.portal.Screenshot=hyprland
    org.freedesktop.impl.portal.GlobalShortcuts=hyprland
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "lua";

    settings = {
      monitor = [
        (monitor "eDP-1" "highrr" "0x0" 1)
        (monitor "desc:Microstep MPG321UX OLED 0x01010101" "3840x2160@240" "0x0" 1.5)
        (monitor "desc:GWD ARZOPA 0000001186600" "highrr" "300x1440" 1)
      ];

      env = [
        (env "XCURSOR_SIZE" "24")
        (env "HYPRCURSOR_SIZE" "24")
        (env "HYPRCURSOR_THEME" "Banana")
        (env "QT_QPA_PLATFORM" "wayland;xcb")
        (env "CLUTTER_BACKEND" "wayland")
        (env "GDK_BACKEND" "wayland,x11,*")
        (env "XDG_CURRENT_DESKTOP" "Hyprland")
        (env "XDG_SESSION_TYPE" "wayland")
        (env "XDG_SESSION_DESKTOP" "Hyprland")
        (env "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1")
        (env "MOZ_ENABLE_WAYLAND" "1")
        (env "STEAM_USE_DYNAMIC_VRS" "1")
      ];

      config = {
        general = {
          gaps_in = 3;
          gaps_out = 3;
          border_size = 1;
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

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

        animations = {
          enabled = false;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        xwayland = {
          force_zero_scaling = true;
          use_nearest_neighbor = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          vfr = true;
        };

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
      };

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];

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

      window_rule = [
        {
          match = { class = ".*"; };
          suppress_event = "maximize";
        }
        {
          match = { class = "blueman-manager"; };
          float = true;
        }
        {
          match = { class = "pavucontrol"; };
          float = true;
        }
        {
          match = { class = "nm-connection-editor"; };
          float = true;
        }
        {
          match = {
            class = "steam";
            title = "^()$";
          };
          stay_focused = true;
          min_size = [ 1 1 ];
        }
        {
          match = { class = "steam_app_.*"; };
          immediate = true;
        }
        {
          match = {
            class = "steam";
            title = "notificationtoasts.*";
          };
          no_focus = true;
        }
        {
          match = { class = "gamescope"; };
          fullscreen = true;
          immediate = true;
          border_size = 0;
          no_anim = true;
        }
      ];

      bind = [
        (bindExec "${mainMod} + T" terminal)
        (bind "${mainMod} + Q" "hl.dsp.window.close()")
        (bindExec "${mainMod} + C" browser)
        (bind "${mainMod} + M" "hl.dsp.exit()")
        (bindExec "${mainMod} + E" fileManager)
        (bind "${mainMod} + F" "hl.dsp.window.float()")
        (bindExec "${mainMod} + SPACE" menu)
        (bind "${mainMod} + J" (hyprctl "togglesplit"))
        (bind "${mainMod} + RETURN" "hl.dsp.window.fullscreen()")
        (bindExec "${mainMod} + SHIFT + G" "switch-to-gaming")

        (bind "${mainMod} + H" ''hl.dsp.focus({ direction = "l" })'')
        (bind "${mainMod} + L" ''hl.dsp.focus({ direction = "r" })'')
        (bind "${mainMod} + K" ''hl.dsp.focus({ direction = "u" })'')
        (bind "${mainMod} + J" ''hl.dsp.focus({ direction = "d" })'')

        (bind "${mainMod} + 1" "hl.dsp.focus({ workspace = 1 })")
        (bind "${mainMod} + 2" "hl.dsp.focus({ workspace = 2 })")
        (bind "${mainMod} + 3" "hl.dsp.focus({ workspace = 3 })")
        (bind "${mainMod} + 4" "hl.dsp.focus({ workspace = 4 })")
        (bind "${mainMod} + 5" "hl.dsp.focus({ workspace = 5 })")
        (bind "${mainMod} + 6" "hl.dsp.focus({ workspace = 6 })")
        (bind "${mainMod} + 7" "hl.dsp.focus({ workspace = 7 })")
        (bind "${mainMod} + 8" "hl.dsp.focus({ workspace = 8 })")
        (bind "${mainMod} + 9" "hl.dsp.focus({ workspace = 9 })")
        (bind "${mainMod} + 0" "hl.dsp.focus({ workspace = 10 })")

        (bind "${mainMod} + SHIFT + 1" "hl.dsp.window.move({ workspace = 1 })")
        (bind "${mainMod} + SHIFT + 2" "hl.dsp.window.move({ workspace = 2 })")
        (bind "${mainMod} + SHIFT + 3" "hl.dsp.window.move({ workspace = 3 })")
        (bind "${mainMod} + SHIFT + 4" "hl.dsp.window.move({ workspace = 4 })")
        (bind "${mainMod} + SHIFT + 5" "hl.dsp.window.move({ workspace = 5 })")
        (bind "${mainMod} + SHIFT + 6" "hl.dsp.window.move({ workspace = 6 })")
        (bind "${mainMod} + SHIFT + 7" "hl.dsp.window.move({ workspace = 7 })")
        (bind "${mainMod} + SHIFT + 8" "hl.dsp.window.move({ workspace = 8 })")
        (bind "${mainMod} + SHIFT + 9" "hl.dsp.window.move({ workspace = 9 })")
        (bind "${mainMod} + SHIFT + 0" "hl.dsp.window.move({ workspace = 10 })")

        (bind "${mainMod} + S" ''hl.dsp.workspace.toggle_special("magic")'')
        (bind "${mainMod} + SHIFT + S" ''hl.dsp.window.move({ workspace = "special:magic" })'')

        (bind "${mainMod} + CTRL + right" ''hl.dsp.window.move({ workspace = "+1" })'')
        (bind "${mainMod} + CTRL + left" ''hl.dsp.window.move({ workspace = "-1" })'')
        (bind "${mainMod} + right" ''hl.dsp.focus({ workspace = "+1" })'')
        (bind "${mainMod} + left" ''hl.dsp.focus({ workspace = "-1" })'')
        (bind "${mainMod} + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
        (bind "${mainMod} + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')

        (bindExec "${mainMod} + P" "swaylock")
        (bindExec "XF86MonBrightnessUp" "brightnessctl set +5%")
        (bindExec "XF86MonBrightnessDown" "brightnessctl set 5%-")
        (bindExec "${mainMod} + P" ''grim -g "$(slurp)" - | wl-copy'')
        (bindExec "${mainMod} + SHIFT + P" ''grim -g "$(slurp)" - | magick png:- -colorspace Gray -depth 8 -resample 400x400 tif:- | tesseract --oem 2 --psm 6 -l eng - - | wl-copy'')

        (bindExecFlag "XF86AudioRaiseVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+" {
          repeating = true;
        })
        (bindExecFlag "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" {
          repeating = true;
        })
        (bindExecFlag "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" {
          locked = true;
        })
        (bindExecFlag "XF86AudioPlay" "playerctl play-pause" {
          locked = true;
        })
        (bindExecFlag "XF86AudioPrev" "playerctl previous" {
          locked = true;
        })
        (bindExecFlag "XF86AudioNext" "playerctl next" {
          locked = true;
        })

        (bindFlag "${mainMod} + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
        (bindFlag "mouse:277" "hl.dsp.window.drag()" { mouse = true; })
        (bindFlag "${mainMod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
      ];

      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("dms")
              hl.exec_cmd("awww-daemon")
              hl.exec_cmd("hyprctl setcursor Banana 24")
              hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Banana'")
              hl.exec_cmd("nm-applet --indicator")
              hl.exec_cmd("udiskie")
              hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland.service")
            end
          '')
        ];
      };
    };
  };
}
