{ pkgs, ... }:
{
  home.packages = [
    pkgs.dms-shell
  ];

  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "${pkgs.dms-shell}/bin/dms"
    spawn-at-startup "awww-daemon"
    spawn-at-startup "sh" "-c" "awww img ~/dotfiles/Wallpapers/wallhaven-6dygpl.jpg"

    prefer-no-csd

    input {
        focus-follows-mouse

        keyboard {
            repeat-delay 220
            repeat-rate 40
        }

        mouse {
            accel-profile "flat"
            scroll-button 274
            scroll-factor 0.8
            scroll-method "on-button-down"
        }

        touchpad {
            accel-profile "flat"
            scroll-factor 0.5
        }
    }

    layout {
        gaps 4
        border { off; }
        focus-ring { off; }
        always-center-single-column
    }

    window-rule {
        match app-id="^.*$"
        draw-border-with-background false
        geometry-corner-radius 12.0
        clip-to-geometry true
    }

    output "DP-1" {
        position x=0 y=0
        scale 1.5
        mode "3840x2160@239.990"
    }

    output "Iiyama North America PL2530H 1154394602112" {
        position x=-1920 y=-1080
        mode "1920x1080"
    }

    output "PNP(AOC) 27G2WG3- 1TMP9HA011448" {
        position x=0 y=-1080
        mode "1920x1080"
    }

    binds {
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }

        Mod+Space { spawn "fuzzel"; }
        Mod+T { spawn "kitty"; }
        Mod+B { spawn "firefox"; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }

        Mod+Q { close-window; }
        Mod+Shift+Q { quit skip-confirmation=true; }
        Mod+Equal { set-column-width "+5%"; }
        Mod+Minus { set-column-width "-5%"; }

        Mod+F { fullscreen-window; }
        Mod+Left { focus-column-or-monitor-left; }
        Mod+Right { focus-column-or-monitor-right; }
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }

        Mod+C { center-column; }
        Mod+W { consume-window-into-column; }
        Mod+E { expel-window-from-column; }

        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+J { focus-workspace-down; }
        Mod+K { focus-workspace-up; }

        XF86MonBrightnessUp { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
    }
  '';
}
