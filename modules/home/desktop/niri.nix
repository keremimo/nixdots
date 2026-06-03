{ lib, pkgs, ... }:
{
  home.activation.dmsSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup colors
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup layout
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup alttab
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup binds
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup outputs
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup cursor
    $DRY_RUN_CMD ${pkgs.dms-shell}/bin/dms setup windowrules
  '';

  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "awww-daemon"
    spawn-at-startup "sh" "-c" "awww img ~/dotfiles/Wallpapers/wallhaven-6dygpl.jpg"

    prefer-no-csd

    include "dms/colors.kdl"
    include "dms/layout.kdl"
    include "dms/alttab.kdl"
    include "dms/binds.kdl"

    environment {
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORM "wayland"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        QT_QPA_PLATFORMTHEME "gtk3"
        QT_QPA_PLATFORMTHEME_QT6 "gtk3"
    }

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
        background-color "transparent"
        border { off; }
        focus-ring { off; }
        always-center-single-column
    }

    layer-rule {
        match namespace="^quickshell$"
        place-within-backdrop true
    }

    layer-rule {
        match namespace="dms:blurwallpaper"
        place-within-backdrop true
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
