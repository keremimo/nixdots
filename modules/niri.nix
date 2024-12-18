{ config
, pkgs
, lib
, ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./wallpapers/wallhaven-yxdrex.png;
    targets.niri.enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  programs.niri = {
    settings =
      let
        sh = cmd: [ "sh" "-c" (lib.escape [ "\"" ] cmd) ];
      in
      {
        spawn-at-startup = [
          {
            command = sh "waybar";
          }
          {
            command = sh "mako";
          }
        ];
        prefer-no-csd = true;
        input = {
          focus-follows-mouse.enable = true;
          keyboard.repeat-delay = 220;
          keyboard.repeat-rate = 40;
        };
        layout = {
          gaps = 4;
          border.enable = false;
          focus-ring.enable = false;
          always-center-single-column = true;
        };
        window-rules = [
          {
            matches = [
              { app-id = "^.*$"; }
            ];
            draw-border-with-background = false;
            geometry-corner-radius = {
              bottom-left = 12.0;
              bottom-right = 12.0;
              top-left = 12.0;
              top-right = 12.0;
            };
            clip-to-geometry = true;
          }
        ];
        outputs = {
          "Iiyama North America PL2530H 1154394602110" = {
            position.x = 1920;
            position.y = -1080;
            mode = {
              width = 1920;
              height = 1080;
            };
          };
          "Iiyama North America PL2530H 1154394602112" = {
            position.x = -1920;
            position.y = -1080;
            mode = {
              width = 1920;
              height = 1080;
            };
          };
          "PNP(AOC) 27G2WG3- 1TMP9HA011448" = {
            position.x = 0;
            position.y = -1080;
            mode = {
              width = 1920;
              height = 1080;
            };
          };
        };
        binds = with config.lib.niri.actions; {
          "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
          "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];

          "Super+Space".action.spawn = "fuzzel";
          "Super+T".action.spawn = "ghostty";
          "Super+B".action.spawn = "firefox";
          "Super+1".action = focus-workspace 1;
          "Super+2".action = focus-workspace 2;
          "Super+3".action = focus-workspace 3;
          "Super+4".action = focus-workspace 4;

          "Super+q".action = close-window;
          "Super+Shift+q".action.quit.skip-confirmation = true;
          "Super+Equal".action = set-column-width "+10%";
          "Super+Minus".action = set-column-width "-10%";

          "Super+f".action = fullscreen-window;
          "Super+Left".action = focus-column-or-monitor-left;
          "Super+Right".action = focus-column-or-monitor-right;

          "Super+H".action = focus-column-left;
          "Super+L".action = focus-column-right;
          "Super+J".action = focus-window-down-or-column-left;
          "Super+K".action = focus-window-up-or-column-right;
          "Print".action = screenshot;
        };
      };
  };
}
