{ config
, pkgs
, lib
, ...
}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/yx/wallhaven-yxdrex.png";
      sha256 = "sha256-lLpIOKdyH4YaIO1Yw0wxWGhTEPYdSMLzMedoDQ5ko/o=";
    };
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
            command = sh "swaync";
          }
          {
            command = sh "swww-daemon";
          }
          {
            command = sh "swww img ~/dotfiles/Wallpapers/wallhaven-6dygpl.jpg";
          }
        ];
        prefer-no-csd = true;
        input = {
          focus-follows-mouse.enable = true;
          keyboard.repeat-delay = 220;
          keyboard.repeat-rate = 40;
          mouse = {
            accel-profile = "flat";
            scroll-button = 274;
            scroll-factor = 0.5;
            scroll-method = "on-button-down";
          };
          touchpad = {
            accel-profile = "flat";
            scroll-factor = 0.5;
          };
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
        binds = with config.lib.niri.actions;
          let
            shoot = spawn "sh" "-c";
          in
          {
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
            "Super+Equal".action = set-column-width "+5%";
            "Super+Minus".action = set-column-width "-5%";

            "Super+f".action = fullscreen-window;
            "Super+Left".action = focus-column-or-monitor-left;
            "Super+Right".action = focus-column-or-monitor-right;
            "Super+Shift+Left".action = move-column-left;
            "Super+Shift+Right".action = move-column-right;

            "Super+C".action = center-column;
            "Super+W".action = consume-window-into-column;
            "Super+E".action = expel-window-from-column;

            "Super+H".action = focus-column-left;
            "Super+L".action = focus-column-right;
            "Super+J".action = focus-workspace-down;
            "Super+K".action = focus-workspace-up;
            "Print".action = shoot ''grim -g "$(slurp)" - | wl-copy'';
            "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "+5%" ];
            "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];
          };
      };
  };
}
